import 'package:shared_preferences/shared_preferences.dart';

class LocalPreferences {
  static SharedPreferences preferences;
  static const String OnBoardingScreensVisited = "on_boarding_visited";
  static const String Notification = "Notification_assigned";
  static const String mealTime = "";
  static const String currentDay = "current_day";
  static const String currentMonth =  "current_month";
  static const String currentYear =  "current_year";
  static const String alarmTime = "alarm_time";

  static Future<void> initLocalPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }
}
