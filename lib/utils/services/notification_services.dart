import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/timezone.dart' as tz;

class NotificationServices {
  static NotificationServices notify = NotificationServices._();

  NotificationServices._();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initNotification() {
    InitializationSettings initializationSettings =
        const InitializationSettings(
      android: AndroidInitializationSettings('app'),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void simpleNotification() {
    NotificationDetails notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails('and', 'Local',
          importance: Importance.max, priority: Priority.high),
      iOS: DarwinNotificationDetails(),
    );

    flutterLocalNotificationsPlugin.show(
        1, 'Test', 'local', notificationDetails);
  }

  void scheduleNotification() async {
    NotificationDetails notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails('ijk', 'Schedule',
          importance: Importance.max, priority: Priority.high,),
      iOS: DarwinNotificationDetails(),
    );

  await  flutterLocalNotificationsPlugin.zonedSchedule(
        2,
        'test',
        'Schedule',
        tz.TZDateTime.now(tz.
        local).add(const Duration(seconds: 5)),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
