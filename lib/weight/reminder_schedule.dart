/// Hour of day (local time) at which weight reminders fire.
const reminderHour = 9;

/// How many daily reminders to keep queued ahead of time.
///
/// Reminders are recomputed every time the app starts or an entry is
/// added/removed, so this only matters if the app isn't opened for a long
/// stretch.
const reminderCount = 60;

/// Computes the local date-times (year/month/day at [hour]) for upcoming
/// weight reminders.
///
/// Rule: remind on the 1st of every month, then every day after that until a
/// measurement exists for that month.
/// - If this month already has a measurement, reminders start on the 1st of
///   next month.
/// - Otherwise they start today (or tomorrow if [hour] has already passed).
List<DateTime> upcomingReminderDays({
  required DateTime now,
  required bool measuredThisMonth,
  int hour = reminderHour,
  int count = reminderCount,
}) {
  DateTime start;
  if (measuredThisMonth) {
    start = DateTime(now.year, now.month + 1, 1, hour);
  } else {
    start = DateTime(now.year, now.month, now.day, hour);
    if (!start.isAfter(now)) {
      start = DateTime(now.year, now.month, now.day + 1, hour);
    }
  }
  // Build each date from components so DST changes don't shift the hour.
  return [
    for (var i = 0; i < count; i++)
      DateTime(start.year, start.month, start.day + i, hour),
  ];
}
