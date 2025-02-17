import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

AndroidNotificationChannel channel;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class PushNotificationService {
  Future<String> getDeviceId() async {
    try {
      final String token = await FirebaseMessaging.instance.getToken();
      print("Device id: $token");
      return token;
    } on FirebaseException catch (e) {
      print("Firebase messaging error: ${e.message}");
      return "";
    }
  }

  static void listenNotifications() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'High Importance Notifications',
              'This channel is used for important notifications.',
              importance: Importance.max,
              priority: Priority.high,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
      print("onMessage");
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      String body = message.notification.body;
      String title = message.notification.title;
      print("onMessageOpenedApp");
      print("Title: $title, Body: $body");
    });
  }
}
