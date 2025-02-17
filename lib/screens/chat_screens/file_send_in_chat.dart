import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t_fit/controllers/auth_controller.dart';
import '../../cards/chat_card.dart';
import '../../models/user_model/get_staff_user_model.dart';
import '../../screens/chat_screens/chat_screen.dart';
import '../../utils/colors.dart';
import '../../utils/style.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class FileSendInChatScreen extends StatefulWidget {
  static const String ID = "/file_send_in_chat_screen";
  @override
  _FileSendInChatScreenState createState() => _FileSendInChatScreenState();
}

class _FileSendInChatScreenState extends State<FileSendInChatScreen> {
  TextEditingController controller = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  File file;
  String path = '';
  String text = '';
  int type = 0;

  getData(List args){
    file = args[1];
    type = args[0];
    if(type == 1){
      path = args[2];
    }
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    List args = ModalRoute.of(context).settings.arguments;
    getData(args);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
      appBar: AppBar(
        elevation: theme.lightTheme == true ? 3 : 0,
        iconTheme: IconThemeData(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
        systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
        centerTitle: true,
        title: Text(
          'Select',
          style: StyleRefer.kTextStyle.copyWith(
              color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 14),
        )
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('staff_user')
                .where("id", whereIn: AuthController.currentUser.instructors)
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
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: width/4,
                          height: width/5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Image.file(
                              type == 0 ? file : File(path),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          width: width/1.5,
                          child: TextField(
                            controller: controller,
                            maxLines: 2,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              hintText: 'Type a message here (optional)',
                              hintStyle: TextStyle(fontSize: 12, color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white60),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white12, width: 1.0),
                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white12, width: 1.0),
                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                              ),
                              focusColor: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                text = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: instructorDetail.length,
                      itemBuilder: (BuildContext context, int index) {
                        return  SelectChatTab(
                          image: instructorDetail[index].image,
                          name: instructorDetail[index].name,
                          job: instructorDetail[index].job,
                          status: instructorDetail[index].onlineStatus,
                          onTap: (){
                            Navigator.pushReplacementNamed(context, ChatScreen.ID, arguments: [instructorDetail[index], 1, {'file':file, 'text': text, 'type': type == 0 ? 1 : 2}]);
                          },
                        );
                      }
                  ),
                ],
              );
            }
        ),
      ),
    );
  }
}


