import 'package:flutter_test/flutter_test.dart';
import 'package:food_tracker/data/nutrition.dart';

void main() {
  test('logical day rolls over at 3am', () {
    expect(logicalDay(DateTime(2026, 11, 24, 1, 30)), DateTime(2026, 11, 23));
    expect(logicalDay(DateTime(2026, 11, 24, 3)), DateTime(2026, 11, 24));
    expect(logicalDay(DateTime(2026, 1, 1, 2)), DateTime(2025, 12, 31));
    expect(dayKey(DateTime(2026, 3, 4)), '2026-03-04');
  });

  test('parses fractions and decimals', () {
    expect(parseAmount('45'), 45);
    expect(parseAmount('0.5'), 0.5);
    expect(parseAmount('1,5'), 1.5);
    expect(parseAmount('1/3'), closeTo(0.3333, 0.001));
    expect(parseAmount('1 1/2'), 1.5);
    for (final bad in ['', 'abc', '1/0', '1/', '-2', '1/2 3']) {
      expect(parseAmount(bad), isNull, reason: bad);
    }
  });

  test('line formula', () {
    final n = Nutr.line(
      amount: 30,
      refAmount: 100,
      refKcal: 389,
      refProtein: 13,
    );
    expect(n.kcal, closeTo(116.7, 1e-9));
    expect(n.protein, closeTo(3.9, 1e-9));
    expect(formatAmount(30), '30');
    expect(formatAmount(1 / 3), '0.33');
    expect(formatAmount(1.5), '1.5');
  });
}
