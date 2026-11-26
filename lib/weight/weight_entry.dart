/// A single weight measurement.
class WeightEntry {
  const WeightEntry({required this.id, required this.date, required this.kg});

  final String id;
  final DateTime date;
  final double kg;

  factory WeightEntry.fromJson(Map<String, dynamic> json) => WeightEntry(
    id: json['id'] as String,
    date: DateTime.parse(json['date'] as String),
    kg: (json['kg'] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(),
    'kg': kg,
  };
}

/// Whether any entry falls in the same calendar month as [now].
bool hasMeasurementForMonth(Iterable<WeightEntry> entries, DateTime now) =>
    entries.any((e) => e.date.year == now.year && e.date.month == now.month);
