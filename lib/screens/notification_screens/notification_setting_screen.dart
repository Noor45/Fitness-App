import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t_fit/cards/setting_screen_cards.dart';
import 'package:t_fit/shared_preferences/shared_preferences.dart';
import '../../utils/colors.dart';
import '../../utils/style.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';


class NotificationSettingScreen extends StatefulWidget {
  static const String ID = "/notification_setting_screen";
  @override
  _NotificationSettingScreenState createState() => _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  bool setUpNotification = false;
  bool chatNotification = false;
  bool mealNotification = false;
  bool workoutNotification = false;

  bool allowSetUpNotification = true;

  @override
  void initState() {
    allowSetUpNotification = LocalPreferences.preferences.getBool(LocalPreferences.Notification);
    setUpNotification = allowSetUpNotification;
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
            'Notification Setting',
            style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SwitchCard(
                    text: 'Local Notifications',
                    isSwitched: setUpNotification,
                    onChanged: (value) async{
                      setState(() {
                        setUpNotification = value;
                      });
                      await LocalPreferences.preferences.setBool(LocalPreferences.Notification, value);
                    },
                  ),
                  SwitchCard(
                    text: 'Chat Notifications',
                    isSwitched: chatNotification,
                    onChanged: (value) async{
                      setState(() {
                        chatNotification = value;
                      });
                      // await LocalPreferences.preferences.setBool(LocalPreferences.Notification, value);
                    },
                  ),
                  SwitchCard(
                    text: 'Meal Notifications',
                    isSwitched: mealNotification,
                    onChanged: (value) async{
                      setState(() {
                        mealNotification = value;
                      });
                      // await LocalPreferences.preferences.setBool(LocalPreferences.Notification, value);
                    },
                  ),
                  SwitchCard(
                    text: 'Workout Notifications',
                    isSwitched: workoutNotification,
                    onChanged: (value) async{
                      setState(() {
                        workoutNotification = value;
                      });
                      // await LocalPreferences.preferences.setBool(LocalPreferences.Notification, value);
                    },
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }

}


