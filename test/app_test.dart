import 'package:drift/drift.dart' show DatabaseConnection, Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_tracker/data/database.dart';
import 'package:food_tracker/main.dart';
import 'package:food_tracker/providers.dart';

void main() {
  testWidgets('log a meal, edit its portion, delete and undo', (tester) async {
    final db = AppDatabase(
      DatabaseConnection(
        NativeDatabase.memory(),
        closeStreamsSynchronously: true,
      ),
    );
    addTearDown(db.close);
    await tester.runAsync(() async {
      final oats = await db.saveIngredient(
        IngredientsCompanion.insert(
          name: 'Oats',
          unit: Unit.g,
          refAmount: 100,
          refKcal: 389,
          refProtein: const Value(13),
        ),
      );
      await db.saveRecipe(name: 'Oatmeal', lines: [(oats, 30)]);
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(db)],
        child: const FoodTrackerApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Today'), findsOneWidget);

    // Add from the Breakfast section.
    await tester.tap(find.byTooltip('Add to Breakfast'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Oatmeal'));
    await tester.pumpAndSettle();
    expect(find.text('117 kcal · 4 g'), findsWidgets);

    // Edit the portion: 30 g -> 45 g.
    await tester.tap(find.text('Oatmeal'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '45');
    await tester.pumpAndSettle();
    expect(find.text('175 kcal · 6 g'), findsWidgets);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('edited'), findsOneWidget);
    expect(find.text('175'), findsOneWidget);

    // Swipe to delete, then undo.
    await tester.drag(find.text('Oatmeal'), const Offset(-500, 0));
    await tester.pumpAndSettle();
    expect(find.text('Oatmeal'), findsNothing);
    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    expect(find.text('Oatmeal'), findsOneWidget);
  });
}
