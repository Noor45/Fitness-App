import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t_fit/screens/weight_screens/monthly_weight_history.dart';
import 'package:t_fit/screens/weight_screens/today_weight_history.dart';
import 'package:t_fit/screens/weight_screens/weekly_weight_history.dart';
import 'package:t_fit/screens/weight_screens/yearly_weight_history.dart';
import 'package:t_fit/widgets/custom_tabs.dart';
import '../../utils/colors.dart';
import '../../utils/style.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';


class WeightHistoryScreen extends StatefulWidget {
  static const String ID = "/weight_history_screen";
  @override
  _WeightHistoryScreenState createState() => _WeightHistoryScreenState();
}

class _WeightHistoryScreenState extends State<WeightHistoryScreen> {
  int willTabBarCurrentValue = 0;
  bool isShowingMainData;
  int willTabBarValue() => willTabBarCurrentValue;

  void tabBarItemClicked(int index) {
    setState(() {
      willTabBarCurrentValue = index;
    });
  }
  @override
  void initState() {
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
            'Weight Progress',
            style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15, top: 15, right: 15),
                  child: AutoSizeText(
                    'Weight Progress History',
                    style: StyleRefer.kTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, top: 20, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTabs(
                        title: 'Daily',
                        selectionColor: willTabBarCurrentValue == 0 ? ColorRefer.kRedColor : theme.lightTheme == true ? Colors.black : Colors.white,
                        onSelect: (){
                          setState(() {
                            willTabBarCurrentValue = 0;
                          });
                        },
                        barColor: willTabBarCurrentValue == 0 ? ColorRefer.kRedColor : Colors.transparent,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        fontSize: 13,
                        backColor: Colors.transparent,
                      ),
                      CustomTabs(
                        title: 'Weekly',
                        selectionColor: willTabBarCurrentValue == 1 ? ColorRefer.kRedColor :  theme.lightTheme == true ? Colors.black : Colors.white,
                        onSelect: (){
                          setState(() {
                            willTabBarCurrentValue = 1;
                          });
                        },
                        barColor: willTabBarCurrentValue == 1 ? ColorRefer.kRedColor : Colors.transparent,
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        fontSize: 13,
                        backColor: Colors.transparent,
                      ),
                      CustomTabs(
                        title: 'Monthly',
                        selectionColor: willTabBarCurrentValue == 2 ? ColorRefer.kRedColor :  theme.lightTheme == true ? Colors.black : Colors.white,
                        onSelect: (){
                          setState(() {
                            willTabBarCurrentValue = 2;
                          });
                        },
                        barColor: willTabBarCurrentValue == 2 ? ColorRefer.kRedColor : Colors.transparent,
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        fontSize: 13,
                        backColor: Colors.transparent,
                      ),
                      CustomTabs(
                        title: 'Yearly',
                        selectionColor: willTabBarCurrentValue == 3 ? ColorRefer.kRedColor :  theme.lightTheme == true ? Colors.black : Colors.white,
                        onSelect: (){
                          setState(() {
                            willTabBarCurrentValue = 3;
                          });
                        },
                        barColor: willTabBarCurrentValue == 3 ? ColorRefer.kRedColor : Colors.transparent,
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        fontSize: 13,
                        backColor: Colors.transparent,
                      ),
                    ],
                  ),
                ),

                Visibility(
                  visible: willTabBarCurrentValue == 0 ? true : false,
                  child: DailyWeight(),
                ),
                Visibility(
                  visible: willTabBarCurrentValue == 1 ? true : false,
                  child: WeeklyWeight(),
                ),
                Visibility(
                  visible: willTabBarCurrentValue == 2 ? true : false,
                  child: MonthlyWeight(),
                ),
                Visibility(
                  visible: willTabBarCurrentValue == 3 ? true : false,
                  child: YearlyWeight(),
                ),
              ],
            ),
          ),
        )
    );
  }

}


