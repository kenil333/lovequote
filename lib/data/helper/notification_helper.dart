import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  static final _notification = FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initnotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');

    IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: (
        int id,
        String? title,
        String? body,
        String? payload,
      ) async {
        debugPrint("Title ===>   $title");
      },
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _notification.initialize(initializationSettings);
  }

  Future<void> schedulenotification(
    int id,
    String title,
    String body,
    String hour,
    String minute,
    String ampm,
  ) async {
    debugPrint("$id Notification start");
    String _hour = hour;
    if (ampm == "PM") {
      _hour = (int.parse(hour) + 12).toString();
    }
    final _date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    await _notification.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.parse(tz.local, "$_date $_hour:$minute:00"),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          "Channel_Id",
          "Channel_nName",
          channelDescription: "Channel_Description",
        ),
        iOS: IOSNotificationDetails(
          sound: "default.wav",
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
    debugPrint("$id Notification Scheduled !");
  }

  canclenotification(int id) async {
    await _notification.cancel(id);
    debugPrint("$id Notification Canceled !");
  }
}
