import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:t_fit/cards/dashboard_cards.dart';
import 'package:t_fit/controllers/auth_controller.dart';
import 'package:t_fit/functions/calculator_functions.dart';
import 'package:t_fit/functions/global_functions.dart';
import 'package:t_fit/functions/weight_progress_function.dart';
import 'package:t_fit/models/user_model/user_weight_model.dart';
import 'package:t_fit/screens/weight_screens/weekly_history_screen.dart';
import 'package:t_fit/utils/constants.dart';
import 'package:t_fit/utils/style.dart';
import '../../utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class MonthlyWeight extends StatefulWidget {
  @override
  _MonthlyWeightState createState() => _MonthlyWeightState();
}

class _MonthlyWeightState extends State<MonthlyWeight> {
  final double width = 7;
  DateTime endDateTime = DateTime(DateTime.now().year, DateTime.now().month + 1, 0, 23, 59);
  DateTime startDate = DateTime(DateTime.now().year, DateTime.now().month, 1, 0, 0);
  List<UserWeightModel> monthlyWeightDetailList = [];
  List weightDetailByWeeksList = [];
  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;
  int touchedGroupIndex = -1;
  List<double> weightDiffList = [];
  List weekDatesList = [];

  getMonthlyData(){
    List<UserWeightModel> firstWeekData;
    List<UserWeightModel> secondWeekData;
    List<UserWeightModel> thirdWeekData;
    List<UserWeightModel> fourthWeekData;
    List<UserWeightModel> fifthWeekData;
    double week1 = 0.0, week2 = 0.0, week3 = 0.0, week4 = 0.0, week5 = 0.0;
    Constants.userWeightList.sort((a, b) => b.date.compareTo(a.date));
    monthlyWeightDetailList = Constants.userWeightList.where((element) => element.date.toDate().isAfter(startDate) && element.date.toDate().isBefore(endDateTime)).toList();
    DateTime firstWeekFirstDate = findFirstDateOfTheWeek(startDate);
    DateTime secondWeekFirstDate = findFirstDateOfTheWeek(startDate.add(Duration(days: 7)));
    DateTime thirdWeekFirstDate = findFirstDateOfTheWeek(startDate.add(Duration(days: 14)));
    DateTime fourthWeekFirstDate = findFirstDateOfTheWeek(startDate.add(Duration(days: 21)));
    DateTime fifthWeekFirstDate = findFirstDateOfTheWeek(startDate.add(Duration(days: 28)));
    DateTime firstWeekLastDate = findLastDateOfTheWeek(startDate);
    DateTime secondWeekLastDate = findLastDateOfTheWeek(startDate.add(Duration(days: 7)));
    DateTime thirdWeekLastDate = findLastDateOfTheWeek(startDate.add(Duration(days: 14)));
    DateTime fourthWeekLastDate = findLastDateOfTheWeek(startDate.add(Duration(days: 21)));
    DateTime fifthWeekLastDate = findLastDateOfTheWeek(startDate.add(Duration(days: 28)));

    weekDatesList = [firstWeekFirstDate, secondWeekFirstDate, thirdWeekFirstDate, fourthWeekFirstDate, fifthWeekFirstDate];

    firstWeekData = monthlyWeightDetailList.where((element) => element.date.toDate().isAfter(firstWeekFirstDate.subtract(Duration(days: 1))) && element.date.toDate().isBefore(firstWeekLastDate.add(Duration(days: 1)))).toList();
    List<double> firstWeek = getWeeklyData(firstWeekData, firstWeekFirstDate);

    secondWeekData = monthlyWeightDetailList.where((element) => element.date.toDate().isAfter(secondWeekFirstDate.subtract(Duration(days: 1))) && element.date.toDate().isBefore(secondWeekLastDate.add(Duration(days: 1)))).toList();
    List<double> secondWeek = getWeeklyData(secondWeekData, secondWeekFirstDate);

    thirdWeekData = monthlyWeightDetailList.where((element) => element.date.toDate().isAfter(thirdWeekFirstDate.subtract(Duration(days: 1))) && element.date.toDate().isBefore(thirdWeekLastDate.add(Duration(days: 1)))).toList();
    List<double> thirdWeek = getWeeklyData(thirdWeekData, thirdWeekFirstDate);

    fourthWeekData = monthlyWeightDetailList.where((element) => element.date.toDate().isAfter(fourthWeekFirstDate.subtract(Duration(days: 1))) && element.date.toDate().isBefore(fourthWeekLastDate.add(Duration(days: 1)))).toList();
    List<double> fourthWeek = getWeeklyData(fourthWeekData, fourthWeekFirstDate);

    fifthWeekData = monthlyWeightDetailList.where((element) => element.date.toDate().isAfter(fifthWeekFirstDate.subtract(Duration(days: 1))) && element.date.toDate().isBefore(fifthWeekLastDate.add(Duration(days: 1)))).toList();
    List<double> fifthWeek = getWeeklyData(fifthWeekData, fifthWeekFirstDate);

    weightDetailByWeeksList = [firstWeekData, secondWeekData, thirdWeekData, fourthWeekData, fifthWeekData];

    setState(() {
      final barGroup1 = makeGroupData(0, firstWeek[0], firstWeek[1], firstWeek[2], firstWeek[3]);
      final barGroup2 = makeGroupData(1, secondWeek[0], secondWeek[1], secondWeek[2], secondWeek[3]);
      final barGroup3 = makeGroupData(2, thirdWeek[0], thirdWeek[1], thirdWeek[2], thirdWeek[3]);
      final barGroup4 = makeGroupData(3, fourthWeek[0], fourthWeek[1], fourthWeek[2], fourthWeek[3]);
      final barGroup5 = makeGroupData(4, fifthWeek[0], fifthWeek[1], fifthWeek[2], fifthWeek[3]);
      final items = [barGroup1, barGroup2, barGroup3, barGroup4, barGroup5];
      rawBarGroups = items;
      showingBarGroups = rawBarGroups;
      [firstWeek[0], firstWeek[1], firstWeek[2], firstWeek[3]].forEach((element) {if(element != 0.0) week1++;});
      [secondWeek[0], secondWeek[1], secondWeek[2], secondWeek[3]].forEach((element) {if(element != 0.0) week2++;});
      [thirdWeek[0], thirdWeek[1], thirdWeek[2], thirdWeek[3]].forEach((element) {if(element != 0.0) week3++;});
      [fourthWeek[0], fourthWeek[1], fourthWeek[2], fourthWeek[3]].forEach((element) {if(element != 0.0) week4++;});
      [fifthWeek[0], fifthWeek[1], fifthWeek[2], fifthWeek[3]].forEach((element) {if(element != 0.0) week5++;});

      weightDiffList = [([firstWeek[0], firstWeek[1], firstWeek[2], firstWeek[3]].reduce((value, element) => value+element)/week1).isNaN == true ? 0.0 : ([firstWeek[0], firstWeek[1], firstWeek[2], firstWeek[3]].reduce((value, element) => value+element)/week1),
        ([secondWeek[0], secondWeek[1], secondWeek[2], secondWeek[3]].reduce((value, element) => value+element)/week2).isNaN == true  ? 0.0 : ([secondWeek[0], secondWeek[1], secondWeek[2], secondWeek[3]].reduce((value, element) => value+element)/week2),
        ([thirdWeek[0], thirdWeek[1], thirdWeek[2], thirdWeek[3]].reduce((value, element) => value+element)/week3).isNaN == true  ? 0.0 : ([thirdWeek[0], thirdWeek[1], thirdWeek[2], thirdWeek[3]].reduce((value, element) => value+element)/week3),
        ([fourthWeek[0], fourthWeek[1], fourthWeek[2], fourthWeek[3]].reduce((value, element) => value+element)/week4).isNaN == true  ? 0.0 : ([fourthWeek[0], fourthWeek[1], fourthWeek[2], fourthWeek[3]].reduce((value, element) => value+element)/week4),
        ([fifthWeek[0], fifthWeek[1], fifthWeek[2], fifthWeek[3]].reduce((value, element) => value+element)/week5).isNaN == true  ? 0.0 : ([fifthWeek[0], fifthWeek[1], fifthWeek[2], fifthWeek[3]].reduce((value, element) => value+element)/week5) ];
    });
  }

  getWeeklyData(List<UserWeightModel> weeklyData, DateTime weekStartDate){
    int i = 0;
    double morning = 0.0, afternoon = 0.0, evening = 0.0, night = 0.0;
    List<double> morningWeightList = List.filled(7, 0, growable: true);
    List<double> afternoonWeightList = List.filled(7, 0, growable: true);
    List<double> eveningWeightList = List.filled(7, 0, growable: true);
    List<double> nightWeightList = List.filled(7, 0, growable: true);
    while(i <= 6){
      double avgM = 0.0, avgA = 0.0, avgE = 0.0, avgN = 0.0;
      double m = 0, a = 0, e = 0, n = 0;
      weeklyData.forEach((element) {
        if(DateTime(element.date.toDate().year, element.date.toDate().month, element.date.toDate().day, 0, 0, 0) == weekStartDate.add(Duration(days: i))){
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
            print(element.date.toDate());
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
  double weight = 0.0;
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
    getMonthlyData();
    print(weightDiffList);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(right: 30, top: 20),
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
                  day: 'W ${index+1}',
                  weight: weight.round().toString().split('.0')[0],
                  diff: '${weightDiffList[index] == null ? '0':
                  '${WeightProgress.weightProgressForMonthFunction(AuthController.currentUser.selectedGoal, weightDiffList[index])[2]} ''${WeightProgress.weightProgressForMonthFunction(AuthController.currentUser.selectedGoal, weightDiffList[index])[0].toString().split('.00')[0] }'} ${AuthController.currentUser.weight['key']}',
                  color: WeightProgress.weightProgressForMonthFunction(AuthController.currentUser.selectedGoal, weightDiffList[index])[1],
                  onTap: (){
                    Navigator.pushNamed(context, WeeklyWeightHistoryScreen.ID, arguments: [weightDetailByWeeksList[index], weekDatesList[index]]);
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
          case 0:
            return 'W1';
          case 1:
            return 'W2';
          case 2:
            return 'W3';
          case 3:
            return 'W4';
          case 4:
            return 'W5';
          default:
            return '';
        }
      }
  );
}