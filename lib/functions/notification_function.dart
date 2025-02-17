// import 'dart:math';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:awesome_notifications/awesome_notifications.dart' hide DateUtils;
// import 'package:awesome_notifications/awesome_notifications.dart' as Utils show DateUtils;
// import 'package:t_fit/controllers/general_controller.dart';
// import '../utils/colors.dart';
// import 'package:schedulers/schedulers.dart';
//
// class NotificationManager {
//   static BuildContext context;
//
//   static Future<void> mealStartNotification(int meal, String date) async {
//     final scheduler = TimeScheduler();
//     String mealTime = meal == 0 ? 'First' : meal == 1 ? 'Second' : meal == 2 ? 'Third' : meal == 3 ? 'Forth' : meal == 4 ? 'Fifth' : '';
//     var delayTime = Utils.DateUtils.localToUtc(DateTime.parse(date));
//     await AwesomeNotifications().setChannel(
//         NotificationChannel(
//         channelKey: 'scheduled',
//         channelName: 'Scheduled notifications',
//         channelDescription: 'Notifications with schedule functionality',
//         importance: NotificationImportance.Max,
//         defaultColor: ColorRefer.kRedColor,
//         ledColor: ColorRefer.kRedColor,
//         locked: false,
//         vibrationPattern: highVibrationPattern));
//     await AwesomeNotifications().createNotification(
//         content: NotificationContent(
//           id: Random().nextInt(2147483647),
//           channelKey: 'scheduled',
//           title: 'It\'s your $mealTime meal time',
//           body: 'Get your $mealTime meal',
//           payload: {'uuid': 'uuid-test'},
//         ),
//         schedule: NotificationCalendar.fromDate(date: delayTime)
//     );
//     scheduler.run(() async{
//      await GeneralController.notificationData(
//         title: 'Your $mealTime meal time',
//         body: 'Get your $mealTime meal',
//         type: meal+1,
//       );
//     }, DateTime.parse(date));
//   }
// }
