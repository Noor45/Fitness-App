import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t_fit/cards/mind_fullness_card.dart';
import 'package:t_fit/controllers/auth_controller.dart';
import 'package:t_fit/database/local_storage_function.dart';
import 'package:t_fit/models/mental_health_model/mental_health_model.dart';
import 'package:t_fit/models/user_model/diary_model.dart';
import 'package:t_fit/screens/mental_health_screens/mindfulness_breathing.dart';
import 'package:t_fit/screens/mental_health_screens/play_sound_screen.dart';
import 'package:t_fit/screens/mental_health_screens/read_article_sceen.dart';
import 'package:t_fit/screens/mental_health_screens/sounds_list_screen.dart';
import 'package:t_fit/screens/mental_health_screens/write_journal_screen.dart';
import 'package:t_fit/screens/mental_health_screens/written_blog_screen.dart';
import 'package:t_fit/utils/constants.dart';
import '../../utils/colors.dart';
import '../../utils/style.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';
import 'package:schedulers/schedulers.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:t_fit/main.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:toast/toast.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class MindFullnessMainScreen extends StatefulWidget {
  static const String ID = "/mind_fullness_main_screen";
  @override
  _MindFullnessMainScreenState createState() => _MindFullnessMainScreenState();
}

class _MindFullnessMainScreenState extends State<MindFullnessMainScreen> {
  DateTime dateTime;
  List<int> durationList = List.filled(4, 0);
  List<MentalHealthModel> writtenBlogList  = [];
  List<MentalHealthModel> soundBlogList  = [];
  List<MentalHealthModel> exerciseBlogList  = [];
  @override
  void initState() {
    Constants.mentalHealthBlogList.forEach((element) {
      if(element.type == 1) writtenBlogList.add(element);
      if(element.type == 2) soundBlogList.add(element);
      if(element.type != 2 && element.type != 1) exerciseBlogList.add(element);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
        backgroundColor: theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
        appBar: AppBar(
          elevation: theme.lightTheme == true ? 3 : 0,
          iconTheme: IconThemeData(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
          systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
          centerTitle: true,
          title: Text(
            'Mindfulness',
            style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 14),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    'Hi ${AuthController.currentUser.name}!',
                    style: StyleRefer.kTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  AlarmCard(
                    title: Constants.notificationTime.alarm == '' || Constants.notificationTime.alarm == null ? 'Set Time for Alarm' : 'Alarm set ${Constants.notificationTime.alarm}',
                    onPressed: () async{
                     await selectTime();
                    },
                  ),
                  Visibility(
                    visible: writtenBlogList.length == 0 ? false : true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        AutoSizeText(
                          'How are you Feeling?',
                          style: StyleRefer.kTextStyle.copyWith(fontSize: 25, color: ColorRefer.kPinkColor, fontWeight: FontWeight.w900),
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              'Read famous blogs',
                              style: StyleRefer.kTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.pushNamed(context, WrittenBlogScreen.ID, arguments: writtenBlogList);
                              },
                              child: AutoSizeText(
                                'View all',
                                style: StyleRefer.kTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: writtenBlogList == null || writtenBlogList.length == 0
                                ? [Container()]
                                : writtenBlogList.mapIndexed((e, index){
                              if(index > 3){
                                return Container();
                              }else{
                                return WrittenBlogCard(
                                  title: e.title,
                                  tag: e.tags,
                                  showDes: true,
                                  images: e.fileUrl,
                                  onTap: (){
                                    Navigator.pushNamed(context, ReadArticle.ID, arguments: e);
                                  },
                                );
                              }
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: soundBlogList.length == 0 ? false : true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        AutoSizeText(
                          'Suffering with sleep deprivation?',
                          style: StyleRefer.kTextStyle.copyWith(fontSize: 20, color: ColorRefer.kPinkColor, fontWeight: FontWeight.w900),
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              'Listen Sounds',
                              style: StyleRefer.kTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.pushNamed(context, SoundBlogScreen.ID, arguments: soundBlogList);
                              },
                              child: AutoSizeText(
                                'View all',
                                style: StyleRefer.kTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: soundBlogList == null || soundBlogList.length == 0
                                ? [Container()]
                                : soundBlogList.mapIndexed((e, index){
                              if(index > 3){
                                return Container();
                              }else{
                                return AudioBlogCard(
                                  height: width/3,
                                  width: width/1.9,
                                  onTap: (){
                                    Navigator.pushNamed(context, PlaySoundScreen.ID, arguments: e);
                                  },
                                  radius: BorderRadius.all(Radius.circular(15)),
                                  text: e.title,
                                );
                              }
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: exerciseBlogList.length == 0 ? false : true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        AutoSizeText(
                          'Spend in some Mindful activities',
                          style: StyleRefer.kTextStyle.copyWith(fontSize: 20, color: ColorRefer.kPinkColor,  fontWeight: FontWeight.w900),
                        ),
                        SizedBox(height: 12),
                        AutoSizeText(
                          'Exercise',
                          style: StyleRefer.kTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: exerciseBlogList == null || exerciseBlogList.length == 0
                                ? [Container()]
                                : exerciseBlogList.mapIndexed((e, index){
                              if(index > 3){
                                return Container();
                              }else{
                                return WrittenBlogCard(
                                  title: e.title,
                                  tag: null,
                                  showDes: false,
                                  localImage: true,
                                  images: e.type == 3 ? 'assets/images/breathingExe.png' : e.type == 6 ? 'assets/images/wirte_diary.jpg' :'assets/images/reading.png',
                                  onTap: (){
                                    if(e.type == 6){
                                      Navigator.pushNamed(context, WriteDiaryScreen.ID, arguments: [false, DiaryModel()]);
                                    }
                                    if(e.type == 3){
                                      Navigator.pushNamed(context, BreathExerciseScreen.ID, arguments: e);
                                    }
                                  },
                                );
                              }
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ),
        )
    );
  }

  selectTime() async{
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
    if(time != ''){
      setNotification(dateTime, durationList, 'Clock', '${DateFormat.jm().format(DateFormat("hh:mm:ss").parse("$time"))} Alarm', 'Alarm will ring at ${DateFormat.jm().format(DateFormat("hh:mm:ss").parse("$time"))}', time);
      await DatabaseHelper.instance.saveNotificationTime('alarm', time);
    }
    setState(() {});
  }
  setNotification(DateTime dateTime, List durationList, String title, String des, String msg, String time){
    setState(() {
      final scheduler = TimeScheduler();
      if (time != '') {
        var duration = DateTime.now().difference(dateTime).abs();
        durationList[0] = duration.inDays;
        durationList[1] = duration.inHours;
        durationList[2] = duration.inMinutes;
        durationList[3] = duration.inSeconds;
        _zonedScheduleNotification(title, des, durationList);
        scheduler.run(() async{
          DatabaseHelper.instance.saveNotificationTime('alarm', '');
        }, dateTime);
        DatabaseHelper.instance.saveNotificationTime('alarm', time);
        Toast.show(msg, context,duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      } else {
        Toast.show("Select Time for Alarm", context,
            duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM);
      }
    });
  }
  Future<void> _zonedScheduleNotification(String title, String des, List<int> duration) async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 5',
      'CHANNEL_NAME 5',
      "CHANNEL_DESCRIPTION 5",
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      additionalFlags: Int32List.fromList(<int>[4]),
      sound: RawResourceAndroidNotificationSound('alarm'),
      styleInformation: DefaultStyleInformation(true, true)
    );
    var iosChannelSpecifics = IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
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
        payload: 'alarm',
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }
}


