import 'package:flutter/material.dart';
import 'package:t_fit/controllers/auth_controller.dart';
import 'package:t_fit/functions/calculator_functions.dart';
import 'package:t_fit/functions/global_functions.dart';
import 'package:t_fit/functions/weight_progress_function.dart';
import 'package:t_fit/screens/weight_screens/weight_history_screen.dart';
import '../utils/colors.dart';
import '../utils/style.dart';
import 'package:fl_chart/fl_chart.dart';
import '../cards/dashboard_cards.dart';
import '../utils/constants.dart';
import '../functions/graph_function.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class MainGraph extends StatefulWidget {
  @override
  _MainGraphState createState() => _MainGraphState();
}

class _MainGraphState extends State<MainGraph> {
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
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: Constants.planMealAssign == true  || Constants.planWorkoutAssign == true ? true : false,
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 15, bottom: 10),
                  child: Divider(color: theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kDividerColor, thickness: 8)
              ),
              Visibility(
                visible: AuthController.currentUser.bfp == null || AuthController.currentUser.bfp == 0.0? false : true,
                child: ValueCard(
                  title1: 'Body Fat',
                  title2: '${AuthController.currentUser.bfp}%',
                  color: ColorRefer.kPinkColor,
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: Constants.planDetail.meal == 1 && Constants.planDetail.workout == 1 ? true : false,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 15),
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ValueCard(
                    title1: 'Eaten',
                    title2: '${Constants.totalUserMealData}',
                    color: Colors.orange,
                  ),
                  ValueCard(
                    title1: 'Burnt',
                    title2: '${Constants.totalUserWorkoutData}',
                    color: ColorRefer.kRedColor,
                  )
                ],
              ),
            ),
          ),
        ),

        Visibility(
          visible: Constants.planDetail.meal == 1 && Constants.planDetail.workout == 1 ? true : false,
          child: GestureDetector(
            onTap: () async {
              await dbHelper.selectWeightDetail();
              Navigator.pushNamed(context, WeightHistoryScreen.ID);
            },
            child: Container(
              margin: EdgeInsets.only(top: 20),
              height: width/2,
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
                        centerSpaceRadius: 65,
                        sections: Graph.mainPieChart(
                          caloriesTaken: Constants.totalUserMealData,
                          caloriesBurn: Constants.totalUserWorkoutData,
                          context: context,
                        )
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: Constants.planDetail.meal == 1 && Constants.planDetail.workout == 0 ? true : false,
          child: GestureDetector(
            onTap: () async{
              // await GeneralController.getUserWeight();
              await dbHelper.selectWeightDetail();
              Navigator.pushNamed(context, WeightHistoryScreen.ID);
            },
            child: Container(
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
                                child: Text('${AuthController.currentUser.weight['key']}', style: StyleRefer.kTextStyle.copyWith(fontWeight: FontWeight.w900, color: Colors.orange, fontSize: 12)),
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
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 70,
                        sections: Graph.mealPieChart(
                            Constants.totalUserMealData, Constants.totalMealData, context)
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: Constants.planDetail.meal == 0 && Constants.planDetail.workout == 1 ? true : false,
          child: GestureDetector(
            onTap: () async{
              await dbHelper.selectWeightDetail();
              Navigator.pushNamed(context, WeightHistoryScreen.ID);
            },
            child: Container(
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
                                child: Text('${AuthController.currentUser.weight['key']}', style: StyleRefer.kTextStyle.copyWith(fontWeight: FontWeight.w900, color: Colors.orange, fontSize: 12)),
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
                        sections: Graph.workoutPieChart(Constants.totalUserWorkoutData, Constants.totalWorkoutData, context)),
                  ),
                ],
              ),
            ),
          ),
        ),

        Visibility(
          visible: Constants.planDetail.meal == 1 && Constants.planDetail.workout == 1 ? true : false,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 15),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 3),
                          child: Center(child:Text('${Constants.totalMealData}', style: StyleRefer.kTextStyle.copyWith(fontWeight: FontWeight.w900))),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 3),
                          child: Center(child: Text('Goal: Calories Taken', style: TextStyle(fontSize: 8))),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 3),
                          child: Center(child:Text('${Constants.dayProgressValue.round()}%', style: StyleRefer.kTextStyle.copyWith(fontWeight: FontWeight.w900))),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 3),
                          child: Center(child: Text('Overall done for the day', style: TextStyle(fontSize: 8))),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: Constants.planDetail.meal == 1 && Constants.planDetail.workout == 0 ? true : false,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 15),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 3),
                          child: Center(child:Text('${Constants.totalMealData}', style: StyleRefer.kTextStyle.copyWith(fontWeight: FontWeight.w900))),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 3),
                          child: Center(child: Text('Weekly Taken', style: TextStyle(fontSize: 8))),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 3),
                          child: Center(child:Text('${Constants.dayProgressValue.round()}%', style: StyleRefer.kTextStyle.copyWith(fontWeight: FontWeight.w900))),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 3),
                          child: Center(child: Text('Overall done for the day', style: TextStyle(fontSize: 8))),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: Constants.planDetail.meal == 0 && Constants.planDetail.workout == 1 ? true : false,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 15),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 3),
                          child: Center(child:Text('${Constants.totalWorkoutData}', style: StyleRefer.kTextStyle.copyWith(fontWeight: FontWeight.w900))),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 3),
                          child: Center(child: Text('Weekly Burn', style: TextStyle(fontSize: 8))),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 3),
                          child: Center(child:Text('${Constants.dayProgressValue.round()}%', style: StyleRefer.kTextStyle.copyWith(fontWeight: FontWeight.w900))),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 3),
                          child: Center(child: Text('Overall done for the day', style: TextStyle(fontSize: 8))),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Divider(color: theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kDividerColor, thickness: 8),
      ],
    );
  }

}