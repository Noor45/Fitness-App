import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:t_fit/controllers/auth_controller.dart';
import 'package:t_fit/controllers/user_plan_controller.dart';
import 'package:t_fit/functions/graph_function.dart';
import 'package:t_fit/functions/workout_plan_functions.dart';
import 'package:t_fit/screens/main_screens/main_screen.dart';
import 'package:t_fit/utils/strings.dart';
import 'package:t_fit/widgets/confirm_box.dart';
import 'package:t_fit/widgets/input_field.dart';
import 'package:toast/toast.dart';
import '../utils/colors.dart';
import '../utils/style.dart';
import 'package:fl_chart/fl_chart.dart';
import '../cards/dashboard_cards.dart';
import '../utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class WorkoutActivity extends StatefulWidget {
  @override
  _WorkoutActivityState createState() => _WorkoutActivityState();
}

class _WorkoutActivityState extends State<WorkoutActivity> {
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
  int todayBurnCal = 0;
  int selectedWeek = 0;
  String week = '';
  String months = '';
  int totalMonth = 0;
  List graphList = [];
  List<String> weekList = [];
  List<String> monthList = [];

  dataList(){
    int month = (Constants.userWorkoutsList.length/30).round();
    month = month == 0 ? 1 : month;
    for(int i = 1; i <= Constants.workoutPlanDetail.duration; i++){
      weekList.add('$i');
    }
    totalMonth = (Constants.userWorkoutsList.length/30).round();
    totalMonth = totalMonth == 0 ? 1 : totalMonth;
    for(int i = 1; i <= totalMonth; i++){
      monthList.add('$i');
    }
    if(weekList.isNotEmpty) week = Constants.userWorkoutPlanData.currentWeek.toString();
    if(monthList.isNotEmpty) months = monthList[0];
  }
  weekData(){
    Constants.userWorkoutsList.forEach((element) {
      if(element.week == Constants.userWorkoutPlanData.currentWeek){
        weeklyBurnCalories.add(element.caloriesBurn);
        weeklyWorkoutList.add(element.workouts);
      }
      if(element.week == Constants.userWorkoutPlanData.currentWeek && element.day == Constants.userWorkoutPlanData.currentDay){
        todayBurnCal = element.caloriesBurn;
      }
    });
    print(Constants.userWorkoutPlanData.currentWeek);
    print(weeklyBurnCalories);
    print(weeklyWorkoutList);
    Constants.userWorkoutData.forEach((element) {
      if(element.week == Constants.userWorkoutPlanData.currentWeek){
        if(element.day != 0) workoutData.add(element.workout);
      }
      if(element.week == Constants.userWorkoutPlanData.currentWeek && element.day == Constants.userWorkoutPlanData.currentDay){
        if(element.workout == true) Constants.workoutProgressValue = 1.0;
        else Constants.workoutProgressValue = 0.0;
        userWorkout = element.workout;
      }
    });
  }

  initialize(){
    dataList();
    weekData();
    getDaysNameForWeeks(Constants.userWorkoutPlanData.currentWeek);
    day = Constants.userWorkoutPlanData.currentDay;
    selectedWeek = Constants.userWorkoutPlanData.currentWeek;

  }

  final _iconSize = 20;
  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DateTime.now().isBefore(AuthController.currentUser.workoutPlanDetail['end_date'].toDate().add(Duration(days: 1))) == false ? Container(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Congratulations!',
                  style: StyleRefer.kTextStyle.copyWith(
                      color: ColorRefer.kRedColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Your customised workout plan has been completed, Contact the trainer for more information',
                  textAlign: TextAlign.center,
                  style: StyleRefer.kTextStyle.copyWith(
                      color: ColorRefer.kPinkColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      height: 1.5),
                ),
              ],
            ),
          ) : Container(),
          Visibility(
            visible: DateTime.now().isBefore(AuthController.currentUser.workoutPlanDetail['end_date'].toDate().add(Duration(days: 1))) == true ? true : false,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                    child: Text(
                      'Quick add your Workout remarks',
                      style: StyleRefer.kTextStyle.copyWith(
                          color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: Text(
                      StringRefer.kWorkoutPlanString,
                      style: StyleRefer.kTextStyle.copyWith(
                          color: Color(0xffadadad),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          height: 1.5),
                    ),
                  ),
                  LayoutBuilder(builder: (context, constrains) {
                    double leftPadding = constrains.maxWidth * Constants.workoutProgressValue - _iconSize - 5;
                    return Container(
                      alignment: Constants.workoutProgressValue == 1.0 ? Alignment.centerRight : Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(
                          left: Constants.workoutProgressValue == 0.0 || Constants.workoutProgressValue == 1.0
                              ? 0
                              : leftPadding,
                          bottom: 10),
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: SvgPicture.asset(
                        'assets/icons/workout.svg',
                        color: Colors.orange,
                        width: _iconSize.toDouble(),
                        height: _iconSize.toDouble(),
                      ),
                    );
                  }),
                  LayoutBuilder(builder: (context, constrains) {
                    return Container(
                      padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                            value: Constants.workoutProgressValue == 0.0 ? 0 : Constants.workoutProgressValue,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                            backgroundColor: theme.lightTheme == true ? ColorRefer.kLightGreyColor : Colors.grey,
                            minHeight: 8),
                      ),
                    );
                  }),
                  InkWell(
                    onTap: (){
                      markWorkout();
                    },
                    child: Container(
                      width: width,
                      margin: EdgeInsets.only(left: 15, right: 15),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: userWorkout == true ? ColorRefer.kGreenColor : todayBurnCal == 0 ? Colors.orange :
                        theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Center(
                        child: Text(
                            userWorkout == true ? 'Workout Completed': todayBurnCal == 0 ? 'Rest Day' : 'Done with the workout?',
                            style: TextStyle(color: Colors.white, fontSize: 12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your workout remarks',
                  style: StyleRefer.kTextStyle.copyWith(
                      color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    GraphSign(
                      color: showPieGraph == false ? Colors.orange :
                      theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                      icon: 'assets/icons/bar-chart.svg',
                      onTap: (){
                        setState(() {
                          showPieGraph = false;
                        });
                      },
                    ),
                    SizedBox(width: 5),
                    GraphSign(
                      color: showPieGraph == true ? Colors.orange :
                      theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                      icon: 'assets/icons/pie-chart.svg',
                      onTap: (){
                        setState(() {
                          showPieGraph = true;
                        });
                      },
                    ),
                  ],
                )
              ],
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
                      months = option;
                      getMonthlyData('Month $option');
                      Constants.mealProgressValue = 0.0;
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
                      week = option;
                      getWeeklyData('Week $option');
                      Constants.mealProgressValue = 0.0;
                    });
                  },
                ),
              ],
            ),
          ),
          Visibility(
            visible: showPieGraph == false ? false : true,
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
                              '${(Constants.totalWorkoutData - Constants.totalUserWorkoutData).abs()} cal',
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
                                Constants.totalUserWorkoutData, Constants.totalWorkoutData, context)),
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
                            color: selectedWeek == Constants.userWorkoutPlanData.currentWeek ? DateFormat('EEE').format(DateTime.now()) == title1 ? Colors.orange :
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
                          color: graphList[index] == Constants.userWorkoutPlanData.currentWeek ? Colors.orange :
                          theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                          space: 25,
                        );
                      }
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: showPieGraph == true ? false : true,
            child: Container(
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
                                return weeklyBurnCalories[0] == 0 && weeklyWorkoutList[0].isEmpty == true ? 'Rest' : weeklyBurnCalories[0].toString();
                              case 1:
                                return weeklyBurnCalories[1] == 0 && weeklyWorkoutList[1].isEmpty == true  ? 'Rest' : weeklyBurnCalories[1].toString();
                              case 2:
                                return weeklyBurnCalories[2] == 0 && weeklyWorkoutList[2].isEmpty == true  ? 'Rest' : weeklyBurnCalories[2].toString();
                              case 3:
                                return weeklyBurnCalories[3] == 0 && weeklyWorkoutList[3].isEmpty == true ? 'Rest' : weeklyBurnCalories[3].toString();
                              case 4:
                                return weeklyBurnCalories[4] == 0 && weeklyWorkoutList[4].isEmpty == true ? 'Rest' : weeklyBurnCalories[4].toString();
                              case 5:
                                return weeklyBurnCalories[5] == 0 && weeklyWorkoutList[5].isEmpty == true ? 'Rest' : weeklyBurnCalories[5].toString();
                              case 6:
                                return weeklyBurnCalories[6] == 0 && weeklyWorkoutList[6].isEmpty == true ? 'Rest' : weeklyBurnCalories[6].toString();
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
          ),
          Divider(color: ColorRefer.kDividerColor),
          WeeklyChart(
            text1: 'Calories Burn',
            text2: showWeeklyData == false ? 'Monthly Goal' : 'Weekly Goal',
            calories: Constants.totalUserWorkoutData,
            goal: Constants.totalWorkoutData,
          ),
          Divider(color: theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kDividerColor, thickness: 8),
        ],
      ),
    );
  }

  markWorkout() async {
    if(todayBurnCal != 0){
      if(userWorkout == false){
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return ConfirmBox(
              type: 1,
              title: 'Are you done with your',
              subTitle: 'Workout?',
              firstButtonTitle: 'Tap to Confirm',
              firstButtonColor: ColorRefer.kRedColor,
              secondButtonOnPressed: (){},
              secondButtonColor: ColorRefer.kSecondBlueColor,
              secondButtonTitle: '',
              firstButtonOnPressed: () {
                Constants.userWorkoutData.forEach((element) {
                  if(element.day == Constants.userWorkoutPlanData.currentDay && element.week == Constants.userWorkoutPlanData.currentWeek){
                    element.workout = true;
                    element.caloriesBurn = todayBurnCal;
                  }
                });
                DietPlanController.saveWorkoutData();
                Navigator.pushNamedAndRemoveUntil(context, MainScreen.MainScreenId, (route) => false);
                Toast.show("Workout Done", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              },
            );
          },
        );
      }
    }
  }

  getDaysNameForWeeks(int week){
    setState(() {
      graphList = [];
      int i = 0;
      var formatter = new DateFormat('EEE');
      for( i = (week*7)-7; i<(week*7); i++){
        graphList.add(formatter.format(AuthController.currentUser.workoutPlanDetail['start_date'].toDate().add(Duration(days: i))));
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
    getUserWeeklyWorkout(weekNo);
    Constants.userWorkoutsList.forEach((e) {
      print(e.week);
      print(e.day);
      print(e.caloriesBurn);
    });
    Constants.userWorkoutsList.forEach((element) {
      if(element.week == weekNo){
        weeklyBurnCalories.add(element.caloriesBurn);
        weeklyWorkoutList.add(element.workouts);
      }
    });
    print(weekNo);
    print(weeklyBurnCalories);
    Constants.userWorkoutData.forEach((element) {
      if(element.week == weekNo){
        if(element.day != 0) workoutData.add(element.workout);
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
      if(Constants.userWorkoutPlanData != null){
        weeks.forEach((weekNo) {
          if(Constants.planDetail.workout == 1){
            Future.wait(
                Constants.userWorkoutData.map((element) async{
                  if(element.week == weekNo){
                    Constants.totalUserWorkoutData = Constants.totalUserWorkoutData + element.caloriesBurn;
                  }
                })
            );
            Future.wait(
                Constants.userWorkoutsList.map((element) async{
                  if(element.week == weekNo){
                    Constants.totalWorkoutData = Constants.totalWorkoutData + element.caloriesBurn;
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
    Constants.userWorkoutsList.forEach((element) async{
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
    Constants.userWorkoutData.forEach((element) async{
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
    Constants.totalWorkoutData = 0;
    Constants.totalUserWorkoutData = 0;
    workoutData.clear();
    weeklyBurnCalories.clear();
    weeklyWorkoutList.clear();
  }

}