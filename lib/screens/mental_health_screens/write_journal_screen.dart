import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:t_fit/controllers/auth_controller.dart';
import 'package:t_fit/database/local_storage_function.dart';
import 'package:t_fit/models/user_model/diary_model.dart';
import 'package:t_fit/screens/mental_health_screens/journal_list_screen.dart';
import 'package:t_fit/utils/colors.dart';
import 'package:t_fit/utils/fonts.dart';
import 'package:intl/intl.dart';
import 'package:t_fit/utils/style.dart';
import 'package:t_fit/widgets/round_button.dart';
import 'package:toast/toast.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';


class WriteDiaryScreen extends StatefulWidget {
  static const String ID = "/write_diary";
  @override
  _WriteDiaryScreenState createState() => _WriteDiaryScreenState();
}
class _WriteDiaryScreenState extends State<WriteDiaryScreen> {
  final formKey = GlobalKey<FormState>();
  var now =  DateTime.now();
  bool read = false;
  DiaryModel readDiary = DiaryModel();
  var formatter = new DateFormat('dd/MM/yy');
  String journalDetailText;
  String journalTitleText;
  InputDecoration fieldDecoration;
  String date;
  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  String validator(String value) {
      if (value.isEmpty) {
        return "Please write something";
      }
  }
  TextEditingController writeController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  design (DarkThemeProvider theme){
    if(read == true){
      writeController.text = readDiary.text;
      titleController.text = readDiary.title;
    }
    fieldDecoration = InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.lightTheme == true ? Colors.white54 : ColorRefer.kDarkColor, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.lightTheme == true ? Colors.white54 : ColorRefer.kDarkColor, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        hintStyle: TextStyle(color: ColorRefer.kTextColor)
    );
  }

  @override
  Widget build(BuildContext context) {
    List detail = ModalRoute.of(context).settings.arguments;
    read = detail[0]; readDiary = detail[1];
    date = read == true ? formatter.format(readDiary.createdAt.toDate()) : formatter.format(now);
    final theme = Provider.of<DarkThemeProvider>(context);
    design(theme);
    return Scaffold(
        backgroundColor: theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
        appBar: AppBar(
          elevation: theme.lightTheme == true ? 3 : 0,
          iconTheme: IconThemeData(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
          systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
          centerTitle: true,
          title: Text(
            'Write Diary',
            style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 14),
          ),
          actions: [
            Visibility(
              visible: read == true ? false : true,
              child: Container(
                child:  InkWell(
                  onTap: () async{
                    await DatabaseHelper.instance.getJournals();
                     Navigator.pushNamed(context, JournalScreen.ID);
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 15, top: 5),
                    alignment: Alignment.center,
                    child: Icon(
                      CupertinoIcons.square_list,
                      color: theme.lightTheme == true ? ColorRefer.kRedColor : ColorRefer.kLightGreyColor,
                      size: 20,
                    ),
                  ),
                )
              ),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 15),
                    child: Text(
                      read == true ? 'Read Your Journal' : 'Write Your Own Journal',
                      style: TextStyle(fontFamily: FontRefer.OpenSans, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                     date,
                    style: TextStyle(color: ColorRefer.kTextColor, fontSize: 12.0, fontFamily: FontRefer.OpenSans),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: titleController,
                    readOnly: read,
                    onChanged: (value){
                      journalTitleText = value;
                    },
                    decoration: fieldDecoration.copyWith(hintText: 'Title...'),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: writeController,
                    maxLines: 14,
                    readOnly: read,
                    keyboardType: TextInputType.multiline,
                    onChanged: (value){
                      journalDetailText = value;
                    },
                    validator: validator,
                    decoration: fieldDecoration.copyWith(hintText: 'Write here...'),
                  ),
                  SizedBox(height: 20),
                  Visibility(
                    visible: read == true ? false : true,
                    child: RoundedButton(
                        title: 'Save',
                        buttonRadius: 10,
                        colour: ColorRefer.kRedColor,
                        height: 48,
                        onPressed: () async {
                          if (!formKey.currentState.validate()) return;
                          formKey.currentState.save();
                          DiaryModel journal = DiaryModel();
                          journal.createdAt = Timestamp.now();
                          journal.text = journalDetailText;
                          journal.title = journalTitleText;
                          journal.id = getRandomString(16).substring(2);
                          journal.uid = AuthController.currentUser.uid;
                          await DatabaseHelper.instance.saveJournal(journal);
                          Toast.show("Saved", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                          Navigator.pop(context);
                        }
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ));
  }


}
