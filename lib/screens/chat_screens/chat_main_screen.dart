import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../cards/chat_card.dart';
import '../../models/user_model/get_staff_user_model.dart';
import '../../screens/chat_screens/chat_screen.dart';
import '../../utils/colors.dart';
import '../../utils/style.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class ChatMainScreen extends StatefulWidget {
  static const String ID = "/chat_main_screen";
  @override
  _ChatMainScreenState createState() => _ChatMainScreenState();
}

class _ChatMainScreenState extends State<ChatMainScreen> {
  final _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List  args = ModalRoute.of(context).settings.arguments;
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor: theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
      appBar: AppBar(
        elevation: theme.lightTheme == true ? 3 : 0,
        iconTheme: IconThemeData(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
        systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
        centerTitle: true,
        title: Text(
          'Chat',
          style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
              fontSize: 14),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('staff_user')
              .where("id", whereIn: args)
              .snapshots(),
          builder: (context, snapshot) {
            List<GetStaffUserModel> instructorDetail = [];
            if (snapshot.hasData) {
             final details = snapshot.data.docs;
             for (var detail in details) {
               GetStaffUserModel instructor = GetStaffUserModel.fromMap(detail.data());
               instructorDetail.add(instructor);
             }
            }
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                reverse: true,
                itemCount: instructorDetail.length,
                itemBuilder: (BuildContext context, int index) {
                  return  ChatTab(
                    image: instructorDetail[index].image,
                    name: instructorDetail[index].name,
                    job: instructorDetail[index].job,
                    status: instructorDetail[index].onlineStatus,
                    onTap: (){
                      Navigator.pushNamed(context, ChatScreen.ID, arguments:  [instructorDetail[index], 0]);
                    },
                  );
                }
            );
          }
          ),
        ),
      ),
    );
  }
}
