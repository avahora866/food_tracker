import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'reminder_schedule.dart';
import 'weight_entry.dart';

/// Schedules the monthly "log your weight" local notifications.
class WeightReminderService {
  WeightReminderService._();
  static final instance = WeightReminderService._();

  static const payload = 'weight';
  static const _channelId = 'weight_reminders';

  final _plugin = FlutterLocalNotificationsPlugin();

  /// Sets up the plugin and asks for notification permission.
  ///
  /// [onOpen] is called when the user taps a reminder (including when the tap
  /// launched the app).
  Future<void> init({required void Function() onOpen}) async {
    tz.initializeTimeZones();
    final local = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(local.identifier));

    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
      onDidReceiveNotificationResponse: (r) {
        if (r.payload == payload) onOpen();
      },
    );

    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await android?.requestNotificationsPermission();

    final launch = await _plugin.getNotificationAppLaunchDetails();
    if (launch?.didNotificationLaunchApp == true &&
        launch?.notificationResponse?.payload == payload) {
      onOpen();
    }
  }

  /// Replaces all pending reminders based on the current entries.
  Future<void> reschedule(List<WeightEntry> entries) async {
    await _plugin.cancelAllPendingNotifications();

    final now = DateTime.now();
    final days = upcomingReminderDays(
      now: now,
      measuredThisMonth: hasMeasurementForMonth(entries, now),
    );

    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        'Weight reminders',
        channelDescription: 'Monthly reminder to log your weight',
      ),
    );

    for (final (i, d) in days.indexed) {
      await _plugin.zonedSchedule(
        id: i,
        title: 'Time to weigh in',
        body: "You haven't logged your weight for this month yet.",
        scheduledDate: tz.TZDateTime(tz.local, d.year, d.month, d.day, d.hour),
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        payload: payload,
      );
    }
  }
}
