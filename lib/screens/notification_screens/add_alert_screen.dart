import 'dart:math';
import 'package:schedulers/schedulers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:t_fit/controllers/general_controller.dart';
import 'package:t_fit/database/local_storage_function.dart';
import 'package:t_fit/main.dart';
import 'package:t_fit/shared_preferences/shared_preferences.dart';
import 'package:t_fit/utils/constants.dart';
import 'package:t_fit/utils/fonts.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:toast/toast.dart';
import '../../utils/colors.dart';
import '../../utils/style.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


class SetUpNotificationScreen extends StatefulWidget {
  static const String ID = "/setup_notification_screen";
  @override
  _SetUpNotificationScreenState createState() => _SetUpNotificationScreenState();
}

class _SetUpNotificationScreenState extends State<SetUpNotificationScreen> {
  String date;
  String mealTime0 = 'Select time for meal 1', mealTime1 = 'Select time for meal 2', mealTime2 = 'Select time for meal 3',
  mealTime3 = 'Select time for meal 4', mealTime4 = 'Select time for meal 5', mealTime5 = 'Select time for meal 6';

  String workoutTime = '';
  DateTime dateTime;
  bool allowNotification = LocalPreferences.preferences.getBool(LocalPreferences.Notification);
  List<int> durationList = List.filled(4, 0);
  @override
  void initState() {
    setState(() {
      Constants.notificationVisibility = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
        backgroundColor: theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
        appBar: AppBar(
          elevation: theme.lightTheme == true ? 3 : 0,
          iconTheme: IconThemeData(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
          systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
          centerTitle: true,
          title: Text(
            'Set up Notification',
            style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 14),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: Constants.planDetail.workout == 1 ? true : false,
                    child: Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText('What time would you prefer to do workout?',
                            style: TextStyle(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontFamily: FontRefer.OpenSans,
                                fontSize: 16),),
                          SizedBox(height: 8),
                          AutoSizeText('Select a time we will remind you',
                            style: TextStyle(color: ColorRefer.kDarkGreyColor, fontFamily: FontRefer.OpenSans,
                                fontSize: 13),),
                          Visibility(
                            visible: Constants.notificationTime.workout == '' || Constants.notificationTime.workout == null ? false : true,
                            child: AutoSizeText('Workout time set for ${Constants.notificationTime.workout}',
                              style: TextStyle(color: ColorRefer.kRedColor, fontFamily: FontRefer.OpenSans,
                                  fontSize: 10),),
                          ),
                          AlertField(
                              title: workoutTime == '' ? 'Select time': workoutTime ,
                              onTap: () async{
                                workoutTime = await selectTime();
                              },
                              setTime: (){
                                if(allowNotification == true)
                                setNotification(dateTime, durationList,
                                    'It\'s your workout time', 'Get ready for your workout',
                                    'Workout notification set', workoutTime, 2, 6);
                                else
                                  Toast.show("Please turn on the notification option", context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM);
                              }
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: Constants.planDetail.meal == 1 ? true : false,
                    child: Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText('What time would you prefer to take your meals?',
                            style: TextStyle(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontFamily: FontRefer.OpenSans,
                                fontSize: 16),),
                          SizedBox(height: 8),
                          AutoSizeText('Your current plan has ${Constants.todayMealDetail.mealsInEachDay} '
                              '${Constants.todayMealDetail.mealsInEachDay == 1 ? 'meal': 'meals'} a day',
                            style: TextStyle(color: ColorRefer.kDarkGreyColor, fontFamily: FontRefer.OpenSans,
                                fontSize: 11),),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            // reverse: true,
                            itemCount: Constants.todayMealDetail.mealsInEachDay,
                            itemBuilder: (BuildContext context, int index) {
                              return  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Visibility(
                                    visible: index == 0 ? Constants.notificationTime.mealOne ==  '' || Constants.notificationTime.mealOne ==  null ? false : true : false,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: AutoSizeText('Meal ${index+1} time set for ${Constants.notificationTime.mealOne}',
                                        style: TextStyle(color: ColorRefer.kRedColor, fontFamily: FontRefer.OpenSans, fontSize: 10),),
                                    ),
                                  ),Visibility(
                                    visible: index == 1 ? Constants.notificationTime.mealTwo ==  '' || Constants.notificationTime.mealTwo ==  null ? false : true : false,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: AutoSizeText('Meal ${index+1} time set for ${Constants.notificationTime.mealTwo}',
                                        style: TextStyle(color: ColorRefer.kRedColor, fontFamily: FontRefer.OpenSans, fontSize: 10),),
                                    ),
                                  ),Visibility(
                                    visible: index == 2 ? Constants.notificationTime.mealThree ==  '' || Constants.notificationTime.mealThree ==  null ? false : true : false,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: AutoSizeText('Meal ${index+1} time set for ${Constants.notificationTime.mealThree}',
                                        style: TextStyle(color: ColorRefer.kRedColor, fontFamily: FontRefer.OpenSans, fontSize: 10),),
                                    ),
                                  ),Visibility(
                                    visible: index == 3 ? Constants.notificationTime.mealFour ==  '' || Constants.notificationTime.mealFour ==  null ? false : true : false,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: AutoSizeText('Meal ${index+1} time set for ${Constants.notificationTime.mealFour}',
                                        style: TextStyle(color: ColorRefer.kRedColor, fontFamily: FontRefer.OpenSans, fontSize: 10),),
                                    ),
                                  ),Visibility(
                                    visible: index == 4 ? Constants.notificationTime.mealFive ==  '' || Constants.notificationTime.mealFive ==  null ? false : true : false,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: AutoSizeText('Meal ${index+1} time set for ${Constants.notificationTime.mealFive}',
                                        style: TextStyle(color: ColorRefer.kRedColor, fontFamily: FontRefer.OpenSans, fontSize: 10),),
                                    ),
                                  ),Visibility(
                                    visible: index == 5 ? Constants.notificationTime.mealSix ==  '' || Constants.notificationTime.mealSix ==  null ? false : true : false,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: AutoSizeText('Meal ${index+1} time set for ${Constants.notificationTime.mealSix}',
                                        style: TextStyle(color: ColorRefer.kRedColor, fontFamily: FontRefer.OpenSans, fontSize: 10),),
                                    ),
                                  ),
                                  AlertField(
                                     key: UniqueKey(),
                                      title: index == 0 ? mealTime0 :
                                      index == 1 ? mealTime1 : index == 2 ? mealTime2 : index == 3 ?  mealTime3 : index == 4 ? mealTime4 : index == 5 ?  mealTime5 : 'Select time for meal ${index+1}',
                                      onTap: () async {
                                        selectMealTime(index);
                                      },
                                      setTime: (){
                                        if(allowNotification == true)
                                        setNotification(dateTime, durationList,
                                            'It\'s your meal time', 'Get your meal',
                                            'Meal notification set', index == 0 ? mealTime0 :
                                            index == 1 ? mealTime1 : index == 2 ? mealTime2 : index == 3 ?  mealTime3 : index == 4 ? mealTime4 : index == 5 ?  mealTime5 : '', 1, index);
                                        else
                                          Toast.show("Please turn on the notification option", context,
                                              duration: Toast.LENGTH_LONG,
                                              gravity: Toast.BOTTOM);
                                      }
                                  ),
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ),
        )
    );
  }

  Future<String> selectTime() async{
    String time = '';
     await DatePicker.showTimePicker(
        context, showTitleActions: true,
        onChanged: (date) {},
        onConfirm: (date) {
          setState(() {
            time = '${date.hour.toString().padLeft(2,"0")}:${date.minute.toString().padLeft(2,"0")}:${date.second.toString().padLeft(2,"0")}';
            dateTime = date;
          });
        },
        currentTime: DateTime.now()
    );
     return time;
  }
   selectMealTime(int meal) async{
     await DatePicker.showTimePicker(
        context, showTitleActions: true,
        onChanged: (date) {},
        onConfirm: (date) {
          setState(() {
            if(meal == 0) mealTime0 = '${date.hour.toString().padLeft(2,"0")}:${date.minute.toString().padLeft(2,"0")}:${date.second.toString().padLeft(2,"0")}';
            if(meal == 1) mealTime1 = '${date.hour.toString().padLeft(2,"0")}:${date.minute.toString().padLeft(2,"0")}:${date.second.toString().padLeft(2,"0")}';
            if(meal == 2) mealTime2 = '${date.hour.toString().padLeft(2,"0")}:${date.minute.toString().padLeft(2,"0")}:${date.second.toString().padLeft(2,"0")}';
            if(meal == 3) mealTime3 = '${date.hour.toString().padLeft(2,"0")}:${date.minute.toString().padLeft(2,"0")}:${date.second.toString().padLeft(2,"0")}';
            if(meal == 4) mealTime4 = '${date.hour.toString().padLeft(2,"0")}:${date.minute.toString().padLeft(2,"0")}:${date.second.toString().padLeft(2,"0")}';
            if(meal == 5) mealTime5 = '${date.hour.toString().padLeft(2,"0")}:${date.minute.toString().padLeft(2,"0")}:${date.second.toString().padLeft(2,"0")}';
            dateTime = date;
          });
        },
        currentTime: DateTime.now()
    );

  }
  setNotification(DateTime dateTime, List durationList, String title, String des, String msg, String time, int type, int index){
    setState(() {
      final scheduler = TimeScheduler();
      print(time);
      if (time != '' && time != 'Select time for meal 1' && time != 'Select time for meal 2' && time != 'Select time for meal 3' && time != 'Select time for meal 4' && time != 'Select time for meal 5' && time != 'Select time for meal 6') {
        var duration = DateTime.now().difference(dateTime).abs();
        durationList[0] = duration.inDays;
        durationList[1] = duration.inHours;
        durationList[2] = duration.inMinutes;
        durationList[3] = duration.inSeconds;
        _zonedScheduleNotification(title, des, durationList);
        scheduler.run(() async{
          await GeneralController.notificationData(
            title: title,
            body: des,
            type: type,
            meal: index+1 == 7 ? null : index+1
          );
          removeLocalNotificationTime(index, time);
          Constants.notificationVisibility = true;
        }, dateTime);
        saveLocalNotificationTime(index, time);
        Toast.show(msg, context,duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.pop(context);
      } else {
        Toast.show("Select Time for Reminder", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);
      }
    });
  }

  saveLocalNotificationTime(int meal, String time){
    if(meal == 0) DatabaseHelper.instance.saveNotificationTime('meal_one', time);
    if(meal == 1) DatabaseHelper.instance.saveNotificationTime('meal_two', time);
    if(meal == 2)  DatabaseHelper.instance.saveNotificationTime('meal_three', time);
    if(meal == 3) DatabaseHelper.instance.saveNotificationTime('meal_four', time);
    if(meal == 4) DatabaseHelper.instance.saveNotificationTime('meal_five', time);
    if(meal == 5) DatabaseHelper.instance.saveNotificationTime('meal_six', time);
    if(meal == 6) DatabaseHelper.instance.saveNotificationTime('workout', time);
  }

  removeLocalNotificationTime(int meal, String time){
    if(meal == 0) DatabaseHelper.instance.saveNotificationTime('meal_one', '');
    if(meal == 1) DatabaseHelper.instance.saveNotificationTime('meal_two', '');
    if(meal == 2)  DatabaseHelper.instance.saveNotificationTime('meal_three', '');
    if(meal == 3) DatabaseHelper.instance.saveNotificationTime('meal_four', '');
    if(meal == 4) DatabaseHelper.instance.saveNotificationTime('meal_five', '');
    if(meal == 5) DatabaseHelper.instance.saveNotificationTime('meal_six', '');
    if(meal == 6) DatabaseHelper.instance.saveNotificationTime('workout', '');
  }

  Future<void> _zonedScheduleNotification(String title, String des, List<int> duration) async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 4',
      'CHANNEL_NAME 4',
      "CHANNEL_DESCRIPTION 4",
      importance: Importance.max,
      priority: Priority.high,
      playSound: false,
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidChannelSpecifics, iOS: iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        Random().nextInt(2147483647),
        title,
        des,
        tz.TZDateTime.now(tz.local).add(Duration(
            days: duration[0],
            hours: duration[1],
            minutes: duration[2],
            seconds: duration[3])),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        payload: 'notify',
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }
}


class AlertField extends StatelessWidget {
  AlertField({this.title, this.onTap, this.setTime, Key key}): super(key: key);
  final String title;
  final Function onTap;
  final Function setTime;
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width/1.4,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border(
                top: BorderSide(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, width: 1),
                left: BorderSide(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, width: 1),
                right: BorderSide(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, width: 1),
                bottom: BorderSide(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, width: 1),
              ),
            ),
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: TextStyle(
                      fontSize: 14,
                      color:theme.lightTheme == true ? ColorRefer.kDarkColor : ColorRefer.kDarkGreyColor,)),
                    Icon(Icons.access_time, color: theme.lightTheme == true ? ColorRefer.kDarkColor : ColorRefer.kDarkGreyColor,
                      size: 18,)
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: setTime,
            child: Container(
              width: 60,
              padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorRefer.kRedColor.withOpacity(0.7),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Text(
                'Set',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

