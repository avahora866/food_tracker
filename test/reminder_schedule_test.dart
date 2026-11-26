import 'package:flutter_test/flutter_test.dart';
import 'package:food_tracker/weight/reminder_schedule.dart';
import 'package:food_tracker/weight/weight_entry.dart';

void main() {
  group('upcomingReminderDays', () {
    test('measured this month: starts on the 1st of next month, daily', () {
      final days = upcomingReminderDays(
        now: DateTime(2026, 11, 26, 14),
        measuredThisMonth: true,
        count: 3,
      );
      expect(days, [
        DateTime(2026, 12, 1, 9),
        DateTime(2026, 12, 2, 9),
        DateTime(2026, 12, 3, 9),
      ]);
    });

    test('measured in December rolls over to January', () {
      final days = upcomingReminderDays(
        now: DateTime(2026, 12, 15),
        measuredThisMonth: true,
        count: 1,
      );
      expect(days.single, DateTime(2027, 1, 1, 9));
    });

    test('not measured, before reminder hour: starts today', () {
      final days = upcomingReminderDays(
        now: DateTime(2026, 11, 3, 8, 30),
        measuredThisMonth: false,
        count: 2,
      );
      expect(days, [DateTime(2026, 11, 3, 9), DateTime(2026, 11, 4, 9)]);
    });

    test('not measured, after reminder hour: starts tomorrow', () {
      final days = upcomingReminderDays(
        now: DateTime(2026, 11, 30, 9),
        measuredThisMonth: false,
        count: 2,
      );
      expect(days, [DateTime(2026, 12, 1, 9), DateTime(2026, 12, 2, 9)]);
    });

    test('keeps the reminder hour across all days', () {
      final days = upcomingReminderDays(
        now: DateTime(2026, 1, 1),
        measuredThisMonth: false,
      );
      expect(days, hasLength(reminderCount));
      expect(
        days.every((d) => d.hour == reminderHour && d.minute == 0),
        isTrue,
      );
    });
  });

  test('hasMeasurementForMonth matches year and month', () {
    final entries = [WeightEntry(id: '1', date: DateTime(2025, 11, 5), kg: 80)];
    expect(hasMeasurementForMonth(entries, DateTime(2026, 11, 26)), isFalse);
    expect(hasMeasurementForMonth(entries, DateTime(2025, 11, 30)), isTrue);
  });
}
