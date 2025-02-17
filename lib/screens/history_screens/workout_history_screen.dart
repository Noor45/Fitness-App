import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t_fit/cards/dashboard_cards.dart';
import 'package:t_fit/controllers/user_plan_controller.dart';
import 'package:t_fit/database/local_storage_function.dart';
import 'package:t_fit/functions/graph_function.dart';
import 'package:t_fit/models/user_model/user_plan_model.dart';
import 'package:t_fit/models/user_plan_data_model/user_plan_data_model.dart';
import 'package:t_fit/models/user_plan_data_model/user_workout_data_model.dart';
import 'package:t_fit/models/workout_model/workout_model.dart';
import 'package:t_fit/utils/constants.dart';
import 'package:t_fit/utils/fonts.dart';
import 'package:t_fit/widgets/input_field.dart';
import '../../../utils/colors.dart';
import '../../../utils/style.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class WorkoutHistory extends StatefulWidget {
  WorkoutHistory({this.planDetail});
  final PlanModel planDetail;
  @override
  _WorkoutHistoryState createState() => _WorkoutHistoryState();
}

class _WorkoutHistoryState extends State<WorkoutHistory> {
  final dbHelper = DatabaseHelper.instance;
  int day = 0;
  bool showPieGraph = false;
  bool showWeeklyData = true;
  int touchedIndex = -1;
  List weeklyBurnCalories = [];
  List<dynamic> weeklyWorkoutList = [];
  List caloriesBurnByUserList = [];
  List workoutData = [];
  bool userWorkout = false;
  int userBurnCal = 0;
  bool loading = false;
  int selectedWeek = 0;
  String week = '';
  String months = '';
  int totalMonth = 0;
  List graphList = [];
  List<String> weekList = [];
  List<String> monthList = [];
  int totalUserWorkoutData = 0;
  int totalWorkoutData = 0;
  List<WorkoutPlanModel> userWorkoutsList = [];
  UserPlanDataModel userWorkoutPlanData = UserPlanDataModel();
  List<UserWorkoutPlanModel> userWorkoutData = [];


  dataList(){
    int month = (userWorkoutsList.length/30).round();
    month = month == 0 ? 1 : month;
    for(int i = 1; i <= widget.planDetail.duration; i++){
      weekList.add('$i');
    }
    totalMonth = (userWorkoutsList.length/30).round();
    totalMonth = totalMonth == 0 ? 1 : totalMonth;
    for(int i = 1; i <= totalMonth; i++){
      monthList.add('$i');
    }
    if(weekList.isNotEmpty) week = weekList[0];
    if(monthList.isNotEmpty) months = monthList[0];
  }
  weekData(){
    userWorkoutsList.forEach((element) {
      if(element.week == 1){
        weeklyBurnCalories.add(element.caloriesBurn);
        weeklyWorkoutList.add(element.workouts);
        totalWorkoutData = totalWorkoutData + element.caloriesBurn;
      }
    });
    userWorkoutData.forEach((element) {
      if(element.week == 1){
        if(element.day != 0) workoutData.add(element.workout);
        totalUserWorkoutData = totalUserWorkoutData + element.caloriesBurn;
      }
    });
  }


  initialize() async{
    await dbHelper.selectWorkoutPlanById(widget.planDetail.id).then((value) {
      userWorkoutsList = value;
    });
    await DietPlanController.getUserWorkoutDataByPlanID(widget.planDetail.id).then((value) {
      userWorkoutPlanData = value[0];
      userWorkoutData = value[1];
      setState(() {
        loading = true;
        if(loading == true){
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
        userWorkoutsList == null || userWorkoutsList.length == 0 ? Container(
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
        userWorkoutData == null || userWorkoutData.length == 0 ? Container(
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
        ) : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
                child: Text(
                  'Your workout remarks',
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
                      value: months,
                      width: 80,
                      get: 'Month',
                      hint: months,
                      selectionList: monthList,
                      onChanged: (option){
                        setState(() {
                          // week = '';
                          months = option;
                          getMonthlyData('Month $option');
                        });

                      },
                    ),
                    SelectOption(
                      key: UniqueKey(),
                      value: week,
                      width: 80,
                      get: 'Week',
                      hint: week,
                      selectionList: weekList,
                      onChanged: (option){
                        setState(() {
                          // months = '';
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
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: AspectRatio(
                  aspectRatio: 1.66,
                  child: Card(
                    elevation: 0,
                    color: Colors.transparent,
                    child: showWeeklyData == true ? BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceEvenly,
                        barTouchData: BarTouchData(enabled: false),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: SideTitles(
                            showTitles: true,
                            getTextStyles: (context, value) => TextStyle(color: Color(0xff939393), fontSize: 10),
                            margin: 10,
                            getTitles: (double value) {
                              switch (value.toInt()) {
                                case 0:
                                  return graphList[0];
                                case 1:
                                  return graphList[1];
                                case 2:
                                  return graphList[2];
                                case 3:
                                  return graphList[3];
                                case 4:
                                  return graphList[4];
                                case 5:
                                  return graphList[5];
                                case 6:
                                  return graphList[6];
                                default:
                                  return '';
                              }
                            },
                          ),
                          topTitles: SideTitles(
                            showTitles: true,
                            getTextStyles: (context, value) => TextStyle(color: Color(0xff939393), fontSize: 10),
                            margin: 10,
                            getTitles: (double value) {
                              switch (value.toInt()) {
                                case 0:
                                  return day >= 1 ? weeklyBurnCalories[0] == 0 && weeklyWorkoutList[0].isEmpty == true ? 'Rest' : weeklyBurnCalories[0].toString() : null;
                                case 1:
                                  return day >= 2 ? weeklyBurnCalories[1] == 0 && weeklyWorkoutList[1].isEmpty == true ? 'Rest' : weeklyBurnCalories[1].toString() : null;
                                case 2:
                                  return day >= 3 ? weeklyBurnCalories[2] == 0 && weeklyWorkoutList[2].isEmpty == true ? 'Rest' : weeklyBurnCalories[2].toString() : null;
                                case 3:
                                  return day >= 4 ? weeklyBurnCalories[3] == 0 && weeklyWorkoutList[3].isEmpty == true ? 'Rest' : weeklyBurnCalories[3].toString() : null;
                                case 4:
                                  return day >= 5 ? weeklyBurnCalories[4] == 0 && weeklyWorkoutList[4].isEmpty == true ? 'Rest' : weeklyBurnCalories[4].toString() : null;
                                case 5:
                                  return day >= 6 ? weeklyBurnCalories[5] == 0 && weeklyWorkoutList[5].isEmpty == true ? 'Rest' : weeklyBurnCalories[5].toString() : null;
                                case 6:
                                  return day == 7 ? weeklyBurnCalories[6] == 0 && weeklyWorkoutList[6].isEmpty == true  ? 'Rest' : weeklyBurnCalories[6].toString() : null;
                                default:
                                  return '';
                              }
                            },
                          ),
                          leftTitles: SideTitles(showTitles: false),
                          rightTitles: SideTitles(showTitles: false),
                        ),
                        gridData: FlGridData(
                          show: false,
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        groupsSpace: 3,
                        barGroups: Graph.workoutBarChart(weeklyBurnCalories, workoutData),
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
                            getTextStyles: (context, value) => TextStyle(color: Color(0xff939393), fontSize: 10),
                            margin: 10,
                            getTitles: (double value) {
                              switch (value.toInt()) {
                                case 0:
                                  return 'W ${graphList[0]}';
                                case 1:
                                  return 'W ${graphList[1]}';
                                case 2:
                                  return 'W ${graphList[2]}';
                                case 3:
                                  return 'W ${graphList[3]}';
                                default:
                                  return '';
                              }
                            },
                          ),
                          topTitles:  SideTitles(
                            showTitles: true,
                            getTextStyles: (context, value) => TextStyle(color: Color(0xff939393), fontSize: 10),
                            margin: 10,
                            getTitles: (double value) {
                              switch (value.toInt()) {
                                case 0:
                                  return weeklyBurnCalories[0].toString();
                                case 1:
                                  return weeklyBurnCalories[1].toString();
                                case 2:
                                  return weeklyBurnCalories[2].toString();
                                case 3:
                                  return weeklyBurnCalories[3].toString();
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
                        barGroups:  Graph.monthWorkoutBarChart(weeklyBurnCalories, caloriesBurnByUserList),
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
                                  '${(totalWorkoutData - totalUserWorkoutData).abs()} cal',
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
                            child: Center(child: Text('to burn', style: TextStyle(fontSize: 9))),
                          ),
                          PieChart(
                            PieChartData(
                                pieTouchData: PieTouchData(touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                  setState(() {
                                    if (!event.isInterestedForInteractions ||
                                        pieTouchResponse == null ||
                                        pieTouchResponse.touchedSection == null) {
                                      touchedIndex = -1;
                                      return;
                                    }
                                    touchedIndex = pieTouchResponse
                                        .touchedSection.touchedSectionIndex;
                                  });
                                }),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: 0,
                                centerSpaceRadius: 70,
                                sections: Graph.workoutPieChart(
                                    totalUserWorkoutData, totalWorkoutData, context)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 80.0,
                      padding: EdgeInsets.only(left: 20, right: 15),
                      child: showWeeklyData == true ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 7,
                          itemBuilder: (BuildContext context, int index) {
                            String title1 = index == 0 ? graphList[0] : index == 1 ? graphList[1] :
                            index == 2 ? graphList[2] : index == 3 ? graphList[3] : index == 4 ? graphList[4] : index == 5 ? graphList[5] : graphList[6];
                            return  DaysCard(
                              space: 15,
                              title1: title1,
                              title2: weeklyBurnCalories[index] == 0 && weeklyWorkoutList[index].isEmpty == true ? 'Rest' : weeklyBurnCalories[index].toString(),
                              check: index <= workoutData.length-1 ? workoutData[index] : false,
                              color: selectedWeek == userWorkoutPlanData.currentWeek ? DateFormat('EEE').format(DateTime.now()) == title1 ? Colors.orange :
                              theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor :
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
                              title1: index == 0 ? 'W ${graphList[0]}' : index == 1 ? 'W ${graphList[1]}' :
                              index == 2 ? 'W ${graphList[2]}' : 'W ${graphList[3]}' ,
                              title2: weeklyBurnCalories[index].toString(),
                              check: weeklyBurnCalories[index] != 0 ? weeklyBurnCalories[index] == caloriesBurnByUserList[index] ?  true: false : false,
                              color: graphList[index] == userWorkoutPlanData.currentWeek ? Colors.orange :
                              theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                              space: 25,
                            );
                          }
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: ColorRefer.kDividerColor),
              WeeklyChart(
                text1: 'Calories Burn',
                text2: showWeeklyData == false ? 'Monthly Goal' : 'Weekly Goal',
                calories: totalUserWorkoutData,
                goal: totalWorkoutData,
              ),
              Divider(color: theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kDividerColor, thickness: 8),
            ],
          ),
        ),
      ),
    );
  }

  getDaysNameForWeeks(int week){
    setState(() {
      graphList = [];
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
    showWeeklyData = true;
    String string = week;
    List data = string.split('Week ');
    int weekNo = int.parse(data[1]);
    selectedWeek = weekNo;
    getDaysNameForWeeks(weekNo);
    clear();
    userWorkoutsList.forEach((element) {
      if(element.week == weekNo){
        weeklyBurnCalories.add(element.caloriesBurn);
        weeklyWorkoutList.add(element.workouts);
        totalWorkoutData = totalWorkoutData + element.caloriesBurn;
      }
    });
    userWorkoutData.forEach((element) {
      if(element.week == weekNo){
        if(element.day != 0) workoutData.add(element.workout);
        totalUserWorkoutData = totalUserWorkoutData + element.caloriesBurn;
      }
    });
  }

  getMonthlyData(String month){
    showWeeklyData = false;
    setState(() {
      String string = month;
      List data = string.split('Month ');
      int monthNo = int.parse(data[1]);
      List weeks = getWeeksNameForMonths(monthNo);
      clear();
      if(userWorkoutPlanData != null){
        weeks.forEach((weekNo) {
          if(Constants.planDetail.workout == 1){
            Future.wait(
                userWorkoutData.map((element) async{
                  if(element.week == weekNo){
                    totalUserWorkoutData = totalUserWorkoutData + element.caloriesBurn;
                  }
                })
            );
            Future.wait(
                userWorkoutsList.map((element) async{
                  if(element.week == weekNo){
                    totalWorkoutData = totalWorkoutData + element.caloriesBurn;
                  }
                })
            );
          }
        });
        weeklyBurnCalories = getMonthlyWorkoutList(weeks);
        caloriesBurnByUserList = getMonthlyUserWorkoutList(weeks);
      }
    });
    setState(() {});
  }

  getMonthlyWorkoutList(List week){
    int firstWeekData = 0;
    int secondWeekData = 0;
    int thirdWeekData = 0;
    int forthWeekData = 0;
    userWorkoutsList.forEach((element) async{
      if(element.week == week[0]){
        firstWeekData = firstWeekData + element.caloriesBurn;
      }
      if(element.week == week[1]){
        secondWeekData = secondWeekData + element.caloriesBurn;
      }
      if(element.week == week[2]){
        thirdWeekData = thirdWeekData + element.caloriesBurn;
      }
      if(element.week == week[3]){
        forthWeekData = forthWeekData + element.caloriesBurn;
      }
    });
    return [firstWeekData, secondWeekData, thirdWeekData, forthWeekData];
  }

  getMonthlyUserWorkoutList(List week){
    int firstWeekData = 0;
    int secondWeekData = 0;
    int thirdWeekData = 0;
    int forthWeekData = 0;
    userWorkoutData.forEach((element) async{
      if(element.week == week[0]){
        firstWeekData = firstWeekData + element.caloriesBurn;
      }
      if(element.week == week[1]){
        secondWeekData = secondWeekData + element.caloriesBurn;
      }
      if(element.week == week[2]){
        thirdWeekData = thirdWeekData + element.caloriesBurn;
      }
      if(element.week == week[3]){
        forthWeekData = forthWeekData + element.caloriesBurn;
      }
    });
    return [firstWeekData, secondWeekData, thirdWeekData, forthWeekData];
  }

  clear(){
    totalWorkoutData = 0;
    totalUserWorkoutData = 0;
    workoutData.clear();
    weeklyBurnCalories.clear();
    weeklyWorkoutList.clear();
  }
  
}