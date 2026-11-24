/// Pure helpers for units, slots, calorie maths and the logical day.
library;

enum Unit { g, ml, piece, cup, tbsp, tsp }

extension UnitX on Unit {
  /// Reference amount an ingredient's kcal/protein are given for.
  double get defaultRefAmount => (this == Unit.g || this == Unit.ml) ? 100 : 1;
}

enum Slot { breakfast, lunch, dinner, snack }

extension SlotX on Slot {
  String get label => name[0].toUpperCase() + name.substring(1);
}

/// Calories and protein. Stored values keep decimals; round only for display.
class Nutr {
  const Nutr(this.kcal, this.protein);
  static const zero = Nutr(0, 0);

  final double kcal;
  final double protein;

  Nutr operator +(Nutr o) => Nutr(kcal + o.kcal, protein + o.protein);

  /// line value = amount / reference amount × reference value
  factory Nutr.line({
    required double amount,
    required double refAmount,
    required double refKcal,
    required double refProtein,
  }) {
    if (refAmount <= 0) return zero;
    final f = amount / refAmount;
    return Nutr(f * refKcal, f * refProtein);
  }

  String get label => '${kcal.round()} kcal · ${protein.round()} g';
}

extension NutrSum on Iterable<Nutr> {
  Nutr get sum => fold(Nutr.zero, (a, b) => a + b);
}

/// Day boundary is 3am: 01:30 on the 24th belongs to the 23rd.
DateTime logicalDay(DateTime now) =>
    DateTime(now.year, now.month, now.day - (now.hour < 3 ? 1 : 0));

/// Storage key for a logical day, e.g. "2026-11-23".
String dayKey(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

/// Parses "45", "0.5", "1,5", "1/3" or "1 1/2". Returns null if invalid.
double? parseAmount(String input) {
  final s = input.trim().replaceAll(',', '.');
  if (s.isEmpty) return null;
  double? frac(String p) {
    final parts = p.split('/');
    if (parts.length == 1) return double.tryParse(p);
    if (parts.length != 2) return null;
    final n = double.tryParse(parts[0]), d = double.tryParse(parts[1]);
    return (n == null || d == null || d == 0) ? null : n / d;
  }

  final words = s.split(RegExp(r'\s+'));
  double? v;
  if (words.length == 1) {
    v = frac(words[0]);
  } else if (words.length == 2 && !words[0].contains('/')) {
    final whole = double.tryParse(words[0]), f = frac(words[1]);
    v = (whole == null || f == null) ? null : whole + f;
  }
  return (v == null || v < 0 || v.isNaN || v.isInfinite) ? null : v;
}

/// 30 → "30", 0.3333 → "0.33", 1.5 → "1.5".
String formatAmount(double v) {
  if ((v - v.round()).abs() < 0.005) return v.round().toString();
  return v.toStringAsFixed(2).replaceFirst(RegExp(r'0$'), '');
}
