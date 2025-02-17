import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t_fit/cards/dashboard_cards.dart';
import 'package:t_fit/controllers/user_plan_controller.dart';
import 'package:t_fit/database/local_storage_function.dart';
import 'package:t_fit/functions/graph_function.dart';
import 'package:t_fit/functions/meal_plan_functions.dart';
import 'package:t_fit/models/meal_model/meal_plan_model.dart';
import 'package:t_fit/models/user_model/user_plan_model.dart';
import 'package:t_fit/models/user_plan_data_model/user_meal_data_model.dart';
import 'package:t_fit/models/user_plan_data_model/user_plan_data_model.dart';
import 'package:t_fit/utils/constants.dart';
import 'package:t_fit/utils/fonts.dart';
import 'package:t_fit/widgets/input_field.dart';
import '../../../utils/colors.dart';
import '../../../utils/style.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class MealHistory extends StatefulWidget {
  MealHistory({this.planDetail});
  final PlanModel planDetail;
  @override
  _MealHistoryState createState() => _MealHistoryState();
}

class _MealHistoryState extends State<MealHistory> {
  final dbHelper = DatabaseHelper.instance;
  int touchedIndex = -1;
  int day;
  bool showPieGraph = false;
  bool loading = false;
  String week = '';
  String month = '';
  List takenCaloriesList = [];
  List caloriesTakenByUserList = [];
  int mealDistribution = 0;
  bool showWeeklyData = true;
  List graphList = [];
  List userMealData = [];
  List mealData = [];
  int totalMonth = 0;
  int selectedWeek = 0;
  int totalUserWorkoutData = 0;
  int totalWorkoutData = 0;
  int totalMealData = 0;
  int totalUserMealData = 0;
  List<String> weekList = [];
  List<String> monthList = [];
  UserPlanDataModel userMealPlanData;
  List<MealPlanModel> userMealList;
  List<UserMealDataModel> userMealDetailList;
  List extraCaloriesTakenByUserList = [];


  dataList(){
    for(int i = 1; i <= widget.planDetail.duration; i++){
      weekList.add('$i');
    }
    totalMonth = (userMealList.length/30).round();
    totalMonth = totalMonth == 0 ? 1 : totalMonth;
    for(int i = 1; i <= totalMonth; i++){
      monthList.add('$i');
    }
    if(weekList.isNotEmpty) week = '${weekList[0]}';
    if(monthList.isNotEmpty) month = '${monthList[0]}';
  }
  weekData() {
    userMealList.forEach((element) {
      if(element.week == 1){
        totalMealData = totalMealData + element.totalDayCalories;
        takenCaloriesList.add(element.totalDayCalories);
      }
    });

    userMealList.forEach((element) {
      if(element.week == 1){
        if(element.meals.length == 1){
          userMealData[element.day-1] = {
            'meal_one': calculateCalories(carbs: element.meals[0]['calories_intake']['carbs'], proteins: element.meals[0]['calories_intake']['protien'], fats: element.meals[0]['calories_intake']['fats'])
          };
        }
        if(element.meals.length == 2){
          userMealData[element.day-1] = {
            'meal_one': calculateCalories(carbs: element.meals[0]['calories_intake']['carbs'], proteins: element.meals[0]['calories_intake']['protien'], fats: element.meals[0]['calories_intake']['fats']),
            'meal_two': calculateCalories(carbs: element.meals[1]['calories_intake']['carbs'], proteins: element.meals[1]['calories_intake']['protien'], fats: element.meals[0]['calories_intake']['fats'])
          };
        }
        if(element.meals.length == 3){
          userMealData[element.day-1] = {
            'meal_one': calculateCalories(carbs: element.meals[0]['calories_intake']['carbs'], proteins: element.meals[0]['calories_intake']['protien'], fats: element.meals[0]['calories_intake']['fats']),
            'meal_two': calculateCalories(carbs: element.meals[1]['calories_intake']['carbs'], proteins: element.meals[1]['calories_intake']['protien'], fats: element.meals[1]['calories_intake']['fats']),
            'meal_three': calculateCalories(carbs: element.meals[2]['calories_intake']['carbs'], proteins: element.meals[2]['calories_intake']['protien'], fats: element.meals[2]['calories_intake']['fats'])
          };
        }
        if(element.meals.length == 4){
          userMealData[element.day-1] = {
            'meal_one': calculateCalories(carbs: element.meals[0]['calories_intake']['carbs'], proteins: element.meals[0]['calories_intake']['protien'], fats: element.meals[0]['calories_intake']['fats']),
            'meal_two':  calculateCalories(carbs: element.meals[1]['calories_intake']['carbs'], proteins: element.meals[1]['calories_intake']['protien'], fats: element.meals[1]['calories_intake']['fats']),
            'meal_three': calculateCalories(carbs: element.meals[2]['calories_intake']['carbs'], proteins: element.meals[2]['calories_intake']['protien'], fats: element.meals[2]['calories_intake']['fats']),
            'meal_four': calculateCalories(carbs: element.meals[3]['calories_intake']['carbs'], proteins: element.meals[3]['calories_intake']['protien'], fats: element.meals[3]['calories_intake']['fats']),
          };
        }
        if(element.meals.length == 5){
          userMealData[element.day-1] = {
            'meal_one': calculateCalories(carbs: element.meals[0]['calories_intake']['carbs'], proteins: element.meals[0]['calories_intake']['protien'], fats: element.meals[0]['calories_intake']['fats']),
            'meal_two':  calculateCalories(carbs: element.meals[1]['calories_intake']['carbs'], proteins: element.meals[1]['calories_intake']['protien'], fats: element.meals[1]['calories_intake']['fats']),
            'meal_three': calculateCalories(carbs: element.meals[2]['calories_intake']['carbs'], proteins: element.meals[2]['calories_intake']['protien'], fats: element.meals[2]['calories_intake']['fats']),
            'meal_four': calculateCalories(carbs: element.meals[3]['calories_intake']['carbs'], proteins: element.meals[3]['calories_intake']['protien'], fats: element.meals[3]['calories_intake']['fats']),
            'meal_five': calculateCalories(carbs: element.meals[4]['calories_intake']['carbs'], proteins: element.meals[4]['calories_intake']['protien'], fats: element.meals[4]['calories_intake']['fats'])
          };
        }
        if(element.meals.length == 6){
          userMealData[element.day-1] = {
            'meal_one': calculateCalories(carbs: element.meals[0]['calories_intake']['carbs'], proteins: element.meals[0]['calories_intake']['protien'], fats: element.meals[0]['calories_intake']['fats']),
            'meal_two': calculateCalories(carbs: element.meals[1]['calories_intake']['carbs'], proteins: element.meals[1]['calories_intake']['protien'], fats: element.meals[1]['calories_intake']['fats']),
            'meal_three': calculateCalories(carbs: element.meals[2]['calories_intake']['carbs'], proteins: element.meals[2]['calories_intake']['protien'], fats: element.meals[2]['calories_intake']['fats']),
            'meal_four': calculateCalories(carbs: element.meals[3]['calories_intake']['carbs'], proteins: element.meals[3]['calories_intake']['protien'], fats: element.meals[3]['calories_intake']['fats']),
            'meal_five': calculateCalories(carbs: element.meals[4]['calories_intake']['carbs'], proteins: element.meals[4]['calories_intake']['protien'], fats: element.meals[4]['calories_intake']['fats']),
            'meal_six': calculateCalories(carbs: element.meals[5]['calories_intake']['carbs'], proteins: element.meals[5]['calories_intake']['protien'], fats: element.meals[5]['calories_intake']['fats'])
          };
        }
      }
    });

    userMealDetailList.forEach((element) {
      if(element.week == 1){
        totalUserMealData = totalUserMealData + element.caloriesTaken;
        caloriesTakenByUserList.add(element.caloriesTaken);
        extraCaloriesTakenByUserList.add(element.extraCalories);
      }
    });

    userMealDetailList.forEach((element) {
      if(element.week == 1){
        if(element.mealData.length == 1){
          userMealData[element.day-1] = {'meal_one': {element.mealData[0]['mark'], element.mealData[0]['portion'] is int ? element.mealData[0]['portion'] : calculateCalories(carbs: element.mealData[0]['portion']['carbs'], proteins: element.mealData[0]['portion']['protein'], fats: element.mealData[0]['portion']['fats'], alcohol: element.mealData[0]['portion']['alcohol'])}};
        }
        if(element.mealData.length == 2){
          userMealData[element.day-1] = {
            'meal_one': {element.mealData[0]['mark'], element.mealData[0]['portion'] is int ? element.mealData[0]['portion'] : calculateCalories(carbs: element.mealData[0]['portion']['carbs'], proteins: element.mealData[0]['portion']['protein'], fats: element.mealData[0]['portion']['fats'], alcohol: element.mealData[0]['portion']['alcohol'])},
            'meal_two': {element.mealData[1]['mark'], element.mealData[1]['portion'] is int ? element.mealData[1]['portion'] : calculateCalories(carbs: element.mealData[1]['portion']['carbs'], proteins: element.mealData[1]['portion']['protein'], fats: element.mealData[1]['portion']['fats'], alcohol: element.mealData[1]['portion']['alcohol'])}
          };
        }
        if(element.mealData.length == 3){
          userMealData[element.day-1] = {
            'meal_one': {element.mealData[0]['mark'], element.mealData[0]['portion'] is int ? element.mealData[0]['portion'] : calculateCalories(carbs: element.mealData[0]['portion']['carbs'], proteins: element.mealData[0]['portion']['protein'], fats: element.mealData[0]['portion']['fats'], alcohol: element.mealData[0]['portion']['alcohol'])},
            'meal_two': {element.mealData[1]['mark'], element.mealData[1]['portion'] is int ? element.mealData[1]['portion'] : calculateCalories(carbs: element.mealData[1]['portion']['carbs'], proteins: element.mealData[1]['portion']['protein'], fats: element.mealData[1]['portion']['fats'], alcohol: element.mealData[1]['portion']['alcohol'])},
            'meal_three': {element.mealData[2]['mark'], element.mealData[2]['portion'] is int ? element.mealData[2]['portion'] : calculateCalories(carbs: element.mealData[2]['portion']['carbs'], proteins: element.mealData[2]['portion']['protein'], fats: element.mealData[2]['portion']['fats'], alcohol: element.mealData[2]['portion']['alcohol'])}
          };
        }
        if(element.mealData.length == 4){
          userMealData[element.day-1] = {
            'meal_one': {element.mealData[0]['mark'], element.mealData[0]['portion'] is int ? element.mealData[0]['portion'] : calculateCalories(carbs: element.mealData[0]['portion']['carbs'], proteins: element.mealData[0]['portion']['protein'], fats: element.mealData[0]['portion']['fats'], alcohol: element.mealData[0]['portion']['alcohol'])},
            'meal_two': {element.mealData[1]['mark'], element.mealData[1]['portion'] is int ? element.mealData[1]['portion'] : calculateCalories(carbs: element.mealData[1]['portion']['carbs'], proteins: element.mealData[1]['portion']['protein'], fats: element.mealData[1]['portion']['fats'], alcohol: element.mealData[1]['portion']['alcohol'])},
            'meal_three': {element.mealData[2]['mark'], element.mealData[2]['portion'] is int ? element.mealData[2]['portion'] : calculateCalories(carbs: element.mealData[2]['portion']['carbs'], proteins: element.mealData[2]['portion']['protein'], fats: element.mealData[2]['portion']['fats'], alcohol: element.mealData[2]['portion']['alcohol'])},
            'meal_four': {element.mealData[3]['mark'], element.mealData[3]['portion'] is int ? element.mealData[3]['portion'] : calculateCalories(carbs: element.mealData[3]['portion']['carbs'], proteins: element.mealData[3]['portion']['protein'], fats: element.mealData[3]['portion']['fats'], alcohol: element.mealData[3]['portion']['alcohol'])},
          };
        }
        if(element.mealData.length == 5){
          userMealData[element.day-1] = {
            'meal_one': {element.mealData[0]['mark'], element.mealData[0]['portion'] is int ? element.mealData[0]['portion'] : calculateCalories(carbs: element.mealData[0]['portion']['carbs'], proteins: element.mealData[0]['portion']['protein'], fats: element.mealData[0]['portion']['fats'], alcohol: element.mealData[0]['portion']['alcohol'])},
            'meal_two': {element.mealData[1]['mark'], element.mealData[1]['portion'] is int ? element.mealData[1]['portion'] : calculateCalories(carbs: element.mealData[1]['portion']['carbs'], proteins: element.mealData[1]['portion']['protein'], fats: element.mealData[1]['portion']['fats'], alcohol: element.mealData[1]['portion']['alcohol'])},
            'meal_three': {element.mealData[2]['mark'], element.mealData[2]['portion'] is int ? element.mealData[2]['portion'] : calculateCalories(carbs: element.mealData[2]['portion']['carbs'], proteins: element.mealData[2]['portion']['protein'], fats: element.mealData[2]['portion']['fats'], alcohol: element.mealData[2]['portion']['alcohol'])},
            'meal_four': {element.mealData[3]['mark'], element.mealData[3]['portion'] is int ? element.mealData[3]['portion'] : calculateCalories(carbs: element.mealData[3]['portion']['carbs'], proteins: element.mealData[3]['portion']['protein'], fats: element.mealData[3]['portion']['fats'], alcohol: element.mealData[3]['portion']['alcohol'])},
            'meal_five': {element.mealData[4]['mark'], element.mealData[4]['portion'] is int ? element.mealData[4]['portion'] : calculateCalories(carbs: element.mealData[4]['portion']['carbs'], proteins: element.mealData[4]['portion']['protein'], fats: element.mealData[4]['portion']['fats'], alcohol: element.mealData[4]['portion']['alcohol'])}
          };
        }
        if(element.mealData.length == 6){
          userMealData[element.day-1] = {
            'meal_one': {element.mealData[0]['mark'], element.mealData[0]['portion'] is int ? element.mealData[0]['portion'] : calculateCalories(carbs: element.mealData[0]['portion']['carbs'], proteins: element.mealData[0]['portion']['protein'], fats: element.mealData[0]['portion']['fats'], alcohol: element.mealData[0]['portion']['alcohol'])},
            'meal_two': {element.mealData[1]['mark'], element.mealData[1]['portion'] is int ? element.mealData[1]['portion'] : calculateCalories(carbs: element.mealData[1]['portion']['carbs'], proteins: element.mealData[1]['portion']['protein'], fats: element.mealData[1]['portion']['fats'], alcohol: element.mealData[1]['portion']['alcohol'])},
            'meal_three': {element.mealData[2]['mark'], element.mealData[2]['portion'] is int ? element.mealData[2]['portion'] : calculateCalories(carbs: element.mealData[2]['portion']['carbs'], proteins: element.mealData[2]['portion']['protein'], fats: element.mealData[2]['portion']['fats'], alcohol: element.mealData[2]['portion']['alcohol'])},
            'meal_four': {element.mealData[3]['mark'], element.mealData[3]['portion'] is int ? element.mealData[3]['portion'] : calculateCalories(carbs: element.mealData[3]['portion']['carbs'], proteins: element.mealData[3]['portion']['protein'], fats: element.mealData[3]['portion']['fats'], alcohol: element.mealData[3]['portion']['alcohol'])},
            'meal_five': {element.mealData[4]['mark'], element.mealData[4]['portion'] is int ? element.mealData[4]['portion'] : calculateCalories(carbs: element.mealData[4]['portion']['carbs'], proteins: element.mealData[4]['portion']['protein'], fats: element.mealData[4]['portion']['fats'], alcohol: element.mealData[4]['portion']['alcohol'])},
            'meal_six': {element.mealData[5]['mark'], element.mealData[5]['portion'] is int ? element.mealData[5]['portion'] : calculateCalories(carbs: element.mealData[5]['portion']['carbs'], proteins: element.mealData[5]['portion']['protein'], fats: element.mealData[5]['portion']['fats'], alcohol: element.mealData[5]['portion']['alcohol'])}
          };
        }
      }
    });
  }

  initialize() async{
    await dbHelper.selectMealPlanByID(widget.planDetail.id).then((value) {
      userMealList = value;
    });
    await DietPlanController.getUserMealDataByPlanID(widget.planDetail.id).then((value) {
      userMealPlanData = value[0];
      userMealDetailList = value[1];
      setState(() {
        loading = true;
        if(loading == true){
          userMealList.forEach((element) {
            setState(() {
              if(element.week == userMealPlanData.currentWeek && element.day == userMealPlanData.currentDay){
                mealDistribution = element.meals.length;
              }
            });
          });
          userMealData = List.filled(7, 0);
          mealData = List.filled(7, 0);
          dataList();
          weekData();
          getDaysNameForWeeks(1);
          day = 7;
          selectedWeek = 1;
        }
      });
    });
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Container(
          child: loading == false ? Center(child: CircularProgressIndicator(color: ColorRefer.kRedColor)) :
          userMealList == null || userMealList.length == 0 ? Container(
            height: MediaQuery.of(context).size.height/1.3,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.list_bullet,
                  color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                  size: 50,
                ),
                SizedBox(height: 6),
                AutoSizeText('No plan assign yet', style: TextStyle(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontFamily: FontRefer.OpenSans,  fontSize: 16),)
              ],
            ),
          ) :
          userMealDetailList == null || userMealDetailList.length == 0 ? Container(
            height: MediaQuery.of(context).size.height/1.3,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.list_bullet,
                  color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                  size: 50,
                ),
                SizedBox(height: 6),
                AutoSizeText('Data not found', style: TextStyle(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontFamily: FontRefer.OpenSans,  fontSize: 16),)
              ],
            ),
          ) :
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 20),
                  child: Text(
                    'Your meal remarks',
                    style: StyleRefer.kTextStyle.copyWith(
                        color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SelectOption(
                        key: UniqueKey(),
                        value: month,
                        width: 80,
                        get: 'Month',
                        hint: month,
                        selectionList: monthList,
                        onChanged: (option){
                          setState(() {
                            month = option;
                            getMonthlyData('Month $option');
                          });
                        },
                      ),
                      SelectOption(
                        key: UniqueKey(),
                        value: week,
                        width: 80,
                        hint: week,
                        selectionList: weekList,
                        get: 'Week',
                        onChanged: (option){
                          setState(() {
                            week = option;
                            getWeeklyData('Week $option');
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
                  child: Text(
                    'Bar Chart',
                    style: StyleRefer.kTextStyle.copyWith(
                        color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 25),
                  child: AspectRatio(
                    aspectRatio: 1.66,
                    child: Card(
                      elevation: 0,
                      color: Colors.transparent,
                      child: showWeeklyData == true ?
                      BarChart(
                        BarChartData(
                            alignment: BarChartAlignment.spaceEvenly,
                            barTouchData: BarTouchData(enabled: false),
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: SideTitles(
                                  showTitles: true,
                                  getTextStyles: (context, value) => StyleRefer.kTextStyle.copyWith(color: Color(0xff939393), fontSize: 10, height: 1.4),
                                  margin: 10,
                                  getTitles: (double value) {
                                    switch (value.toInt()) {
                                      case 0:
                                        return '${graphList[0]}\n${takenCaloriesList[0].toString()}\n${caloriesTakenByUserList[0] > takenCaloriesList[0] ? '+'+extraCaloriesTakenByUserList[0].toString() : caloriesTakenByUserList[0] == 0 || (caloriesTakenByUserList[0]-takenCaloriesList[0]) == 0 ? '' : (caloriesTakenByUserList[0]-takenCaloriesList[0]).toString()}';
                                      case 1:
                                        return '${graphList[1]}\n${takenCaloriesList[1].toString()}\n${caloriesTakenByUserList[1] > takenCaloriesList[1] ? '+'+extraCaloriesTakenByUserList[1].toString() : caloriesTakenByUserList[1] == 0 || (caloriesTakenByUserList[1]-takenCaloriesList[1]) == 0 ? '' : (caloriesTakenByUserList[1]-takenCaloriesList[1]).toString()}';
                                      case 2:
                                        return '${graphList[2]}\n${takenCaloriesList[2].toString()}\n${caloriesTakenByUserList[2] > takenCaloriesList[2] ? '+'+extraCaloriesTakenByUserList[2].toString() : caloriesTakenByUserList[2] == 0 || (caloriesTakenByUserList[2]-takenCaloriesList[2]) == 0 ? '' : (caloriesTakenByUserList[2]-takenCaloriesList[2]).toString()}';
                                      case 3:
                                        return '${graphList[3]}\n${takenCaloriesList[3].toString()}\n${caloriesTakenByUserList[3] > takenCaloriesList[3] ? '+'+extraCaloriesTakenByUserList[3].toString() : caloriesTakenByUserList[3] == 0 || (caloriesTakenByUserList[3]-takenCaloriesList[3]) == 0 ? '' : (caloriesTakenByUserList[3]-takenCaloriesList[3]).toString()}';
                                      case 4:
                                        return '${graphList[4]}\n${takenCaloriesList[4].toString()}\n${caloriesTakenByUserList[4] > takenCaloriesList[4] ? '+'+extraCaloriesTakenByUserList[4].toString() : caloriesTakenByUserList[4] == 0 || (caloriesTakenByUserList[4]-takenCaloriesList[4]) == 0 ? '' : (caloriesTakenByUserList[4]-takenCaloriesList[4]).toString()}';
                                      case 5:
                                        return '${graphList[5]}\n${takenCaloriesList[5].toString()}\n${caloriesTakenByUserList[5] > takenCaloriesList[5] ? '+'+extraCaloriesTakenByUserList[5].toString() : caloriesTakenByUserList[5] == 0 || (caloriesTakenByUserList[5]-takenCaloriesList[5]) == 0 ? '' : (caloriesTakenByUserList[5]-takenCaloriesList[5]).toString()}';
                                      case 6:
                                        return '${graphList[6]}\n${takenCaloriesList[6].toString()}\n${caloriesTakenByUserList[6] > takenCaloriesList[6] ? '+'+extraCaloriesTakenByUserList[6].toString() : caloriesTakenByUserList[6] == 0 || (caloriesTakenByUserList[6]-takenCaloriesList[6]) == 0? '' : (caloriesTakenByUserList[6]-takenCaloriesList[6]).toString()}';
                                      default:
                                        return '';
                                    }
                                  }
                              ),
                              topTitles:  SideTitles(
                                  showTitles: true,
                                  getTextStyles: (context, value) => StyleRefer.kTextStyle.copyWith(color: Color(0xff939393), fontSize: 10, height: 1.4),
                                  margin: 10,
                                  getTitles: (double value) {
                                    switch (value.toInt()) {
                                      case 0:
                                        return day >= 1 ? caloriesTakenByUserList[0] == 0 ? null : caloriesTakenByUserList[0].toString() : null;
                                      case 1:
                                        return day >= 2 ? caloriesTakenByUserList[1] == 0 ? null : caloriesTakenByUserList[1].toString() : null;
                                      case 2:
                                        return day >= 3 ? caloriesTakenByUserList[2] == 0 ? null : caloriesTakenByUserList[2].toString() : null;
                                      case 3:
                                        return day >= 4 ? caloriesTakenByUserList[3] == 0 ? null : caloriesTakenByUserList[3].toString() : null;
                                      case 4:
                                        return day >= 5 ? caloriesTakenByUserList[4] == 0 ? null : caloriesTakenByUserList[4].toString() : null;
                                      case 5:
                                        return day >= 6 ? caloriesTakenByUserList[5] == 0 ? null : caloriesTakenByUserList[5].toString() : null;
                                      case 6:
                                        return day == 7 ? caloriesTakenByUserList[6] == 0 ? null : caloriesTakenByUserList[6].toString() : null;
                                      default:
                                        return '';
                                    }
                                  }
                              ),
                              leftTitles: SideTitles(showTitles: false),
                              rightTitles: SideTitles(showTitles: false),
                            ),
                            gridData: FlGridData(
                              show: false,
                            ),
                            borderData: FlBorderData(show: false),
                            groupsSpace: 3,
                            barGroups: Graph.showSixTimesMealData(userMealData, caloriesTakenByUserList, context)
                        ),
                      ) :
                      BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceEvenly,
                          barTouchData: BarTouchData(enabled: false),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: SideTitles(
                              showTitles: true,
                              getTextStyles: (context, value) => StyleRefer.kTextStyle.copyWith(color: Color(0xff939393), fontSize: 10),
                              margin: 10,
                              getTitles: (double value) {
                                switch (value.toInt()) {
                                  case 0:
                                    return 'W ${graphList[0]}\n${takenCaloriesList[0]}';
                                  case 1:
                                    return 'W ${graphList[1]}\n${takenCaloriesList[1]}';
                                  case 2:
                                    return 'W ${graphList[2]}\n${takenCaloriesList[2]}';
                                  case 3:
                                    return 'W ${graphList[3]}\n${takenCaloriesList[3]}';
                                  default:
                                    return '';
                                }
                              },
                            ),
                            topTitles:  SideTitles(
                              showTitles: true,
                              getTextStyles: (context, value) => StyleRefer.kTextStyle.copyWith(color: Color(0xff939393), fontSize: 10),
                              margin: 10,
                              getTitles: (double value) {
                                switch (value.toInt()) {
                                  case 0:
                                    return caloriesTakenByUserList[0] != 0 ? caloriesTakenByUserList[0].toString() : null;
                                  case 1:
                                    return caloriesTakenByUserList[1] != 0 ? caloriesTakenByUserList[1].toString() : null;
                                  case 2:
                                    return caloriesTakenByUserList[2] != 0 ? caloriesTakenByUserList[2].toString() : null;
                                  case 3:
                                    return caloriesTakenByUserList[3] != 0 ? caloriesTakenByUserList[3].toString() : null;
                                  default:
                                    return '';
                                }
                              },
                            ) ,
                            leftTitles: SideTitles(showTitles: false),
                            rightTitles: SideTitles(showTitles: false),
                          ),
                          gridData: FlGridData(
                            show: false,
                          ),
                          borderData: FlBorderData(show: false),
                          groupsSpace: 3,
                          barGroups:  Graph.showMonthlyMealData(takenCaloriesList ,caloriesTakenByUserList),
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(color: ColorRefer.kDividerColor),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
                  child: Text(
                    'Pie Chart',
                    style: StyleRefer.kTextStyle.copyWith(
                        color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        height: width / 2,
                        width: width,
                        child: Stack(
                          children: [
                            Center(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 40),
                                child: Text(
                                    '${(totalMealData - totalUserMealData).abs()} cal',
                                    style:
                                    StyleRefer.kTextStyle.copyWith(fontWeight: FontWeight.w900)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Center(
                                  child: Text('Remaining calories', style: TextStyle(fontSize: 9))),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 45),
                              child: Center(child: Text('to taken', style: TextStyle(fontSize: 9))),
                            ),
                            PieChart(
                              PieChartData(
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 70,
                                  sections: Graph.mealPieChart(
                                      totalUserMealData, totalMealData, context)
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          height: 100.0,
                          padding: EdgeInsets.only(left: 20, right: 15),
                          child: showWeeklyData == true ?
                          ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 7,
                              itemBuilder: (BuildContext context, int index) {
                                String title1 = index == 0 ? graphList[0] : index == 1 ? graphList[1] :
                                index == 2 ? graphList[2] : index == 3 ? graphList[3] : index == 4 ? graphList[4] : index == 5 ? graphList[5] : graphList[6];
                                print(caloriesTakenByUserList[4] > takenCaloriesList[4]);
                                print(caloriesTakenByUserList[4]);
                                print(takenCaloriesList[4]);
                                print(extraCaloriesTakenByUserList[4].toString());
                                return DaysCard(
                                  space: 15,
                                  title1: title1,
                                  showSubtitle: true,
                                  title2: takenCaloriesList[index].toString(),
                                  check: index <= userMealData.length-1 ? userMealData[index]['meal_one'].first : false,
                                  positiveValue: caloriesTakenByUserList[index] > takenCaloriesList[index] ? true : false,
                                  subtitle: caloriesTakenByUserList[index] > takenCaloriesList[index] ? extraCaloriesTakenByUserList[index].toString() : caloriesTakenByUserList[index] == 0 ? 0.toString() : (caloriesTakenByUserList[index]-takenCaloriesList[index]).toString(),
                                  color: selectedWeek == Constants.userMealPlanData.currentWeek ? DateFormat('EEE').format(DateTime.now()) == title1 ? Colors.orange
                                      : theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor :
                                  theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                                );
                              }
                          ) : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 4,
                              itemBuilder: (BuildContext context, int index) {
                                return DaysCard(
                                  space: 25,
                                  showSubtitle: true,
                                  title2: takenCaloriesList[index].toString(),
                                  title1: index == 0 ? 'W ${graphList[0]}' : index == 1 ? 'W ${graphList[1]}' :
                                  index == 2 ? 'W ${graphList[2]}' : 'W ${graphList[3]}' ,
                                  positiveValue: extraCaloriesTakenByUserList[index] > takenCaloriesList[index] ? true : false,
                                  subtitle: extraCaloriesTakenByUserList[index] > takenCaloriesList[index] ? extraCaloriesTakenByUserList[index].toString() : caloriesTakenByUserList[index] == 0 ? 0.toString() : (caloriesTakenByUserList[index]-takenCaloriesList[index]).toString(),
                                  check: takenCaloriesList[index] != 0 ? takenCaloriesList[index] == caloriesTakenByUserList[index] ?  true: false : false,
                                  color: graphList[index] == userMealPlanData.currentWeek ? Colors.orange
                                      : theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                                );
                              }
                          )
                      ),
                    ],
                  ),
                ),
                Divider(color: ColorRefer.kDividerColor),
                WeeklyChart(
                  text1: 'Calories Taken',
                  text2: showWeeklyData == false ? 'Monthly Goal' : 'Weekly Goal',
                  calories: totalUserMealData,
                  goal: totalMealData,
                ),
                Divider(color: theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kDividerColor, thickness: 8),
              ],
            ),
          ),
        )
    );
  }

  getDaysNameForWeeks(int week){
    setState(() {
      graphList.clear();
      int i = 0;
      var formatter = new DateFormat('EEE');
      for( i = (week*7)-7; i<(week*7); i++){
        graphList.add(formatter.format(widget.planDetail.startDate.toDate().add(Duration(days: i))));
      }
    });
  }

  getWeeksNameForMonths(int month){
    graphList.clear();
    graphList = [1, 2, 3, 4];
    List weekDiff = [];
    for(int i = 0; i < totalMonth; i++){
      weekDiff.add(i*4);
    }
    return [graphList[0]+weekDiff[month-1], graphList[1]+weekDiff[month-1], graphList[2]+weekDiff[month-1], graphList[3]+weekDiff[month-1]];
  }

  getWeeklyData(String week){
    setState(() {
      showWeeklyData = true;
      String string = week;
      List data = string.split('Week ');
      int weekNo = int.parse(data[1]);
      selectedWeek = weekNo;
      getDaysNameForWeeks(weekNo);
      clear();
      userMealList.forEach((element) {
        if(element.week == weekNo){
          takenCaloriesList.add(element.totalDayCalories);
          totalMealData = totalMealData + element.totalDayCalories;
        }
      });
      userMealList.forEach((element) {
        if(element.week == 1){
          if(element.meals.length == 1){
            mealData[element.day-1] = {
              'meal_one': calculateCalories(carbs: element.meals[0]['calories_intake']['carbs'], proteins: element.meals[0]['calories_intake']['protien'], fats: element.meals[0]['calories_intake']['fats'])
            };
          }
          if(element.meals.length == 2){
            mealData[element.day-1] = {
              'meal_one': calculateCalories(carbs: element.meals[0]['calories_intake']['carbs'], proteins: element.meals[0]['calories_intake']['protien'], fats: element.meals[0]['calories_intake']['fats']),
              'meal_two': calculateCalories(carbs: element.meals[1]['calories_intake']['carbs'], proteins: element.meals[1]['calories_intake']['protien'], fats: element.meals[0]['calories_intake']['fats'])
            };
          }
          if(element.meals.length == 3){
            mealData[element.day-1] = {
              'meal_one': calculateCalories(carbs: element.meals[0]['calories_intake']['carbs'], proteins: element.meals[0]['calories_intake']['protien'], fats: element.meals[0]['calories_intake']['fats']),
              'meal_two': calculateCalories(carbs: element.meals[1]['calories_intake']['carbs'], proteins: element.meals[1]['calories_intake']['protien'], fats: element.meals[1]['calories_intake']['fats']),
              'meal_three': calculateCalories(carbs: element.meals[2]['calories_intake']['carbs'], proteins: element.meals[2]['calories_intake']['protien'], fats: element.meals[2]['calories_intake']['fats'])
            };
          }
          if(element.meals.length == 4){
            mealData[element.day-1] = {
              'meal_one': calculateCalories(carbs: element.meals[0]['calories_intake']['carbs'], proteins: element.meals[0]['calories_intake']['protien'], fats: element.meals[0]['calories_intake']['fats']),
              'meal_two':  calculateCalories(carbs: element.meals[1]['calories_intake']['carbs'], proteins: element.meals[1]['calories_intake']['protien'], fats: element.meals[1]['calories_intake']['fats']),
              'meal_three': calculateCalories(carbs: element.meals[2]['calories_intake']['carbs'], proteins: element.meals[2]['calories_intake']['protien'], fats: element.meals[2]['calories_intake']['fats']),
              'meal_four': calculateCalories(carbs: element.meals[3]['calories_intake']['carbs'], proteins: element.meals[3]['calories_intake']['protien'], fats: element.meals[3]['calories_intake']['fats']),
            };
          }
          if(element.meals.length == 5){
            mealData[element.day-1] = {
              'meal_one': calculateCalories(carbs: element.meals[0]['calories_intake']['carbs'], proteins: element.meals[0]['calories_intake']['protien'], fats: element.meals[0]['calories_intake']['fats']),
              'meal_two':  calculateCalories(carbs: element.meals[1]['calories_intake']['carbs'], proteins: element.meals[1]['calories_intake']['protien'], fats: element.meals[1]['calories_intake']['fats']),
              'meal_three': calculateCalories(carbs: element.meals[2]['calories_intake']['carbs'], proteins: element.meals[2]['calories_intake']['protien'], fats: element.meals[2]['calories_intake']['fats']),
              'meal_four': calculateCalories(carbs: element.meals[3]['calories_intake']['carbs'], proteins: element.meals[3]['calories_intake']['protien'], fats: element.meals[3]['calories_intake']['fats']),
              'meal_five': calculateCalories(carbs: element.meals[4]['calories_intake']['carbs'], proteins: element.meals[4]['calories_intake']['protien'], fats: element.meals[4]['calories_intake']['fats'])
            };
          }
          if(element.meals.length == 6){
            mealData[element.day-1] = {
              'meal_one': calculateCalories(carbs: element.meals[0]['calories_intake']['carbs'], proteins: element.meals[0]['calories_intake']['protien'], fats: element.meals[0]['calories_intake']['fats']),
              'meal_two': calculateCalories(carbs: element.meals[1]['calories_intake']['carbs'], proteins: element.meals[1]['calories_intake']['protien'], fats: element.meals[1]['calories_intake']['fats']),
              'meal_three': calculateCalories(carbs: element.meals[2]['calories_intake']['carbs'], proteins: element.meals[2]['calories_intake']['protien'], fats: element.meals[2]['calories_intake']['fats']),
              'meal_four': calculateCalories(carbs: element.meals[3]['calories_intake']['carbs'], proteins: element.meals[3]['calories_intake']['protien'], fats: element.meals[3]['calories_intake']['fats']),
              'meal_five': calculateCalories(carbs: element.meals[4]['calories_intake']['carbs'], proteins: element.meals[4]['calories_intake']['protien'], fats: element.meals[4]['calories_intake']['fats']),
              'meal_six': calculateCalories(carbs: element.meals[5]['calories_intake']['carbs'], proteins: element.meals[5]['calories_intake']['protien'], fats: element.meals[5]['calories_intake']['fats'])
            };
          }
        }
      });
      userMealDetailList.forEach((element) {
        if(element.week == weekNo){
          totalUserMealData = totalUserMealData + element.caloriesTaken;
          caloriesTakenByUserList.add(element.caloriesTaken);
          extraCaloriesTakenByUserList.add(element.extraCalories);
        }
      });
      userMealDetailList.forEach((element) {
        if(element.week == weekNo){
          if(element.mealData.length == 1){
            userMealData[element.day-1] = {'meal_one': {element.mealData[0]['mark'], element.mealData[0]['portion'] is int ? element.mealData[0]['portion'] : calculateCalories(carbs: element.mealData[0]['portion']['carbs'], proteins: element.mealData[0]['portion']['protein'], fats: element.mealData[0]['portion']['fats'], alcohol: element.mealData[0]['portion']['alcohol'])}};
          }
          if(element.mealData.length == 2){
            userMealData[element.day-1] = {
              'meal_one': {element.mealData[0]['mark'], element.mealData[0]['portion'] is int ? element.mealData[0]['portion'] : calculateCalories(carbs: element.mealData[0]['portion']['carbs'], proteins: element.mealData[0]['portion']['protein'], fats: element.mealData[0]['portion']['fats'], alcohol: element.mealData[0]['portion']['alcohol'])},
              'meal_two': {element.mealData[1]['mark'], element.mealData[1]['portion'] is int ? element.mealData[1]['portion'] : calculateCalories(carbs: element.mealData[1]['portion']['carbs'], proteins: element.mealData[1]['portion']['protein'], fats: element.mealData[1]['portion']['fats'], alcohol: element.mealData[1]['portion']['alcohol'])}
            };
          }
          if(element.mealData.length == 3){
            userMealData[element.day-1] = {
              'meal_one': {element.mealData[0]['mark'], element.mealData[0]['portion'] is int ? element.mealData[0]['portion'] : calculateCalories(carbs: element.mealData[0]['portion']['carbs'], proteins: element.mealData[0]['portion']['protein'], fats: element.mealData[0]['portion']['fats'], alcohol: element.mealData[0]['portion']['alcohol'])},
              'meal_two': {element.mealData[1]['mark'], element.mealData[1]['portion'] is int ? element.mealData[1]['portion'] : calculateCalories(carbs: element.mealData[1]['portion']['carbs'], proteins: element.mealData[1]['portion']['protein'], fats: element.mealData[1]['portion']['fats'], alcohol: element.mealData[1]['portion']['alcohol'])},
              'meal_three': {element.mealData[2]['mark'], element.mealData[2]['portion'] is int ? element.mealData[2]['portion'] : calculateCalories(carbs: element.mealData[2]['portion']['carbs'], proteins: element.mealData[2]['portion']['protein'], fats: element.mealData[2]['portion']['fats'], alcohol: element.mealData[2]['portion']['alcohol'])}
            };
          }
          if(element.mealData.length == 4){
            userMealData[element.day-1] = {
              'meal_one': {element.mealData[0]['mark'], element.mealData[0]['portion'] is int ? element.mealData[0]['portion'] : calculateCalories(carbs: element.mealData[0]['portion']['carbs'], proteins: element.mealData[0]['portion']['protein'], fats: element.mealData[0]['portion']['fats'], alcohol: element.mealData[0]['portion']['alcohol'])},
              'meal_two': {element.mealData[1]['mark'], element.mealData[1]['portion'] is int ? element.mealData[1]['portion'] : calculateCalories(carbs: element.mealData[1]['portion']['carbs'], proteins: element.mealData[1]['portion']['protein'], fats: element.mealData[1]['portion']['fats'], alcohol: element.mealData[1]['portion']['alcohol'])},
              'meal_three': {element.mealData[2]['mark'], element.mealData[2]['portion'] is int ? element.mealData[2]['portion'] : calculateCalories(carbs: element.mealData[2]['portion']['carbs'], proteins: element.mealData[2]['portion']['protein'], fats: element.mealData[2]['portion']['fats'], alcohol: element.mealData[2]['portion']['alcohol'])},
              'meal_four': {element.mealData[3]['mark'], element.mealData[3]['portion'] is int ? element.mealData[3]['portion'] : calculateCalories(carbs: element.mealData[3]['portion']['carbs'], proteins: element.mealData[3]['portion']['protein'], fats: element.mealData[3]['portion']['fats'], alcohol: element.mealData[3]['portion']['alcohol'])},
            };
          }
          if(element.mealData.length == 5){
            userMealData[element.day-1] = {
              'meal_one': {element.mealData[0]['mark'], element.mealData[0]['portion'] is int ? element.mealData[0]['portion'] : calculateCalories(carbs: element.mealData[0]['portion']['carbs'], proteins: element.mealData[0]['portion']['protein'], fats: element.mealData[0]['portion']['fats'], alcohol: element.mealData[0]['portion']['alcohol'])},
              'meal_two': {element.mealData[1]['mark'], element.mealData[1]['portion'] is int ? element.mealData[1]['portion'] : calculateCalories(carbs: element.mealData[1]['portion']['carbs'], proteins: element.mealData[1]['portion']['protein'], fats: element.mealData[1]['portion']['fats'], alcohol: element.mealData[1]['portion']['alcohol'])},
              'meal_three': {element.mealData[2]['mark'], element.mealData[2]['portion'] is int ? element.mealData[2]['portion'] : calculateCalories(carbs: element.mealData[2]['portion']['carbs'], proteins: element.mealData[2]['portion']['protein'], fats: element.mealData[2]['portion']['fats'], alcohol: element.mealData[2]['portion']['alcohol'])},
              'meal_four': {element.mealData[3]['mark'], element.mealData[3]['portion'] is int ? element.mealData[3]['portion'] : calculateCalories(carbs: element.mealData[3]['portion']['carbs'], proteins: element.mealData[3]['portion']['protein'], fats: element.mealData[3]['portion']['fats'], alcohol: element.mealData[3]['portion']['alcohol'])},
              'meal_five': {element.mealData[4]['mark'], element.mealData[4]['portion'] is int ? element.mealData[4]['portion'] : calculateCalories(carbs: element.mealData[4]['portion']['carbs'], proteins: element.mealData[4]['portion']['protein'], fats: element.mealData[4]['portion']['fats'], alcohol: element.mealData[4]['portion']['alcohol'])}
            };
          }
          if(element.mealData.length == 6){
            userMealData[element.day-1] = {
              'meal_one': {element.mealData[0]['mark'], element.mealData[0]['portion'] is int ? element.mealData[0]['portion'] : calculateCalories(carbs: element.mealData[0]['portion']['carbs'], proteins: element.mealData[0]['portion']['protein'], fats: element.mealData[0]['portion']['fats'], alcohol: element.mealData[0]['portion']['alcohol'])},
              'meal_two': {element.mealData[1]['mark'], element.mealData[1]['portion'] is int ? element.mealData[1]['portion'] : calculateCalories(carbs: element.mealData[1]['portion']['carbs'], proteins: element.mealData[1]['portion']['protein'], fats: element.mealData[1]['portion']['fats'], alcohol: element.mealData[1]['portion']['alcohol'])},
              'meal_three': {element.mealData[2]['mark'], element.mealData[2]['portion'] is int ? element.mealData[2]['portion'] : calculateCalories(carbs: element.mealData[2]['portion']['carbs'], proteins: element.mealData[2]['portion']['protein'], fats: element.mealData[2]['portion']['fats'], alcohol: element.mealData[2]['portion']['alcohol'])},
              'meal_four': {element.mealData[3]['mark'], element.mealData[3]['portion'] is int ? element.mealData[3]['portion'] : calculateCalories(carbs: element.mealData[3]['portion']['carbs'], proteins: element.mealData[3]['portion']['protein'], fats: element.mealData[3]['portion']['fats'], alcohol: element.mealData[3]['portion']['alcohol'])},
              'meal_five': {element.mealData[4]['mark'], element.mealData[4]['portion'] is int ? element.mealData[4]['portion'] : calculateCalories(carbs: element.mealData[4]['portion']['carbs'], proteins: element.mealData[4]['portion']['protein'], fats: element.mealData[4]['portion']['fats'], alcohol: element.mealData[4]['portion']['alcohol'])},
              'meal_six': {element.mealData[5]['mark'], element.mealData[5]['portion'] is int ? element.mealData[5]['portion'] : calculateCalories(carbs: element.mealData[5]['portion']['carbs'], proteins: element.mealData[5]['portion']['protein'], fats: element.mealData[5]['portion']['fats'], alcohol: element.mealData[5]['portion']['alcohol'])}
            };
          }
        }
      });
    });
    setState(() {});
  }

  getMonthlyData(String month){
    showWeeklyData = false;
    setState(() {
      String string = month;
      List data = string.split('Month ');
      int monthNo = int.parse(data[1]);
      List weeks = getWeeksNameForMonths(monthNo);
      clear();
      if(userMealPlanData != null){
        weeks.forEach((weekNo) {
          if(Constants.planDetail.meal == 1){
            Future.wait(
                userMealDetailList.map((element) async{
                  if(element.week == weekNo){
                    totalUserMealData = totalUserMealData + element.caloriesTaken;
                  }
                })
            );
            Future.wait(
                userMealList.map((element) async{
                  if(element.week == weekNo){
                    totalMealData = totalMealData + element.totalDayCalories;
                  }
                })
            );
          }
        });
        takenCaloriesList = getMonthlyMealList(weeks);
        caloriesTakenByUserList = getMonthlyUserMealList(weeks);
        extraCaloriesTakenByUserList = getMonthlyUserExtraCaloriesList(weeks);
      }
    });
    setState(() {});
  }

  getMonthlyMealList(List week){
    int firstWeekData = 0;
    int secondWeekData = 0;
    int thirdWeekData = 0;
    int forthWeekData = 0;
    userMealList.forEach((element) async{
      if(element.week == week[0]){
        firstWeekData = firstWeekData + element.totalDayCalories;
      }
      if(element.week == week[1]){
        secondWeekData = secondWeekData + element.totalDayCalories;
      }
      if(element.week == week[2]){
        thirdWeekData = thirdWeekData + element.totalDayCalories;
      }
      if(element.week == week[3]){
        forthWeekData = forthWeekData + element.totalDayCalories;
      }
    });
    return [firstWeekData, secondWeekData, thirdWeekData, forthWeekData];
  }

  getMonthlyUserMealList(List week){
    int firstWeekData = 0;
    int secondWeekData = 0;
    int thirdWeekData = 0;
    int forthWeekData = 0;
    userMealDetailList.forEach((element) async{
      if(element.week == week[0]){
        firstWeekData = firstWeekData + element.caloriesTaken;
      }
      if(element.week == week[1]){
        secondWeekData = secondWeekData + element.caloriesTaken;
      }
      if(element.week == week[2]){
        thirdWeekData = thirdWeekData + element.caloriesTaken;
      }
      if(element.week == week[3]){
        forthWeekData = forthWeekData + element.caloriesTaken;
      }
    });
    return [firstWeekData, secondWeekData, thirdWeekData, forthWeekData];
  }

  getMonthlyUserExtraCaloriesList(List week){
    int firstWeekData = 0;
    int secondWeekData = 0;
    int thirdWeekData = 0;
    int forthWeekData = 0;
    Constants.userMealData.forEach((element) async{
      if(element.week == week[0]){
        firstWeekData = firstWeekData + element.extraCalories;
      }
      if(element.week == week[1]){
        secondWeekData = secondWeekData + element.extraCalories;
      }
      if(element.week == week[2]){
        thirdWeekData = thirdWeekData + element.extraCalories;
      }
      if(element.week == week[3]){
        forthWeekData = forthWeekData + element.extraCalories;
      }
    });
    return [firstWeekData, secondWeekData, thirdWeekData, forthWeekData];
  }

  clear(){
    userMealData = List.filled(7, 0);
    mealData = List.filled(7, 0);
    totalMealData = 0;
    totalUserMealData = 0;
    takenCaloriesList.clear();
    caloriesTakenByUserList.clear();
    extraCaloriesTakenByUserList.clear();
  }
}