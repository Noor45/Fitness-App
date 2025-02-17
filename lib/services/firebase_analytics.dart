import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsService {
  static final FirebaseAnalytics _firebaseAnalytics = FirebaseAnalytics.instance;

  static Future<void> logEvent(String eventName) async {
    await _firebaseAnalytics.logEvent(name: eventName);
  }
}
