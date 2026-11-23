import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/database.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

/// Entries for one logical day, keyed by "yyyy-MM-dd".
final dayProvider = StreamProvider.autoDispose.family<List<EntryView>, String>(
  (ref, day) => ref.watch(databaseProvider).watchDay(day),
);

final recipesProvider = StreamProvider<List<RecipeSummary>>(
  (ref) => ref.watch(databaseProvider).watchRecipes(),
);

final ingredientsProvider = StreamProvider<List<Ingredient>>(
  (ref) => ref.watch(databaseProvider).watchIngredients(),
);
