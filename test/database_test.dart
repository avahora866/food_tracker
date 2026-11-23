import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_tracker/data/database.dart';

void main() {
  late AppDatabase db;
  late int oats, milk, oatmeal;
  const day = '2026-11-23';

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    oats = await db.saveIngredient(
      IngredientsCompanion.insert(
        name: 'Oats',
        unit: Unit.g,
        refAmount: 100,
        refKcal: 389,
        refProtein: const Value(13),
      ),
    );
    milk = await db.saveIngredient(
      IngredientsCompanion.insert(
        name: 'Milk',
        unit: Unit.ml,
        refAmount: 100,
        refKcal: 50,
        refProtein: const Value(3.6),
      ),
    );
    oatmeal = await db.saveRecipe(
      name: 'Oatmeal',
      lines: [(oats, 30), (milk, 200)],
    );
  });
  tearDown(() => db.close());

  Future<EntryView> only() async => (await db.watchDay(day).first).single;

  test('adding a recipe snapshots its lines', () async {
    await db.addRecipeToDay(oatmeal, day, Slot.breakfast);
    final e = await only();
    expect(e.total.kcal, closeTo(116.7 + 100, 0.01));
    expect(e.total.protein, closeTo(3.9 + 7.2, 0.01));
    expect(e.edited, isFalse);
    expect((await db.getRecipe(oatmeal)).lastUsedAt, isNotNull);
  });

  test(
    'editing the entry leaves the recipe alone and marks it edited',
    () async {
      await db.addRecipeToDay(oatmeal, day, Slot.breakfast);
      final line = (await only()).lines.firstWhere((l) => l.name == 'Oats');
      await db.updateLineAmount(line.id, 45);
      final e = await only();
      expect(e.edited, isTrue);
      expect(e.total.kcal, closeTo(175.05 + 100, 0.01));
      final items = await db.recipeItems(oatmeal);
      expect(items.firstWhere((i) => i.ingredient.id == oats).amount, 30);
    },
  );

  test(
    'editing the recipe or ingredient never changes existing entries',
    () async {
      await db.addRecipeToDay(oatmeal, day, Slot.breakfast);
      final before = (await only()).total.kcal;
      await db.saveRecipe(id: oatmeal, name: 'Oatmeal', lines: [(oats, 80)]);
      await db.saveIngredient(
        IngredientsCompanion(
          id: Value(oats),
          name: const Value('Oats'),
          unit: const Value(Unit.g),
          refAmount: const Value(100),
          refKcal: const Value(999),
          refProtein: const Value(13),
        ),
      );
      expect((await only()).total.kcal, before);
    },
  );

  test('reset re-copies the recipe; scale multiplies every line', () async {
    final id = await db.addRecipeToDay(oatmeal, day, Slot.breakfast);
    await db.scaleEntry(id, 1.5);
    expect((await only()).total.kcal, closeTo(216.7 * 1.5, 0.01));
    await db.resetEntryToRecipe(id);
    expect((await only()).edited, isFalse);
  });

  test('deleting a recipe keeps entries; delete and undo an entry', () async {
    final id = await db.addRecipeToDay(oatmeal, day, Slot.breakfast);
    await db.deleteRecipe(oatmeal);
    var e = await only();
    expect(e.entry.sourceRecipeId, isNull);
    expect(e.lines, hasLength(2));
    final d = await db.deleteEntry(id);
    expect(await db.watchDay(day).first, isEmpty);
    await db.restoreEntry(d);
    e = await only();
    expect(e.lines, hasLength(2));
  });

  test('quick add and save as recipe', () async {
    await db.addQuick(day, Slot.lunch, name: 'Sandwich', kcal: 450);
    expect((await only()).total.kcal, 450);
    final id = await db.addRecipeToDay(oatmeal, day, Slot.dinner);
    await db.scaleEntry(id, 2);
    final rid = await db.saveEntryAsRecipe(id, 'Big oatmeal');
    final view = (await db.watchDay(day).first).firstWhere(
      (e) => e.entry.id == id,
    );
    expect(view.entry.sourceRecipeId, rid);
    expect(view.edited, isFalse);
  });
}
