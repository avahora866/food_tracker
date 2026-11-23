import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'nutrition.dart';

export 'nutrition.dart';

part 'database.g.dart';

// ---------------------------------------------------------------- tables

class Ingredients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get unit => textEnum<Unit>()();
  RealColumn get refAmount => real()();
  RealColumn get refKcal => real()();
  RealColumn get refProtein => real().withDefault(const Constant(0))();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();
}

class Recipes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get defaultSlot => textEnum<Slot>().nullable()();
  DateTimeColumn get lastUsedAt => dateTime().nullable()();
}

class RecipeLines extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get recipeId =>
      integer().references(Recipes, #id, onDelete: KeyAction.cascade)();
  IntColumn get ingredientId => integer().references(Ingredients, #id)();
  RealColumn get amount => real()();
}

@DataClassName('LogEntry')
class LogEntries extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Logical day ("yyyy-MM-dd") with a 3am rollover, not a timestamp.
  TextColumn get date => text()();
  TextColumn get slot => textEnum<Slot>()();
  TextColumn get name => text()();

  /// Link only, never read for amounts. Null for quick add or deleted recipe.
  IntColumn get sourceRecipeId => integer().nullable().references(
    Recipes,
    #id,
    onDelete: KeyAction.setNull,
  )();
  RealColumn get quickKcal => real().nullable()();
  RealColumn get quickProtein => real().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  /// Number of lines when the recipe was logged; null for quick add.
  IntColumn get originalLineCount => integer().nullable()();
}

/// Snapshot of a recipe line, including the ingredient's values at log time.
class LogLines extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get entryId =>
      integer().references(LogEntries, #id, onDelete: KeyAction.cascade)();
  IntColumn get ingredientId => integer().nullable().references(
    Ingredients,
    #id,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get name => text()();
  TextColumn get unit => textEnum<Unit>()();
  RealColumn get amount => real()();

  /// Amount when logged; null for a line added while editing.
  RealColumn get originalAmount => real().nullable()();
  RealColumn get refAmount => real()();
  RealColumn get refKcal => real()();
  RealColumn get refProtein => real()();
}

// ---------------------------------------------------------------- views

extension IngredientNutr on Ingredient {
  Nutr nutrFor(double amount) => Nutr.line(
    amount: amount,
    refAmount: refAmount,
    refKcal: refKcal,
    refProtein: refProtein,
  );
}

extension LogLineNutr on LogLine {
  Nutr get nutr => Nutr.line(
    amount: amount,
    refAmount: refAmount,
    refKcal: refKcal,
    refProtein: refProtein,
  );
}

class RecipeItem {
  RecipeItem(this.ingredient, this.amount);
  final Ingredient ingredient;
  final double amount;
  Nutr get nutr => ingredient.nutrFor(amount);
}

class RecipeSummary {
  RecipeSummary(this.recipe, this.total);
  final Recipe recipe;
  final Nutr total;
}

class EntryView {
  EntryView(this.entry, this.lines, {required this.edited});
  final LogEntry entry;
  final List<LogLine> lines;

  /// Derived: lines differ from the source recipe's current lines.
  final bool edited;

  bool get isQuick => entry.quickKcal != null;
  Nutr get total => isQuick
      ? Nutr(entry.quickKcal!, entry.quickProtein ?? 0)
      : lines.map((l) => l.nutr).sum;
}

class DeletedEntry {
  DeletedEntry(this.entry, this.lines);
  final LogEntry entry;
  final List<LogLine> lines;
}

// ---------------------------------------------------------------- database

@DriftDatabase(
  tables: [Ingredients, Recipes, RecipeLines, LogEntries, LogLines],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'food_tracker'));

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.addColumn(logEntries, logEntries.originalLineCount);
        await m.addColumn(logLines, logLines.originalAmount);
      }
    },
    beforeOpen: (_) => customStatement('PRAGMA foreign_keys = ON'),
  );

  /// Emits once now and again whenever any of [tables] changes.
  Stream<T> _watch<T>(Set<TableInfo> tables, Future<T> Function() load) =>
      customSelect(
        'SELECT 1',
        readsFrom: tables,
      ).watch().asyncMap((_) => load());

  // ---------------------------------------------------------- ingredients

  Stream<List<Ingredient>> watchIngredients() =>
      (select(ingredients)
            ..where((i) => i.archived.equals(false))
            ..orderBy([(i) => OrderingTerm(expression: i.name.lower())]))
          .watch();

  Future<int> saveIngredient(IngredientsCompanion c) =>
      into(ingredients).insertOnConflictUpdate(c);

  /// Hidden, not deleted, so recipes using it keep working.
  Future<void> archiveIngredient(int id) =>
      (update(ingredients)..where((i) => i.id.equals(id))).write(
        const IngredientsCompanion(archived: Value(true)),
      );

  // ---------------------------------------------------------- recipes

  Stream<List<RecipeSummary>> watchRecipes() =>
      _watch({recipes, recipeLines, ingredients}, () async {
        final all = await select(recipes).get();
        final items = await _itemsByRecipe();
        return [
          for (final r in all)
            RecipeSummary(r, (items[r.id] ?? []).map((i) => i.nutr).sum),
        ];
      });

  Future<Map<int, List<RecipeItem>>> _itemsByRecipe([List<int>? ids]) async {
    final q = select(recipeLines).join([
      innerJoin(
        ingredients,
        ingredients.id.equalsExp(recipeLines.ingredientId),
      ),
    ])..orderBy([OrderingTerm(expression: recipeLines.id)]);
    if (ids != null) q.where(recipeLines.recipeId.isIn(ids));
    final map = <int, List<RecipeItem>>{};
    for (final row in await q.get()) {
      final line = row.readTable(recipeLines);
      map
          .putIfAbsent(line.recipeId, () => [])
          .add(RecipeItem(row.readTable(ingredients), line.amount));
    }
    return map;
  }

  Future<Recipe> getRecipe(int id) =>
      (select(recipes)..where((r) => r.id.equals(id))).getSingle();

  Future<List<RecipeItem>> recipeItems(int recipeId) async =>
      (await _itemsByRecipe([recipeId]))[recipeId] ?? [];

  /// Inserts or replaces a recipe and its lines. Never touches log entries.
  Future<int> saveRecipe({
    int? id,
    required String name,
    Slot? defaultSlot,
    required List<(int ingredientId, double amount)> lines,
  }) => transaction(() async {
    final rid =
        id ??
        await into(recipes).insert(
          RecipesCompanion.insert(name: name, defaultSlot: Value(defaultSlot)),
        );
    if (id != null) {
      await (update(recipes)..where((r) => r.id.equals(id))).write(
        RecipesCompanion(name: Value(name), defaultSlot: Value(defaultSlot)),
      );
      await (delete(recipeLines)..where((l) => l.recipeId.equals(id))).go();
    }
    await batch(
      (b) => b.insertAll(recipeLines, [
        for (final (ing, amt) in lines)
          RecipeLinesCompanion.insert(
            recipeId: rid,
            ingredientId: ing,
            amount: amt,
          ),
      ]),
    );
    return rid;
  });

  Future<int> duplicateRecipe(int id) async {
    final r = await getRecipe(id);
    final items = await recipeItems(id);
    return saveRecipe(
      name: '${r.name} (copy)',
      defaultSlot: r.defaultSlot,
      lines: [for (final i in items) (i.ingredient.id, i.amount)],
    );
  }

  /// Past entries survive: they are copies, and their link is set to null.
  Future<void> deleteRecipe(int id) =>
      (delete(recipes)..where((r) => r.id.equals(id))).go();

  // ---------------------------------------------------------- log

  Stream<List<EntryView>> watchDay(String date) =>
      _watch({logEntries, logLines}, () => _loadDay(date));

  Future<List<EntryView>> _loadDay(String date) async {
    final entries =
        await (select(logEntries)
              ..where((e) => e.date.equals(date))
              ..orderBy([
                (e) => OrderingTerm(expression: e.sortOrder),
                (e) => OrderingTerm(expression: e.id),
              ]))
            .get();
    if (entries.isEmpty) return [];
    final lines =
        await (select(logLines)
              ..where((l) => l.entryId.isIn(entries.map((e) => e.id)))
              ..orderBy([(l) => OrderingTerm(expression: l.id)]))
            .get();
    return [
      for (final e in entries)
        () {
          final own = lines.where((l) => l.entryId == e.id).toList();
          return EntryView(e, own, edited: _isEdited(e, own));
        }(),
    ];
  }

  /// Derived: the entry's lines differ from the snapshot taken when it was
  /// logged. Later recipe edits never affect this.
  static bool _isEdited(LogEntry e, List<LogLine> lines) {
    final count = e.originalLineCount;
    if (count == null) return false;
    return lines.length != count ||
        lines.any(
          (l) =>
              l.originalAmount == null ||
              (l.amount - l.originalAmount!).abs() > 1e-9,
        );
  }

  Future<int> _nextSortOrder(String date, Slot slot) async {
    final max = logEntries.sortOrder.max();
    final row =
        await (selectOnly(logEntries)
              ..addColumns([max])
              ..where(
                logEntries.date.equals(date) &
                    logEntries.slot.equalsValue(slot),
              ))
            .getSingle();
    return (row.read(max) ?? -1) + 1;
  }

  /// [original] marks the line as part of the logged snapshot.
  LogLinesCompanion _snapshot(
    int entryId,
    Ingredient ing,
    double amount, {
    bool original = true,
  }) => LogLinesCompanion.insert(
    entryId: entryId,
    ingredientId: Value(ing.id),
    name: ing.name,
    unit: ing.unit,
    amount: amount,
    originalAmount: Value(original ? amount : null),
    refAmount: ing.refAmount,
    refKcal: ing.refKcal,
    refProtein: ing.refProtein,
  );

  /// The snapshot rule: copy the recipe's lines and the ingredients' current
  /// values into the entry. From here on the two are independent.
  Future<int> addRecipeToDay(
    int recipeId,
    String date,
    Slot slot, {
    DateTime? now,
  }) => transaction(() async {
    final r = await getRecipe(recipeId);
    final items = await recipeItems(recipeId);
    final id = await into(logEntries).insert(
      LogEntriesCompanion.insert(
        date: date,
        slot: slot,
        name: r.name,
        sourceRecipeId: Value(recipeId),
        sortOrder: Value(await _nextSortOrder(date, slot)),
        originalLineCount: Value(items.length),
      ),
    );
    await batch(
      (b) => b.insertAll(logLines, [
        for (final i in items) _snapshot(id, i.ingredient, i.amount),
      ]),
    );
    await (update(recipes)..where((x) => x.id.equals(recipeId))).write(
      RecipesCompanion(lastUsedAt: Value(now ?? DateTime.now())),
    );
    return id;
  });

  Future<int> addQuick(
    String date,
    Slot slot, {
    required String name,
    required double kcal,
    double? protein,
  }) async => into(logEntries).insert(
    LogEntriesCompanion.insert(
      date: date,
      slot: slot,
      name: name,
      quickKcal: Value(kcal),
      quickProtein: Value(protein),
      sortOrder: Value(await _nextSortOrder(date, slot)),
    ),
  );

  Future<void> updateQuick(
    int id, {
    required String name,
    required double kcal,
    double? protein,
  }) => (update(logEntries)..where((e) => e.id.equals(id))).write(
    LogEntriesCompanion(
      name: Value(name),
      quickKcal: Value(kcal),
      quickProtein: Value(protein),
    ),
  );

  Future<LogEntry> getEntry(int id) =>
      (select(logEntries)..where((e) => e.id.equals(id))).getSingle();

  Future<List<LogLine>> entryLines(int entryId) =>
      (select(logLines)
            ..where((l) => l.entryId.equals(entryId))
            ..orderBy([(l) => OrderingTerm(expression: l.id)]))
          .get();

  Future<void> updateLineAmount(int lineId, double amount) =>
      (update(logLines)..where((l) => l.id.equals(lineId))).write(
        LogLinesCompanion(amount: Value(amount)),
      );

  Future<int> addLine(int entryId, Ingredient ing, double amount) =>
      into(logLines).insert(_snapshot(entryId, ing, amount, original: false));

  Future<void> deleteLine(int lineId) =>
      (delete(logLines)..where((l) => l.id.equals(lineId))).go();

  Future<void> scaleEntry(int entryId, double factor) => customUpdate(
    'UPDATE log_lines SET amount = amount * ? WHERE entry_id = ?',
    variables: [Variable.withReal(factor), Variable.withInt(entryId)],
    updates: {logLines},
  );

  /// Re-copies the source recipe's current lines as a fresh snapshot.
  /// The recipe is unchanged.
  Future<void> resetEntryToRecipe(int entryId) => transaction(() async {
    final e = await getEntry(entryId);
    if (e.sourceRecipeId == null) return;
    final items = await recipeItems(e.sourceRecipeId!);
    await (delete(logLines)..where((l) => l.entryId.equals(entryId))).go();
    await (update(logEntries)..where((x) => x.id.equals(entryId))).write(
      LogEntriesCompanion(originalLineCount: Value(items.length)),
    );
    await batch(
      (b) => b.insertAll(logLines, [
        for (final i in items) _snapshot(entryId, i.ingredient, i.amount),
      ]),
    );
  });

  /// Turns this entry's lines into a new recipe, links the entry to it and
  /// makes the current lines its new snapshot.
  Future<int> saveEntryAsRecipe(int entryId, String name) =>
      transaction(() async {
        final e = await getEntry(entryId);
        final lines = await entryLines(entryId);
        await customUpdate(
          'UPDATE log_lines SET original_amount = amount WHERE entry_id = ?',
          variables: [Variable.withInt(entryId)],
          updates: {logLines},
        );
        final rid = await saveRecipe(
          name: name,
          defaultSlot: e.slot,
          lines: [
            for (final l in lines)
              if (l.ingredientId != null) (l.ingredientId!, l.amount),
          ],
        );
        await (update(logEntries)..where((x) => x.id.equals(entryId))).write(
          LogEntriesCompanion(
            name: Value(name),
            sourceRecipeId: Value(rid),
            originalLineCount: Value(lines.length),
          ),
        );
        return rid;
      });

  Future<DeletedEntry> deleteEntry(int id) => transaction(() async {
    final deleted = DeletedEntry(await getEntry(id), await entryLines(id));
    await (delete(logEntries)..where((e) => e.id.equals(id))).go();
    return deleted;
  });

  Future<void> restoreEntry(DeletedEntry d) => transaction(() async {
    final rid = d.entry.sourceRecipeId;
    final recipeExists =
        rid != null &&
        await (select(
              recipes,
            )..where((r) => r.id.equals(rid))).getSingleOrNull() !=
            null;
    await into(logEntries).insert(
      recipeExists
          ? d.entry
          : d.entry.copyWith(sourceRecipeId: const Value(null)),
    );
    await batch((b) => b.insertAll(logLines, d.lines));
  });
}
