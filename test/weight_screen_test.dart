import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_tracker/weight/weight_entry.dart';
import 'package:food_tracker/weight/weight_repository.dart';
import 'package:food_tracker/weight/weight_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('logging a weight saves it, hides the banner and notifies', (
    tester,
  ) async {
    List<WeightEntry>? changed;
    await tester.pumpWidget(
      MaterialApp(
        home: WeightScreen(
          repository: WeightRepository(),
          onChanged: (e) => changed = e,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('No weigh-in yet'), findsOneWidget);
    expect(find.text('No measurements yet.'), findsOneWidget);

    await tester.tap(find.text('Log weight'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '72,4');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('72.4 kg'), findsOneWidget);
    expect(find.textContaining('No weigh-in yet'), findsNothing);
    expect(changed, hasLength(1));
    expect((await WeightRepository().load()).single.kg, 72.4);
  });

  testWidgets('shows change from the previous entry', (tester) async {
    final repo = WeightRepository();
    await repo.add(WeightEntry(id: 'a', date: DateTime(2026, 1, 1), kg: 80));
    await repo.add(WeightEntry(id: 'b', date: DateTime(2026, 2, 1), kg: 78.5));

    await tester.pumpWidget(MaterialApp(home: WeightScreen(repository: repo)));
    await tester.pumpAndSettle();

    expect(find.text('-1.5 kg'), findsOneWidget);
  });
}
