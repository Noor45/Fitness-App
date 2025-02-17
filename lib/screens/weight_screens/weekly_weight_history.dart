import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:t_fit/cards/dashboard_cards.dart';
import 'package:t_fit/controllers/auth_controller.dart';
import 'package:t_fit/functions/calculator_functions.dart';
import 'package:t_fit/functions/weight_progress_function.dart';
import 'package:t_fit/models/user_model/user_weight_model.dart';
import 'package:t_fit/utils/constants.dart';
import 'package:t_fit/utils/style.dart';
import '../../utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';


class WeeklyWeight extends StatefulWidget {
  @override
  _WeeklyWeightState createState() => _WeeklyWeightState();
}

class _WeeklyWeightState extends State<WeeklyWeight> {
  double weight = 0.0;
  final double width = 7;
  int touchedGroupIndex = -1;
  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;
  List<UserWeightModel> weightDetailList = [];
  List<UserWeightModel> morningWeightDetailList = [];
  List<UserWeightModel> afternoonWeightDetailList = [];
  List<UserWeightModel> eveningWeightDetailList = [];
  List<UserWeightModel> nightWeightDetailList = [];
  List<double> weightDiffList = [];
  List weightDiffOfTimeList = [];
  List time = [
    {'time': 'Morning', 'color': Color(0xff2bdb90) },
    {'time': 'Afternoon', 'color': Color(0xffffdd80) },
    {'time': 'Evening', 'color': Color(0xffff4d94) },
    {'time': 'Night', 'color': Color(0xff19bfff) }];
  DateTime startDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,).subtract(Duration(days: DateTime.now().weekday - 1));
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
    getWeeklyData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Container(
      child: Column(
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
              itemBuilder: (BuildContext context, int count) {
                return  Container(
                  margin: EdgeInsets.only(top: 15),
                  child: WeightHistoryCardExpandable(
                    widget: ListView.builder(
                     physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: (BuildContext context, int index) {
                          List dateWightList = [];
                           dateWightList = [
                            morningWeightDetailList.where((element) => DateFormat('EEE').format(element.date.toDate()) == DateFormat('EEE').format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,).subtract(Duration(days: DateTime.now().weekday - count-1)))).toList(),
                            afternoonWeightDetailList.where((element) => DateFormat('EEE').format(element.date.toDate()) == DateFormat('EEE').format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,).subtract(Duration(days: DateTime.now().weekday - count-1)))).toList(),
                            eveningWeightDetailList.where((element) => DateFormat('EEE').format(element.date.toDate()) == DateFormat('EEE').format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,).subtract(Duration(days: DateTime.now().weekday - count-1)))).toList(),
                            nightWeightDetailList.where((element) => DateFormat('EEE').format(element.date.toDate()) == DateFormat('EEE').format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,).subtract(Duration(days: DateTime.now().weekday - count-1)))).toList(),
                          ];
                          return  Container(
                            margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                            child: WeightHistoryCardExpandable(
                              widget: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: dateWightList[index].length,
                                  itemBuilder: (BuildContext context, int i) {
                                    return  Container(
                                      margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                                      child: WeightHistoryCardWithInfo(
                                        diff: '${dateWightList[index][i].weight == null ? '0': '${WeightProgress.weightProgressFunction(AuthController.currentUser.selectedGoal, weightConversion(dateWightList[index][i].weight, dateWightList[index][i].key), weight)[2]} ''${WeightProgress.weightProgressFunction(AuthController.currentUser.selectedGoal, weightConversion(dateWightList[index][i].weight, dateWightList[index][i].key), weight)[0].toString().split('.0')[0] }'} ${AuthController.currentUser.weight['key']}',
                                        day: DateFormat.jm().format(DateFormat("hh:mm:ss").parse("${dateWightList[index][i].date.toDate().hour}:${dateWightList[index][i].date.toDate().minute}:00")).toString(),
                                        weight: weight.round().toString().split('.0')[0],
                                        note: dateWightList[index][i].note,
                                        color: WeightProgress.weightProgressFunction(AuthController.currentUser.selectedGoal, weightConversion(dateWightList[index][i].weight, dateWightList[index][i].key), weight)[1],
                                      ),
                                    );
                                  }
                              ),
                              diff: '${weightDiffOfTimeList[count][index] == null ? '0':
                              '${WeightProgress.weightProgressForMonthFunction(AuthController.currentUser.selectedGoal, weightDiffOfTimeList[count][index])[2]} ''${WeightProgress.weightProgressForMonthFunction(AuthController.currentUser.selectedGoal, weightDiffOfTimeList[count][index])[0].toString().split('.00')[0] }'} ${AuthController.currentUser.weight['key']}',
                              day: time[index]['time'],
                              dayColor: time[index]['color'],
                              weight: weight.round().toString().split('.0')[0],
                              color: WeightProgress.weightProgressForMonthFunction(AuthController.currentUser.selectedGoal, weightDiffOfTimeList[count][index])[1],
                            ),
                          );
                        }
                    ),
                    diff: '${weightDiffList[count] == null ? '0':
                    '${WeightProgress.weightProgressForMonthFunction(AuthController.currentUser.selectedGoal, weightDiffList[count])[2]} ''${WeightProgress.weightProgressForMonthFunction(AuthController.currentUser.selectedGoal, weightDiffList[count])[0].toString().split('.00')[0] }'} ${AuthController.currentUser.weight['key']}',
                    day: '${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,).subtract(Duration(days: DateTime.now().weekday - count-1)).day}/${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,).subtract(Duration(days: DateTime.now().weekday - count-1)).month} (${DateFormat('EEE').format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,).subtract(Duration(days: DateTime.now().weekday - count-1))) })',
                    weight: weight.round().toString().split('.0')[0],
                    dayColor: theme.lightTheme == true ? Colors.black : Colors.white,
                    color: WeightProgress.weightProgressForMonthFunction(AuthController.currentUser.selectedGoal, weightDiffList[count])[1],
                  ),
                );
              }),
        ],
      ),
    );
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
            return 'Mon';
          case 1:
            return 'Tue';
          case 2:
            return 'Wed';
          case 3:
            return 'Thu';
          case 4:
            return 'Fri';
          case 5:
            return 'Sat';
          case 6:
            return 'Sun';
          default:
            return '';
        }
      }
  );
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
  getWeeklyData(){
    List<double> morningWeightList = List.filled(7, 0, growable: true);
    List<double> afternoonWeightList = List.filled(7, 0, growable: true);
    List<double> eveningWeightList = List.filled(7, 0, growable: true);
    List<double> nightWeightList = List.filled(7, 0, growable: true);
    double day1 = 0.0, day2 = 0.0, day3 = 0.0, day4 = 0.0, day5 = 0.0, day6 = 0.0, day7 = 0.0;
    int i = DateTime.monday-1;
    Constants.userWeightList.sort((a, b) => b.date.compareTo(a.date));
    while(i <= DateTime.sunday){
      double avgM = 0.0, avgA = 0.0, avgE = 0.0, avgN = 0.0;
      double m = 0, a = 0, e = 0, n = 0;
      Constants.userWeightList.forEach((element) {
        if(DateTime(element.date.toDate().year, element.date.toDate().month, element.date.toDate().day, 0, 0, 0) == startDate.add(Duration(days: i))){
          if(element.date.toDate().isAfter(DateTime(element.date.toDate().year, element.date.toDate().month, element.date.toDate().day, 05, 0, 0).subtract(Duration(minutes: 1))) && element.date.toDate().isBefore(DateTime(element.date.toDate().year, element.date.toDate().month, element.date.toDate().day, 10, 0, 0).add(Duration(minutes: 1)))){
            setState(() {
              m = m + 1;
              avgM = (avgM + double.parse((weightConversion(element.weight, element.key)-weight).toStringAsFixed(1)));
              morningWeightList.removeAt(i);
              morningWeightDetailList.add(element);
              morningWeightList.insert(i, double.parse((avgM/m).toStringAsFixed(1)));
            });
          }
          else if(element.date.toDate().isAfter(DateTime(element.date.toDate().year, element.date.toDate().month, element.date.toDate().day, 10, 0, 0)) && element.date.toDate().isBefore(DateTime(element.date.toDate().year, element.date.toDate().month, element.date.toDate().day, 15, 0, 0).add(Duration(minutes: 1)))){
            setState(() {
              avgA = (avgA + double.parse((weightConversion(element.weight, element.key)-weight).toStringAsFixed(1)));
              a = a + 1;
              afternoonWeightList.removeAt(i);
              afternoonWeightDetailList.add(element);
              afternoonWeightList.insert(i, double.parse((avgA/a).toStringAsFixed(1)));
            });
          }
          else if(element.date.toDate().isAfter(DateTime(element.date.toDate().year, element.date.toDate().month, element.date.toDate().day, 15, 0, 0)) && element.date.toDate().isBefore(DateTime(element.date.toDate().year, element.date.toDate().month, element.date.toDate().day, 19, 0, 0).add(Duration(minutes: 1)))){
            setState(() {
              e = e + 1;
              avgE = (avgE + double.parse((weightConversion(element.weight, element.key)-weight).toStringAsFixed(1)));
              eveningWeightList.removeAt(i);
              eveningWeightDetailList.add(element);
              eveningWeightList.insert(i, double.parse((avgE/e).toStringAsFixed(1)));
            });
          }
          else if(element.date.toDate().isAfter(DateTime(element.date.toDate().year, element.date.toDate().month, element.date.toDate().day, 19, 0, 0)) && element.date.toDate().isBefore(DateTime(element.date.toDate().year, element.date.toDate().month, element.date.toDate().day, 23, 59, 59).subtract(Duration(minutes: 1)))){
            setState(() {
              n = n + 1;
              avgN = (avgN + double.parse((weightConversion(element.weight, element.key)-weight).toStringAsFixed(1)));
              nightWeightList.removeAt(i);
              nightWeightDetailList.add(element);
              nightWeightList.insert(i, double.parse((avgN/n).toStringAsFixed(1)));
            });
          }else {
            setState(() {
              n = n + 1;
              avgN = (avgN + double.parse((weightConversion(element.weight, element.key)-weight).toStringAsFixed(1)));
              nightWeightList.removeAt(i);
              nightWeightDetailList.add(element);
              nightWeightList.insert(i, double.parse((avgN/n).toStringAsFixed(1)));
            });
          }
        }
      });
      i++;
    }
    setState(() {
      final barGroup1 = makeGroupData(0, morningWeightList[0], afternoonWeightList[0], eveningWeightList[0], nightWeightList[0]);
      final barGroup2 = makeGroupData(1, morningWeightList[1], afternoonWeightList[1], eveningWeightList[1], nightWeightList[1]);
      final barGroup3 = makeGroupData(2, morningWeightList[2], afternoonWeightList[2], eveningWeightList[2], nightWeightList[2]);
      final barGroup4 = makeGroupData(3, morningWeightList[3], afternoonWeightList[3], eveningWeightList[3], nightWeightList[3]);
      final barGroup5 = makeGroupData(4, morningWeightList[4], afternoonWeightList[4], eveningWeightList[4], nightWeightList[4]);
      final barGroup6 = makeGroupData(5, morningWeightList[5], afternoonWeightList[5], eveningWeightList[5], nightWeightList[5]);
      final barGroup7 = makeGroupData(6, morningWeightList[6], afternoonWeightList[6], eveningWeightList[6], nightWeightList[6]);
      final items = [barGroup1, barGroup2, barGroup3, barGroup4, barGroup5, barGroup6, barGroup7];
      rawBarGroups = items;
      showingBarGroups = rawBarGroups;

      [morningWeightList[0], afternoonWeightList[0], eveningWeightList[0], nightWeightList[0]].forEach((element) {if(element != 0.0) day1++;});
      [morningWeightList[1], afternoonWeightList[1], eveningWeightList[1], nightWeightList[1]].forEach((element) {if(element != 0.0) day2++;});
      [morningWeightList[2], afternoonWeightList[2], eveningWeightList[2], nightWeightList[2]].forEach((element) {if(element != 0.0) day3++;});
      [morningWeightList[3], afternoonWeightList[3], eveningWeightList[3], nightWeightList[3]].forEach((element) {if(element != 0.0) day4++;});
      [morningWeightList[4], afternoonWeightList[4], eveningWeightList[4], nightWeightList[4]].forEach((element) {if(element != 0.0) day5++;});
      [morningWeightList[5], afternoonWeightList[5], eveningWeightList[5], nightWeightList[5]].forEach((element) {if(element != 0.0) day6++;});
      [morningWeightList[6], afternoonWeightList[6], eveningWeightList[6], nightWeightList[6]].forEach((element) {if(element != 0.0) day7++;});

      weightDiffOfTimeList = [
        [morningWeightList[0], afternoonWeightList[0], eveningWeightList[0], nightWeightList[0]],
        [morningWeightList[1], afternoonWeightList[1], eveningWeightList[1], nightWeightList[1]],
        [morningWeightList[2], afternoonWeightList[2], eveningWeightList[2], nightWeightList[2]],
        [morningWeightList[3], afternoonWeightList[3], eveningWeightList[3], nightWeightList[3]],
        [morningWeightList[4], afternoonWeightList[4], eveningWeightList[4], nightWeightList[4]],
        [morningWeightList[5], afternoonWeightList[5], eveningWeightList[5], nightWeightList[5]],
        [morningWeightList[6], afternoonWeightList[6], eveningWeightList[6], nightWeightList[6]],
      ];
      weightDiffList = [
        ([morningWeightList[0], afternoonWeightList[0], eveningWeightList[0], nightWeightList[0]].reduce((value, element) => value+element)/day1).isNaN == true ? 0.0 : ([morningWeightList[0], afternoonWeightList[0], eveningWeightList[0], nightWeightList[0]].reduce((value, element) => value+element)/day1),
        ([morningWeightList[1], afternoonWeightList[1], eveningWeightList[1], nightWeightList[1]].reduce((value, element) => value+element)/day2).isNaN == true  ? 0.0 : ([morningWeightList[1], afternoonWeightList[1], eveningWeightList[1], nightWeightList[1]].reduce((value, element) => value+element)/day2),
        ([morningWeightList[2], afternoonWeightList[2], eveningWeightList[2], nightWeightList[2]].reduce((value, element) => value+element)/day3).isNaN == true  ? 0.0 : ([morningWeightList[2], afternoonWeightList[2], eveningWeightList[2], nightWeightList[2]].reduce((value, element) => value+element)/day3),
        ([morningWeightList[3], afternoonWeightList[3], eveningWeightList[3], nightWeightList[3]].reduce((value, element) => value+element)/day4).isNaN == true  ? 0.0 : ([morningWeightList[3], afternoonWeightList[3], eveningWeightList[3], nightWeightList[3]].reduce((value, element) => value+element)/day4),
        ([morningWeightList[4], afternoonWeightList[4], eveningWeightList[4], nightWeightList[4]].reduce((value, element) => value+element)/day5).isNaN == true  ? 0.0 : ([morningWeightList[4], afternoonWeightList[4], eveningWeightList[4], nightWeightList[4]].reduce((value, element) => value+element)/day5),
        ([morningWeightList[5], afternoonWeightList[5], eveningWeightList[5], nightWeightList[5]].reduce((value, element) => value+element)/day6).isNaN == true  ? 0.0 : ([morningWeightList[5], afternoonWeightList[5], eveningWeightList[5], nightWeightList[5]].reduce((value, element) => value+element)/day6),
        ([morningWeightList[6], afternoonWeightList[6], eveningWeightList[6], nightWeightList[6]].reduce((value, element) => value+element)/day7).isNaN == true  ? 0.0 : ([morningWeightList[6], afternoonWeightList[6], eveningWeightList[6], nightWeightList[6]].reduce((value, element) => value+element)/day7),
      ];
    });
  }
}


