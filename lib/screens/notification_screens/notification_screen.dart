import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t_fit/controllers/auth_controller.dart';
import 'package:t_fit/database/local_storage_function.dart';
import 'package:t_fit/models/user_plan_data_model/notification_model.dart';
import 'package:t_fit/screens/notification_screens/add_alert_screen.dart';
import 'package:t_fit/utils/constants.dart';
import 'package:t_fit/utils/fonts.dart';
import 'package:t_fit/widgets/time_ago.dart';
import '../../cards/notifications_card.dart';
import '../../utils/colors.dart';
import 'package:intl/intl.dart';
import '../../utils/style.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';


class NotificationScreen extends StatefulWidget {
  static const String ID = "/notification_screen";
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

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
    var formatter = new DateFormat('dd-MM-yyyy h:mma');
    return Scaffold(
        backgroundColor: theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
        appBar: AppBar(
          elevation: theme.lightTheme == true ? 3 : 0,
          iconTheme: IconThemeData(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
          systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
          centerTitle: true,
          title: Text(
            'Notification',
            style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 14),
          ),
          actions: [
            InkWell(
              onTap: () async{
                await DatabaseHelper.instance.getNotificationTime();
                await Navigator.pushNamed(context, SetUpNotificationScreen.ID);
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 15, top: 5),
                alignment: Alignment.center,
                child: Icon(
                  CupertinoIcons.timer,
                  color: theme.lightTheme == true ? ColorRefer.kRedColor : ColorRefer.kLightGreyColor,
                  size: 20,
                ),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 15, bottom: 15),
            child:  StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('notifications').where('user_id', isEqualTo: AuthController.currentUser.uid).orderBy('created_at', descending: true).snapshots(),
              builder: (context, snapshot) {
                List<NotificationModel> notificationsList = [];
                if(snapshot.hasData){
                  final data = snapshot.data.docs;
                  for(var value in data){
                    NotificationModel object = NotificationModel.fromMap(value.data());
                    notificationsList.add(object);
                  }
                }
                return notificationsList == null || notificationsList.length == 0 ? Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height/1.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.bell,
                        color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                        size: 50,
                      ),
                      SizedBox(height: 6),
                      AutoSizeText('No notifications yet', style: TextStyle(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontFamily: FontRefer.OpenSans,  fontSize: 16),)
                    ],
                  ),
                ) : ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: notificationsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return  NotificationCard(
                      des: notificationsList[index].body,
                      title: notificationsList[index].title,
                      type: notificationsList[index].type,
                      md: notificationsList[index].md,
                      mealPortion: notificationsList[index].mealPortion,
                      time: TimeAgo.timeAgoSinceDate(formatter.format(notificationsList[index].createdAt.toDate()), true),
                      onPressed: (){},
                    );
                  },
                );
              },
            ),
          ),
        )
    );
  }
}
