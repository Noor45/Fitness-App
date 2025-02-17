import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../controllers/auth_controller.dart';
import '../../models/user_model/user_parq_model.dart';
import '../../screens/par_q_screens/par_attachment.dart';
import '../../utils/strings.dart';
import '../../utils/style.dart';
import '../../widgets/round_button.dart';
import 'package:toast/toast.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class PARQScreen extends StatefulWidget {
  static const String ID = "/parq_screen";
  @override
  _PARQScreenState createState() => _PARQScreenState();
}

class _PARQScreenState extends State<PARQScreen> with TickerProviderStateMixin{
  List parqAnswers = [];
  String question;
  bool saved = false;
  int answer;
  int add = 0;
  @override
  void initState() {
    if(AuthController.currentUser.parq.isNotEmpty){
      AuthController.currentUser.parq.forEach((element) {
        parqAnswers.add(element);
      });
      add = parqAnswers.length;
    }
    super.initState();
  }
  @override
  void dispose() {
    saved = false;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
      appBar: AppBar(
        elevation: theme.lightTheme == true ? 3 : 0,
        iconTheme: IconThemeData(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
        systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
        centerTitle: true,
        title: Text(
          'PAR-Q',
          style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 14),
        ),
      ),
      body: SafeArea(
          child: Container(
            width: width,
            height: height,
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15, ),
                  child: AutoSizeText(
                    'Answer PAR-Q',
                    style: StyleRefer.kTextStyle
                        .copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 8),
                  child: AutoSizeText(
                    StringRefer.kPQRString,
                    style: StyleRefer.kTextStyle
                        .copyWith(color: ColorRefer.kPinkColor, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                Visibility(
                  visible: parqAnswers.length == 10 ? false : true,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10, top: 5),
                    height: width / 2,
                    width: width,
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                              '${((add/Constants.parQList.length)*100).round()}%',
                              style:
                              StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white, fontWeight: FontWeight.w900)),
                        ),
                        PieChart(
                          PieChartData(
                              borderData: FlBorderData(show: false),
                              sectionsSpace: 0,
                              centerSpaceRadius: 70,
                              sections: showingSections(Constants.parQList.length, add, context)),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: Constants.parQList.length,
                            itemBuilder: (BuildContext context, int index) {
                              String question;
                              if(AuthController.currentUser.parq.isNotEmpty){
                                if(AuthController.currentUser.parq[index]['ans'] == 0) {
                                  answer = 0;
                                  question = AuthController.currentUser.parq[index]['ques'];
                                } else{
                                 answer = 1;
                                 question = AuthController.currentUser.parq[index]['ques'];
                                }
                              }else{
                                question = Constants.parQList[index].ques;
                              }
                              return  Container(
                                margin: EdgeInsets.only(top: 12),
                                child: question == null ? Container() : PQRList(
                                  question: question,
                                  answer: answer,
                                  qNo: index,
                                  function: (value){
                                    setState(() {
                                      saved = true;
                                    });
                                    UserPARQModel userParQ = UserPARQModel();
                                    userParQ.ques = question;
                                    userParQ.ans = value;
                                    parqAnswers.forEach((e) {
                                      if(e['ques'] == Constants.parQList[index].ques ) {
                                        add--;
                                      }
                                    });
                                    add++;
                                    parqAnswers.removeWhere((element) => element['ques'] == question);
                                    parqAnswers.add(userParQ.toMap());
                                    setState(() {});
                                  },
                                ),
                              );
                            }),
                        Container(
                          padding: EdgeInsets.all(15),
                          child: ButtonWithIcon(
                              title: 'Next',
                              buttonRadius: 5,
                              colour: ColorRefer.kRedColor ,
                              height: 35,
                              onPressed: (){
                                if(parqAnswers.length == Constants.parQList.length){
                                  save();
                                }else{
                                  Toast.show("Please answer all questions", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  save() async{
    setState(() {
      if(saved == true){
        AuthController.currentUser.parq.clear();
        parqAnswers.forEach((element) {
          AuthController.currentUser.parq.add(element);
        });
        AuthController().updateUserFields();
        AuthController().updateUserFields();
        Toast.show("Saved", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.pushNamed(context, PARQAttachmentScreen.ID);
        saved = false;
      }else{
        Navigator.pushNamed(context, PARQAttachmentScreen.ID);
      }
    });
  }
  List<PieChartSectionData> showingSections(int total, int value, BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    setState(() {
      value = value * 10;
      total = (total * 10) - value;

    });
    return List.generate(2, (i) {
      final radius =  15.0;
      switch (i) {
        case 1:
          return PieChartSectionData(
            color: theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
            value: total.toDouble(),
            title: '',
            radius: radius,
          );
        case 0:
          return PieChartSectionData(
            color: ColorRefer.kRedColor,
            value: value.toDouble(),
            title: '',
            radius: radius,
          );
        default:
          throw Error();
      }
    });
  }

}

// ignore: must_be_immutable
class PQRList extends StatefulWidget {
  PQRList({this.answer, this.function, this.question, this.qNo});
  final String question;
  int qNo = 0;
  int answer;
  final Function function;
  @override
  _PQRListState createState() => _PQRListState();
}

class _PQRListState extends State<PQRList> {
  int ans;
  @override
  void initState() {
    if(widget.answer != null)
    ans = widget.answer;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 15, right: 15, top: 12),
          child: AutoSizeText(
            widget.question,
            style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kLightColor, fontSize: 13.5, height: 1.5),
          ),
        ),

        Row(
          children: [
            Radio(
              value: 0,
              groupValue: ans,
              activeColor: ColorRefer.kRedColor,
              onChanged: (value) async{
               await widget.function(value);
               setState(() {
                 ans = value;
               });
              },
            ),
            Expanded(child: Text('Yes')),
            SizedBox(width: 2),
            Radio(
              value: 1,
              groupValue: ans,
              activeColor: ColorRefer.kRedColor,
              onChanged: (value) async{
                await widget.function(value);
                setState(() {
                  ans = value;
                });
              },
            ),
            Expanded(child: Text('No')),
          ],
        ),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Divider(color: ColorRefer.kDividerColor),
        ),
      ],
    );
  }
}
