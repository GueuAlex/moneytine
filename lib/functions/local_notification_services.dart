import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize() {
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("ic_launcher1"),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (id, title, body, payload) async {},
      ),
    );
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  void display(RemoteMessage message) async {
    try {
      ////
      //print("In notif method");
      Random random = Random();
      int id = random.nextInt(999999999);
      //final NotificationDetails notificationDetails =
      //print("my id is $id");
      await _flutterLocalNotificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        await notificationDetails(),
      );
      // ignore: unused_catch_clause
    } on Exception catch (e) {
      ///
      // print("errro is : $e");
    }
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "my_channel_id",
        "mychanel",
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        showWhen: true,
        number: 1,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }
}
