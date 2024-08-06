import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationServices {
  static NotificationServices notify = NotificationServices._();

  NotificationServices._();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    InitializationSettings initializationSettings =
        const InitializationSettings(
      android: AndroidInitializationSettings('app'),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
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
      android: AndroidNotificationDetails(
        'ijk',
        'Schedule',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
        2,
        'test',
        'Schedule',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  void imageNotification() {

    //BigPictureStyleInformation bigPictureStyleInformation = BigPictureStyleInformation(FilePathAndroidBitmap);

    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails("3", "Image",priority: Priority.high,importance: Importance.max);
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
      iOS: darwinNotificationDetails,
      android: androidNotificationDetails,
    );
    flutterLocalNotificationsPlugin.show(
        3, 'image', 'test', notificationDetails);
  }

  void soundNotification() {}
}
