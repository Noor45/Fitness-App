import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../../../cards/custom_cards.dart';
import '../../../cards/diet_plan_card.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/style.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';
import '../../../screens/diet_plan_screens/supplements_plan/suppliment_plan_detail_screen.dart';


class SupplementWeekPlanScreen extends StatefulWidget {
  static const String ID = "/supplement_week_plan_screen";
  @override
  _SupplementWeekPlanScreenState createState() => _SupplementWeekPlanScreenState();
}

class _SupplementWeekPlanScreenState extends State<SupplementWeekPlanScreen> {
  bool _isLoading = false;
  List weekDays = [];
  weekList(int week){
    setState(() {
      int i = 0;
      var formatter = new DateFormat('EEEE');
      for( i = (week*7)-7; i<(week*7); i++){
        if( Constants.supplementPlanDetail.startDate.toDate().isAfter(Constants.supplementPlanDetail.endDate.toDate().add(Duration(days: i)))) return;
        else weekDays.add(formatter.format(Constants.supplementPlanDetail.startDate.toDate().add(Duration(days: i))));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    int week = ModalRoute.of(context).settings.arguments;
    weekList(week);
    return Scaffold(
        backgroundColor:  theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
        appBar: AppBar(
          elevation: theme.lightTheme == true ? 3 : 0,
          iconTheme: IconThemeData(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
          systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
          centerTitle: true,
          title: Text(
            'WEEK $week',
            style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 15),
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: _isLoading,
          progressIndicator: CircularProgressIndicator(
            color: ColorRefer.kRedColor,
          ),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ImageCard(
                    image: 'assets/images/supplements.png',
                    title: 'Supplements',
                    subtitle: '',
                  ),
                  SizedBox(height: 15),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: Constants.userWeeklySupplementsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return  Container(
                          margin: EdgeInsets.only(top: 15),
                          child: SupplementPlanCard(
                            title: 'Day ${index+1} ${weekDays[index]}',
                            supplement: Constants.userWeeklySupplementsList[index].name,
                            onPressed: () async{
                              if(Constants.userWeeklySupplementsList[index].name != 'off'){
                                Navigator.pushNamed(context, SupplementPlanDetailScreen.ID, arguments: [Constants.userWeeklySupplementsList[index], weekDays[index]]);
                              }
                            },
                          ),
                        );
                      }),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
        )
    );
  }
}






