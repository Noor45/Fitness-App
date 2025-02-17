import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:t_fit/cards/dashboard_cards.dart';
import 'package:t_fit/controllers/auth_controller.dart';
import 'package:t_fit/functions/calculator_functions.dart';
import 'package:t_fit/functions/weight_progress_function.dart';
import 'package:t_fit/models/user_model/user_weight_model.dart';
import 'package:t_fit/services/theme_model.dart';
import 'package:t_fit/utils/colors.dart';
import 'package:t_fit/utils/constants.dart';
import 'package:t_fit/utils/style.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DailyWeight extends StatefulWidget {
  @override
  _DailyWeightState createState() => _DailyWeightState();
}

class _DailyWeightState extends State<DailyWeight> {
  double weight = 0.0;
  UserWeightModel currentWeight;
  List<UserWeightModel> todayWeightList = [];
  DateTime startDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
  DateTime endDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 23, 59);
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
    todayWeightList = Constants.userWeightList.where((element) => element.date.toDate().isAfter(startDate) && element.date.toDate().isBefore(endDate)).toList();
    currentWeight = todayWeightList.isNotEmpty ? todayWeightList.first : UserWeightModel();
    todayWeightList.sort((a, b) => a.date.compareTo(b.date));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final theme = Provider.of<DarkThemeProvider>(context);
    return Container(
      child: Column(
        children: [
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.only(top: 20),
            height: width / 2,
            width: width,
            child: Stack(
              children: [
                Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(weight.round().toString().split('.0')[0], style: StyleRefer.kTextStyle.copyWith(fontWeight: FontWeight.w900, color: Colors.orange, fontSize: 30)),
                            Padding(
                              padding: EdgeInsets.only(top: 2),
                              child: Text(AuthController.currentUser.weight['key'], style: StyleRefer.kTextStyle.copyWith(fontWeight: FontWeight.w900, color: Colors.orange, fontSize: 12)),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: Constants.dailyWeight.weight == null ? false : true,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${WeightProgress.weightProgressFunction(AuthController.currentUser.selectedGoal, weightConversion(Constants.dailyWeight.weight, Constants.dailyWeight.key), weight)[2]} ${WeightProgress.weightProgressFunction(AuthController.currentUser.selectedGoal, weightConversion(Constants.dailyWeight.weight, Constants.dailyWeight.key), weight)[0].toString().split('.0')[0] }',
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: WeightProgress.weightProgressFunction(AuthController.currentUser.selectedGoal, weightConversion(Constants.dailyWeight.weight, Constants.dailyWeight.key), weight)[1])),
                              Text(' ${AuthController.currentUser.weight['key']}', style: StyleRefer.kTextStyle.copyWith(fontWeight: FontWeight.w900, color:  WeightProgress.weightProgressFunction(AuthController.currentUser.selectedGoal, weightConversion(Constants.dailyWeight.weight, Constants.dailyWeight.key), weight)[1], fontSize: 8)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                PieChart(
                  PieChartData(
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 0,
                      centerSpaceRadius: 70,
                      sections: pieChart(getWeight: Constants.dailyWeight.weight == null ? false : true, context: context)
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          Divider(color: theme.lightTheme == true ? Colors.transparent : ColorRefer.kDividerColor, thickness: 7),
          WeightHistoryCardExpandable(
            widget: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: todayWeightList.length,
              itemBuilder: (BuildContext context, int index) {
                return  Container(
                  margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                  child: WeightHistoryCardWithInfo(
                    diff: '${todayWeightList[index].weight == null ? '0':
                    '${WeightProgress.weightProgressFunction(AuthController.currentUser.selectedGoal, weightConversion(todayWeightList[index].weight, todayWeightList[index].key), weight)[2]} ''${WeightProgress.weightProgressFunction(AuthController.currentUser.selectedGoal, weightConversion(todayWeightList[index].weight, todayWeightList[index].key), weight)[0].toString().split('.0')[0] }'} ${AuthController.currentUser.weight['key']}',
                    day: DateFormat.jm().format(DateFormat("hh:mm:ss").parse("${todayWeightList[index].date.toDate().hour}:${todayWeightList[index].date.toDate().minute}:00")).toString(),
                    weight: weight.round().toString().split('.0')[0],
                    note: todayWeightList[index].note,
                    color: WeightProgress.weightProgressFunction(AuthController.currentUser.selectedGoal, weightConversion(todayWeightList[index].weight, todayWeightList[index].key), weight)[1],
                  ),
                );
              }
            ),
            diff: '${currentWeight.weight == null ? '0':
            '${WeightProgress.weightProgressFunction(AuthController.currentUser.selectedGoal, weightConversion(currentWeight.weight, currentWeight.key), weight)[2]} ''${WeightProgress.weightProgressFunction(AuthController.currentUser.selectedGoal, weightConversion(currentWeight.weight, currentWeight.key), weight)[0].toString().split('.0')[0] }'} ${AuthController.currentUser.weight['key']}',
            day: '${DateTime.now().day}/${DateTime.now().month} (${DateFormat('EEE').format(DateTime.now()) })',
            weight: weight.round().toString().split('.0')[0],
            dayColor: theme.lightTheme == true ? Colors.black : Colors.white,
            color: WeightProgress.weightProgressFunction(AuthController.currentUser.selectedGoal, weightConversion(currentWeight.weight, currentWeight.key), weight)[1],
          ),
        ],
      ),
    );
  }





  static List<PieChartSectionData> pieChart({bool getWeight, BuildContext context}) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return List.generate(2, (i) {
      final radius = 15.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.orange,
            value: getWeight == true ? 100 : 0,
            title: '',
            radius: radius,
          );
        case 1:
          return PieChartSectionData(
            color: theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
            value: getWeight == true ? 0 : 100,
            title: '',
            radius: radius,
          );
        default:
          throw Error();
      }
    });
  }
}
