import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:t_fit/controllers/auth_controller.dart';

class PostNotificationSubscription {

  static void fcmSubscribe() {
    if (AuthController.currentUser.uid?.isNotEmpty ?? false) {
      print("subscribe" + AuthController.currentUser.uid ?? "");
      FirebaseMessaging.instance.subscribeToTopic(AuthController.currentUser.uid);
    }
  }



  static void fcmUnSubscribe() {
    if (AuthController.currentUser.uid?.isNotEmpty ?? false) {
      print("un-subscribe" + AuthController.currentUser.uid ?? "");
      FirebaseMessaging.instance.subscribeToTopic(AuthController.currentUser.uid);
    }
  }
}