import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:t_fit/cards/dashboard_cards.dart';
import 'package:t_fit/controllers/auth_controller.dart';
import 'package:t_fit/functions/calculator_functions.dart';
import 'package:t_fit/functions/weight_progress_function.dart';
import 'package:t_fit/models/user_model/user_weight_model.dart';
import 'package:t_fit/screens/weight_screens/monthly_history_screen.dart';
import 'package:t_fit/utils/constants.dart';
import 'package:t_fit/utils/style.dart';
import '../../utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class YearlyWeight extends StatefulWidget {
  @override
  _YearlyWeightState createState() => _YearlyWeightState();
}

class _YearlyWeightState extends State<YearlyWeight> {
  double weight = 0.0;
  final double width = 4;
  int touchedGroupIndex = -1;
  List<double> weightDiffList = [];
  List weightDetailByMonthsList = [];
  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;
  List<UserWeightModel> yearlyWeightDetailList = [];
  List months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  double weightConversion(double value, String key){
    if(AuthController.currentUser.weight['key'] == 'kg' && key == 'pound'){
      return lbsToKg(weight: value);
    }
    else if(AuthController.currentUser.weight['key'] == 'pound' && key == 'kg'){
      return kgToLbs(weight: value);
    }else{
      return value;
    }
  }

  @override
  void initState() {
    weight = weightConversion(AuthController.currentUser.weight['value'], AuthController.currentUser.weight['key']);
    filterYearlyData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          child: AspectRatio(
            aspectRatio: 1.5,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceBetween,
                titlesData: titlesData,
                borderData: FlBorderData(show: false),
                barGroups: showingBarGroups,
                gridData: FlGridData(show: false),
              ),
            ),
          ),
        ),
        SizedBox(height: 5),
        Divider(color: theme.lightTheme == true ? Colors.transparent : ColorRefer.kDividerColor, thickness: 7),
        Container(
          width: MediaQuery.of(context).size.width,
          color: theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
          padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
          child: Text('History', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: weightDiffList.length,
            itemBuilder: (BuildContext context, int index) {
              return  Container(
                margin: EdgeInsets.only(top: 15),
                child: WeightHistoryCard(
                  day: months[index],
                  weight: weight.round().toString().split('.0')[0],
                  diff: '${weightDiffList[index] == null ? '0':
                  '${WeightProgress.weightProgressForMonthFunction(AuthController.currentUser.selectedGoal, weightDiffList[index])[2]} ''${WeightProgress.weightProgressForMonthFunction(AuthController.currentUser.selectedGoal, weightDiffList[index])[0].toString().split('.00')[0] }'} ${AuthController.currentUser.weight['key']}',
                  color: WeightProgress.weightProgressForMonthFunction(AuthController.currentUser.selectedGoal, weightDiffList[index])[1],
                  onTap: (){
                    Navigator.pushNamed(context, MonthlyWeightHistoryScreen.ID, arguments: weightDetailByMonthsList[index]);
                  },
                ),
              );
            }),
      ],
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2, double y3, double y4) {
    return BarChartGroupData(
        barsSpace: 1, x: x, barRods: [
      BarChartRodData(
        y: y1,
        colors: [Color(0xff2bdb90)],
        width: width,
      ),
      BarChartRodData(
        y: y2,
        colors: [Color(0xffffdd80)],
        width: width,
      ),
      BarChartRodData(
        y: y3,
        colors: [Color(0xffff4d94)],
        width: width,
      ),
      BarChartRodData(
        y: y4,
        colors: [Color(0xff19bfff)],
        width: width,
      ),
    ]);
  }
  LineTouchData get lineTouchData => LineTouchData(enabled: false);
  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: bottomTitles,
    rightTitles: SideTitles(showTitles: false),
    topTitles: SideTitles(showTitles: false),
    leftTitles: SideTitles(showTitles: true, getTextStyles: (context, value) => StyleRefer.kTextStyle.copyWith(color: Color(0xff939393), fontSize: 10, height: 1.4 )),
  );
  SideTitles get bottomTitles => SideTitles(
      showTitles: true,
      getTextStyles: (context, value) => StyleRefer.kTextStyle.copyWith(color: Color(0xff939393), fontSize: 10, height: 1.4 ),
      margin: 20,
      getTitles: (double value) {
        switch (value.toInt()) {
          case 12:
            return '';
          case 11:
            return 'Dec';
          case 10:
            return 'Nov';
          case 9:
            return 'Oct';
          case 8:
            return 'Sep';
          case 7:
            return 'Aug';
          case 6:
            return 'Jul';
          case 5:
            return 'Jun';
          case 4:
            return 'May';
          case 3:
            return 'Apr';
          case 2:
            return 'Mar';
          case 1:
            return 'Feb';
          case 0:
            return 'Jan';
        }
        return '';
      }
  );

  filterYearlyData() {
    setState(() {
      double m1 = 0.0, m2 = 0.0, m3 = 0.0, m4 = 0.0, m5 = 0.0, m6 = 0.0, m7 = 0.0, m8 = 0.0, m9 = 0.0, m10 = 0.0, m11 = 0.0, m12 = 0.0;
      DateTime startDate = DateTime(DateTime.now().year, 1, 1, 0, 0);
      DateTime endDateTime = DateTime(DateTime.now().year, 12, 0, 23, 59);
      DateTime firstMonthFirstDate = DateTime(DateTime.now().year, 1, 1, 0, 0);
      DateTime secondMonthFirstDate = DateTime(DateTime.now().year, 2, 1, 0, 0);
      DateTime thirdMonthFirstDate = DateTime(DateTime.now().year, 3, 1, 0, 0);
      DateTime forthMonthFirstDate = DateTime(DateTime.now().year, 4, 1, 0, 0);
      DateTime fifthMonthFirstDate = DateTime(DateTime.now().year, 5, 1, 0, 0);
      DateTime sixthMonthFirstDate = DateTime(DateTime.now().year, 6, 1, 0, 0);
      DateTime seventhMonthFirstDate = DateTime(DateTime.now().year, 7, 1, 0, 0);
      DateTime eightMonthFirstDate = DateTime(DateTime.now().year, 8, 1, 0, 0);
      DateTime ninthMonthFirstDate = DateTime(DateTime.now().year, 9, 1, 0, 0);
      DateTime tenthMonthFirstDate = DateTime(DateTime.now().year, 10, 1, 0, 0);
      DateTime eleventhMonthFirstDate = DateTime(DateTime.now().year, 11, 1, 0, 0);
      DateTime twelveMonthFirstDate = DateTime(DateTime.now().year, 12, 1, 0, 0);

      DateTime firstMonthLastDate = DateTime(DateTime.now().year, 2, 0, 23, 59);
      DateTime secondMonthLastDate = DateTime(DateTime.now().year, 3, 0, 23, 59);
      DateTime thirdMonthLastDate = DateTime(DateTime.now().year, 4, 0, 23, 59);
      DateTime forthMonthLastDate = DateTime(DateTime.now().year, 5, 0, 23, 59);
      DateTime fifthMonthLastDate = DateTime(DateTime.now().year, 6, 0, 23, 59);
      DateTime sixthMonthLastDate = DateTime(DateTime.now().year, 7, 0, 23, 59);
      DateTime seventhMonthLastDate = DateTime(DateTime.now().year, 8, 0, 23, 59);
      DateTime eightMonthLastDate = DateTime(DateTime.now().year, 9, 0, 23, 59);
      DateTime ninthMonthLastDate = DateTime(DateTime.now().year, 10, 0, 23, 59);
      DateTime tenthMonthLastDate = DateTime(DateTime.now().year, 11, 0, 23, 59);
      DateTime eleventhMonthLastDate = DateTime(DateTime.now().year, 12, 0, 23, 59);
      DateTime twelveMonthLastDate = DateTime(DateTime.now().year+1, 1, 0, 23, 59);

      Constants.userWeightList.sort((a, b) => b.date.compareTo(a.date));
      yearlyWeightDetailList = Constants.userWeightList.where((element) => element.date.toDate().isAfter(startDate) && element.date.toDate().isBefore(endDateTime)).toList();
      List<double> month1 = getMonthlyData(yearlyWeightDetailList.where((element) => element.date.toDate().isAfter(firstMonthFirstDate.subtract(Duration(days: 1))) && element.date.toDate().isBefore(firstMonthLastDate.add(Duration(days: 1)))).toList(), firstMonthFirstDate, firstMonthLastDate);
      List<double> month2 = getMonthlyData(yearlyWeightDetailList.where((element) => element.date.toDate().isAfter(secondMonthFirstDate.subtract(Duration(days: 1))) && element.date.toDate().isBefore(secondMonthLastDate.add(Duration(days: 1)))).toList(), secondMonthFirstDate, secondMonthLastDate);
      List<double> month3 = getMonthlyData(yearlyWeightDetailList.where((element) => element.date.toDate().isAfter(thirdMonthFirstDate.subtract(Duration(days: 1))) && element.date.toDate().isBefore(thirdMonthLastDate.add(Duration(days: 1)))).toList(), thirdMonthFirstDate, thirdMonthLastDate);
      List<double> month4 = getMonthlyData(yearlyWeightDetailList.where((element) => element.date.toDate().isAfter(forthMonthFirstDate.subtract(Duration(days: 1))) && element.date.toDate().isBefore(forthMonthLastDate.add(Duration(days: 1)))).toList(), forthMonthFirstDate, forthMonthLastDate);
      List<double> month5 = getMonthlyData(yearlyWeightDetailList.where((element) => element.date.toDate().isAfter(fifthMonthFirstDate.subtract(Duration(days: 1))) && element.date.toDate().isBefore(fifthMonthLastDate.add(Duration(days: 1)))).toList(), fifthMonthFirstDate, fifthMonthLastDate);
      List<double> month6 = getMonthlyData(yearlyWeightDetailList.where((element) => element.date.toDate().isAfter(sixthMonthFirstDate.subtract(Duration(days: 1))) && element.date.toDate().isBefore(sixthMonthLastDate.add(Duration(days: 1)))).toList(), sixthMonthFirstDate, sixthMonthLastDate);
      List<double> month7 = getMonthlyData(yearlyWeightDetailList.where((element) => element.date.toDate().isAfter(seventhMonthFirstDate.subtract(Duration(days: 1))) && element.date.toDate().isBefore(seventhMonthLastDate.add(Duration(days: 1)))).toList(), seventhMonthFirstDate, seventhMonthLastDate);
      List<double> month8 = getMonthlyData(yearlyWeightDetailList.where((element) => element.date.toDate().isAfter(eightMonthFirstDate.subtract(Duration(days: 1))) && element.date.toDate().isBefore(eightMonthLastDate.add(Duration(days: 1)))).toList(), eightMonthFirstDate, eightMonthLastDate);
      List<double> month9 = getMonthlyData(yearlyWeightDetailList.where((element) => element.date.toDate().isAfter(ninthMonthFirstDate.subtract(Duration(days: 1))) && element.date.toDate().isBefore(ninthMonthLastDate.add(Duration(days: 1)))).toList(), ninthMonthFirstDate, ninthMonthLastDate);
      List<double> month10 = getMonthlyData(yearlyWeightDetailList.where((element) => element.date.toDate().isAfter(tenthMonthFirstDate.subtract(Duration(days: 1))) && element.date.toDate().isBefore(tenthMonthLastDate.add(Duration(days: 1)))).toList(), tenthMonthFirstDate, tenthMonthLastDate);
      List<double> month11 = getMonthlyData(yearlyWeightDetailList.where((element) => element.date.toDate().isAfter(eleventhMonthFirstDate.subtract(Duration(days: 1))) && element.date.toDate().isBefore(eleventhMonthLastDate.add(Duration(days: 1)))).toList(), eleventhMonthFirstDate, eleventhMonthLastDate);
      List<double> month12 = getMonthlyData(yearlyWeightDetailList.where((element) => element.date.toDate().isAfter(twelveMonthFirstDate.subtract(Duration(days: 1))) && element.date.toDate().isBefore(twelveMonthLastDate.add(Duration(days: 1)))).toList(), twelveMonthFirstDate, twelveMonthLastDate);

      setState(() {
        final barGroup1 = makeGroupData(0, month1[0], month1[1], month1[2], month1[3]);
        final barGroup2 = makeGroupData(1, month2[0], month2[1], month2[2], month2[3]);
        final barGroup3 = makeGroupData(2, month3[0], month3[1], month3[2], month3[3]);
        final barGroup4 = makeGroupData(3, month4[0], month4[1], month4[2], month4[3]);
        final barGroup5 = makeGroupData(4, month5[0], month5[1], month5[2], month5[3]);
        final barGroup6 = makeGroupData(5, month6[0], month6[1], month6[2], month6[3]);
        final barGroup7 = makeGroupData(6, month7[0], month7[1], month7[2], month7[3]);
        final barGroup8 = makeGroupData(7, month8[0], month8[1], month8[2], month8[3]);
        final barGroup9 = makeGroupData(8, month9[0], month9[1], month9[2], month9[3]);
        final barGroup10 = makeGroupData(9, month10[0], month10[1], month10[2], month10[3]);
        final barGroup11 = makeGroupData(10, month11[0], month11[1], month11[2], month11[3]);
        final barGroup12 = makeGroupData(11, month12[0], month12[1], month12[2], month12[3]);
        final items = [barGroup1, barGroup2, barGroup3, barGroup4, barGroup5, barGroup6, barGroup7, barGroup8, barGroup9, barGroup10, barGroup11, barGroup12];
        rawBarGroups = items;
        showingBarGroups = rawBarGroups;
      });

      [month1[0], month1[1], month1[2], month1[3]].forEach((element) {if(element != 0.0) m1++;});
      [month2[0], month2[1], month2[2], month2[3]].forEach((element) {if(element != 0.0) m2++;});
      [month3[0], month3[1], month3[2], month3[3]].forEach((element) {if(element != 0.0) m3++;});
      [month4[0], month4[1], month4[2], month4[3]].forEach((element) {if(element != 0.0) m4++;});
      [month5[0], month5[1], month5[2], month5[3]].forEach((element) {if(element != 0.0) m5++;});
      [month6[0], month6[1], month6[2], month6[3]].forEach((element) {if(element != 0.0) m6++;});
      [month7[0], month7[1], month7[2], month7[3]].forEach((element) {if(element != 0.0) m7++;});
      [month8[0], month8[1], month8[2], month8[3]].forEach((element) {if(element != 0.0) m8++;});
      [month9[0], month9[1], month9[2], month9[3]].forEach((element) {if(element != 0.0) m9++;});
      [month10[0], month10[1], month10[2], month10[3]].forEach((element) {if(element != 0.0) m10++;});
      [month11[0], month11[1], month11[2], month11[3]].forEach((element) {if(element != 0.0) m11++;});
      [month12[0], month12[1], month12[2], month12[3]].forEach((element) {if(element != 0.0) m12++;});

      weightDiffList = [([month1[0], month1[1], month1[2], month1[3]].reduce((value, element) => value+element)/m1).isNaN == true ? 0.0 : ([month1[0], month1[1], month1[2], month1[3]].reduce((value, element) => value+element)/m1),
        ([month2[0], month2[1], month2[2], month2[3]].reduce((value, element) => value+element)/m2).isNaN == true  ? 0.0 : ([month2[0], month2[1], month2[2], month2[3]].reduce((value, element) => value+element)/m2),
        ([month3[0], month3[1], month3[2], month3[3]].reduce((value, element) => value+element)/m3).isNaN == true  ? 0.0 : ([month3[0], month3[1], month3[2], month3[3]].reduce((value, element) => value+element)/m3),
        ([month4[0], month4[1], month4[2], month4[3]].reduce((value, element) => value+element)/m4).isNaN == true  ? 0.0 : ([month4[0], month4[1], month4[2], month4[3]].reduce((value, element) => value+element)/m4),
        ([month5[0], month5[1], month5[2], month5[3]].reduce((value, element) => value+element)/m5).isNaN == true  ? 0.0 : ([month5[0], month5[1], month5[2], month5[3]].reduce((value, element) => value+element)/m5),
        ([month6[0], month6[1], month6[2], month6[3]].reduce((value, element) => value+element)/m6).isNaN == true  ? 0.0 : ([month6[0], month6[1], month6[2], month6[3]].reduce((value, element) => value+element)/m6),
        ([month7[0], month7[1], month7[2], month7[3]].reduce((value, element) => value+element)/m7).isNaN == true  ? 0.0 : ([month7[0], month7[1], month7[2], month7[3]].reduce((value, element) => value+element)/m7),
        ([month8[0], month8[1], month8[2], month8[3]].reduce((value, element) => value+element)/m8).isNaN == true  ? 0.0 : ([month8[0], month8[1], month8[2], month8[3]].reduce((value, element) => value+element)/m8),
        ([month9[0], month9[1], month9[2], month9[3]].reduce((value, element) => value+element)/m9).isNaN == true  ? 0.0 : ([month9[0], month9[1], month9[2], month9[3]].reduce((value, element) => value+element)/m9),
        ([month10[0], month10[1], month10[2], month10[3]].reduce((value, element) => value+element)/m10).isNaN == true  ? 0.0 : ([month10[0], month10[1], month10[2], month10[3]].reduce((value, element) => value+element)/m10),
        ([month11[0], month11[1], month11[2], month11[3]].reduce((value, element) => value+element)/m11).isNaN == true  ? 0.0 : ([month11[0], month11[1], month11[2], month11[3]].reduce((value, element) => value+element)/m11),
        ([month12[0], month12[1], month12[2], month12[3]].reduce((value, element) => value+element)/m12).isNaN == true  ? 0.0 : ([month12[0], month12[1], month12[2], month12[3]].reduce((value, element) => value+element)/m12),
      ];
      weightDetailByMonthsList = [
        yearlyWeightDetailList.where((element) => element.date.toDate().isAfter(firstMonthFirstDate.subtract(Duration(days: 1))) && element.date.toDate().isBefore(firstMonthLastDate.add(Duration(days: 1)))).toList(),
        yearlyWeightDetailList.where((element) => element.date.toDate().isAfter(secondMonthFirstDate.subtract(Duration(days: 1))) && element.date.toDate().isBefore(secondMonthLastDate.add(Duration(days: 1)))).toList(),
        yearlyWeightDetailList.where((element) => element.date.toDate().isAfter(thirdMonthFirstDate.subtract(Duration(days: 1))) && element.date.toDate().isBefore(thirdMonthLastDate.add(Duration(days: 1)))).toList(),
        yearlyWeightDetailList.where((element) => element.date.toDate().isAfter(forthMonthFirstDate.subtract(Duration(days: 1))) && element.date.toDate().isBefore(forthMonthLastDate.add(Duration(days: 1)))).toList(),
        yearlyWeightDetailList.where((element) => element.date.toDate().isAfter(fifthMonthFirstDate.subtract(Duration(days: 1))) && element.date.toDate().isBefore(fifthMonthLastDate.add(Duration(days: 1)))).toList(),
        yearlyWeightDetailList.where((element) => element.date.toDate().isAfter(sixthMonthFirstDate.subtract(Duration(days: 1))) && element.date.toDate().isBefore(sixthMonthLastDate.add(Duration(days: 1)))).toList(),
        yearlyWeightDetailList.where((element) => element.date.toDate().isAfter(seventhMonthFirstDate.subtract(Duration(days: 1))) && element.date.toDate().isBefore(seventhMonthLastDate.add(Duration(days: 1)))).toList(),
        yearlyWeightDetailList.where((element) => element.date.toDate().isAfter(eightMonthFirstDate.subtract(Duration(days: 1))) && element.date.toDate().isBefore(eightMonthLastDate.add(Duration(days: 1)))).toList(),
        yearlyWeightDetailList.where((element) => element.date.toDate().isAfter(ninthMonthFirstDate.subtract(Duration(days: 1))) && element.date.toDate().isBefore(ninthMonthLastDate.add(Duration(days: 1)))).toList(),
        yearlyWeightDetailList.where((element) => element.date.toDate().isAfter(tenthMonthFirstDate.subtract(Duration(days: 1))) && element.date.toDate().isBefore(tenthMonthLastDate.add(Duration(days: 1)))).toList(),
        yearlyWeightDetailList.where((element) => element.date.toDate().isAfter(eleventhMonthFirstDate.subtract(Duration(days: 1))) && element.date.toDate().isBefore(eleventhMonthLastDate.add(Duration(days: 1)))).toList(),
        yearlyWeightDetailList.where((element) => element.date.toDate().isAfter(twelveMonthFirstDate.subtract(Duration(days: 1))) && element.date.toDate().isBefore(twelveMonthLastDate.add(Duration(days: 1)))).toList(),
      ];
    });
  }
  List<double> getMonthlyRecord(List<UserWeightModel> data) {
    int f1 = 0;
    double w = 0;
    double diff = 0;
    if (data.length != 0) {
      data.forEach((element) {
        w = w + weightConversion(element.weight, element.key);
        diff = diff + (weightConversion(element.weight, element.key) - weight);
        f1++;
      });
      w = (w / f1);
      diff = (diff / f1);
    }
    return [w, diff];
  }
  getMonthlyData(List<UserWeightModel> monthlyData, DateTime monthlyStartDate, DateTime monthlyEndDate){
    int daysInMonth = DateTimeRange(start: monthlyStartDate, end: monthlyEndDate.add(Duration(days: 1))).duration.inDays;
    int i = 0;
    double morning = 0.0, afternoon = 0.0, evening = 0.0, night = 0.0;
    List<double> morningWeightList = List.filled(daysInMonth, 0, growable: true);
    List<double> afternoonWeightList = List.filled(daysInMonth, 0, growable: true);
    List<double> eveningWeightList = List.filled(daysInMonth, 0, growable: true);
    List<double> nightWeightList = List.filled(daysInMonth, 0, growable: true);
    while(i <= (daysInMonth-1)){
      double avgM = 0.0, avgA = 0.0, avgE = 0.0, avgN = 0.0;
      double m = 0, a = 0, e = 0, n = 0;
      monthlyData.forEach((element) {
        if(DateTime(element.date.toDate().year, element.date.toDate().month, element.date.toDate().day, 0, 0, 0) == monthlyStartDate.add(Duration(days: i))){
          if(element.date.toDate().isAfter(DateTime(element.date.toDate().year, element.date.toDate().month, element.date.toDate().day, 05, 0, 0).subtract(Duration(minutes: 1))) && element.date.toDate().isBefore(DateTime(element.date.toDate().year, element.date.toDate().month, element.date.toDate().day, 10, 0, 0).add(Duration(minutes: 1)))){
            setState(() {
              m = m + 1;
              avgM = (avgM + double.parse((weightConversion(element.weight, element.key)-weight).toStringAsFixed(1)));
              morningWeightList.removeAt(i);
              morningWeightList.insert(i, avgM/m);
            });
          }
          else if(element.date.toDate().isAfter(DateTime(element.date.toDate().year, element.date.toDate().month, element.date.toDate().day, 10, 0, 0)) && element.date.toDate().isBefore(DateTime(element.date.toDate().year, element.date.toDate().month, element.date.toDate().day, 15, 0, 0).add(Duration(minutes: 1)))){
            setState(() {
              avgA = (avgA + double.parse((weightConversion(element.weight, element.key)-weight).toStringAsFixed(1)));
              a = a + 1;
              afternoonWeightList.removeAt(i);
              afternoonWeightList.insert(i, avgA/a);
            });
          }
          else if(element.date.toDate().isAfter(DateTime(element.date.toDate().year, element.date.toDate().month, element.date.toDate().day, 15, 0, 0)) && element.date.toDate().isBefore(DateTime(element.date.toDate().year, element.date.toDate().month, element.date.toDate().day, 19, 0, 0).add(Duration(minutes: 1)))){
            setState(() {
              e = e + 1;
              avgE = (avgE + double.parse((weightConversion(element.weight, element.key)-weight).toStringAsFixed(1)));
              eveningWeightList.removeAt(i);
              eveningWeightList.insert(i, avgE/e);
            });
          }
          else if(element.date.toDate().isAfter(DateTime(element.date.toDate().year, element.date.toDate().month, element.date.toDate().day, 19, 0, 0)) && element.date.toDate().isBefore(DateTime(element.date.toDate().year, element.date.toDate().month, element.date.toDate().day+1, 05, 0, 0).subtract(Duration(minutes: 1)))){
            setState(() {
              n = n + 1;
              avgN = (avgN + double.parse((weightConversion(element.weight, element.key)-weight).toStringAsFixed(1)));
              nightWeightList.removeAt(i);
              nightWeightList.insert(i, avgN/n);
            });
          }
          else{
            setState(() {
              n = n + 1;
              avgN = (avgN + double.parse((weightConversion(element.weight, element.key)-weight).toStringAsFixed(1)));
              nightWeightList.removeAt(i);
              nightWeightList.insert(i, avgN/n);
            });
          }
        }
      });
      i++;
    }
    morningWeightList.forEach((element) {if(element != 0.0) morning++;});
    afternoonWeightList.forEach((element) {if(element != 0.0) afternoon++;});
    eveningWeightList.forEach((element) {if(element != 0.0) evening++;});
    nightWeightList.forEach((element) {if(element != 0.0) night++;});
    return [(morningWeightList.reduce((value, element) => value+element)/morning).isNaN == true ? 0.0 : (morningWeightList.reduce((value, element) => value+element)/morning), (afternoonWeightList.reduce((value, element) => value+element)/afternoon).isNaN == true  ? 0.0 : (afternoonWeightList.reduce((value, element) => value+element)/afternoon),
      (eveningWeightList.reduce((value, element) => value+element)/evening).isNaN == true  ? 0.0 : (eveningWeightList.reduce((value, element) => value+element)/evening), (nightWeightList.reduce((value, element) => value+element)/night).isNaN == true  ? 0.0 : (nightWeightList.reduce((value, element) => value+element)/night)];
  }
}