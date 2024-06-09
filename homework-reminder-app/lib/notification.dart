import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationHelper {
  static final _notification = FlutterLocalNotificationsPlugin();

  static init() {
    _notification.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings()
      ),
    );
  }

  static pushNotification(BuildContext context, {required String title, required String body}) async {
    PermissionStatus status = await Permission.notification.status;

    var androidDetails = AndroidNotificationDetails(
      'important_channel',
      'My Channel',
      importance: Importance.max,
      priority: Priority.high
    );

    var iosDetails = DarwinNotificationDetails();

    var notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    // if notification permission status is allowed
    if (status.isGranted) {
      await _notification.show(100, title, body, notificationDetails);
    }
    else {
      PermissionStatus permission = await Permission.notification.request();

      // if notification permission is denied
      if (permission.isDenied || permission.isPermanentlyDenied) {
        showDialog(
          context: context, 
          builder: (BuildContext context) => AlertDialog(
            title: Text('Enable Notifications'),
            content: Text('Please enable notifications for this app in your device settings to receive notifications.'),
            actions: [
              TextButton(
                onPressed: () => openAppSettings(), 
                child: Text('Open Settings'),
              )
            ],
          )
        );
      }
      else {
        await _notification.show(100, title, body, notificationDetails);
      }
    }
  }

  static checkNotificationPermissions(BuildContext context) async {
    PermissionStatus status = await Permission.notification.status;

    if (!status.isGranted) {
      PermissionStatus permissionStatus = await Permission.notification.request();

      if (permissionStatus.isDenied || permissionStatus.isPermanentlyDenied) {
        showDialog(
          context: context, 
          builder: (BuildContext context) => AlertDialog(
            title: Text('Enable Notifications'),
            content: Text('Please enable notifications for this app in your device settings to receive notifications.'),
            actions: [
              TextButton(
                onPressed: () => openAppSettings(), 
                child: Text('Open Settings'),
              )
            ],
          )
        );
      }
    }
  }

  static scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime reminderDateTime,
  }) async { 
    var androidDetails = AndroidNotificationDetails(
      'important_channel', 
      'My Channel',
      importance: Importance.max,
      priority: Priority.high,
    );

    var iOSDetails = DarwinNotificationDetails();

    var notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails
    );

    tz.initializeTimeZones();
    tz.TZDateTime scheduledDateTime = tz.TZDateTime.from(reminderDateTime, tz.local);

    await FlutterLocalNotificationsPlugin().zonedSchedule(
      id, 
      title, 
      body, 
      scheduledDateTime,
      await notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      payload: body,
    );
  }

  static cancelNotification(int notificationId) async {
    await _notification.cancel(notificationId);
  }

  static displayPendingNotifications() async {
    try {
      List<PendingNotificationRequest> pendingNotifications = await _notification.pendingNotificationRequests();

      print("Pending Notifications:");
      for (var notification in pendingNotifications) {
        print(
          "ID: ${notification.id}\nTitle: ${notification.title}\nBody: ${notification.body}",
        );
      }
    } catch (e) {
      print("Error fetching");
    }
  }
}
