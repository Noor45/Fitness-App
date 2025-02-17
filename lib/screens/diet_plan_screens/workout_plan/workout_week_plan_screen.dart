import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../../../cards/custom_cards.dart';
import '../../../cards/diet_plan_card.dart';
import '../../../models/workout_model/workout_detail_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';
import '../../../screens/diet_plan_screens/workout_plan/workout_plan_detail_screen.dart';


class WorkoutWeekPlanScreen extends StatefulWidget {
  static const String ID = "/workout_week_plan_screen";
  @override
  _WorkoutWeekPlanScreenState createState() => _WorkoutWeekPlanScreenState();
}

class _WorkoutWeekPlanScreenState extends State<WorkoutWeekPlanScreen> {
  bool _isLoading = false;
  List list = [];
  List weekDays = [];
  weekList(int week){
    setState(() {
      int i = 0;
      var formatter = new DateFormat('EEEE');
      for( i = (week*7)-7; i<(week*7); i++){
        if(Constants.workoutPlanDetail.startDate.toDate().isAfter(Constants.workoutPlanDetail.endDate.toDate().add(Duration(days: i)))) return;
        else weekDays.add(formatter.format(Constants.workoutPlanDetail.startDate.toDate().add(Duration(days: i))));
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    int week = ModalRoute.of(context).settings.arguments;
    weekList(week);
    return Scaffold(
        backgroundColor:  theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
          centerTitle: true,
          title: Text(
            'WEEK $week',
          ),
          systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
        ),
        body: ModalProgressHUD(
          inAsyncCall: _isLoading,
          progressIndicator: Theme(
            data: Theme.of(context).copyWith(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorRefer.kRedColor)),
            child: CircularProgressIndicator(),
          ),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ImageCard(
                    image: 'assets/images/workout.png',
                    title: '${Constants.workoutPlanDetail.duration * 7} Days Challenge',
                    subtitle: '${Constants.workoutPlanDetail.duration} ${Constants.workoutPlanDetail.duration == 1 ? 'Week' :'Weeks'}, ${Constants.workoutPlanDetail.duration * 7} Days',
                  ),
                  SizedBox(height: 15),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: Constants.userWeeklyWorkoutsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        bool userWorkout = false;
                        Constants.workoutDetailList.clear();
                        if(Constants.userWeeklyWorkoutsList[index].workouts.isNotEmpty){
                          Constants.userWeeklyWorkoutsList[index].workouts.forEach((element) {
                            WorkoutDetailModel workoutDetail = WorkoutDetailModel.fromMap(element);
                            Constants.workoutDetailList.add(workoutDetail);
                          });
                        }
                        Constants.userWorkoutData.forEach((element) {
                          if(element.week == Constants.userWeeklyWorkoutsList[index].week && element.day == Constants.userWeeklyWorkoutsList[index].day){
                            userWorkout = element.workout;
                          }
                        });

                        return index > weekDays.length-1 ? Container() : Container(
                          margin: EdgeInsets.only(top: 15),
                          child: WeekWorkoutPlanCard(
                            data: Constants.workoutDetailList,
                            name: Constants.userWeeklyWorkoutsList[index].title,
                            calBurn: Constants.userWeeklyWorkoutsList[index].caloriesBurn,
                            title: 'Day ${index+1} ${weekDays[index]}',
                            done: userWorkout,
                            onPressed: () async {
                              if(Constants.userWeeklyWorkoutsList[index].workouts.isNotEmpty){
                                Constants.workoutDetailList.clear();
                                if(Constants.userWeeklyWorkoutsList[index].workouts.isNotEmpty){
                                  Constants.userWeeklyWorkoutsList[index].workouts.forEach((element) {
                                    WorkoutDetailModel workoutDetail = WorkoutDetailModel.fromMap(element);
                                    Constants.workoutDetailList.add(workoutDetail);
                                  });
                                }
                                Navigator.pushNamed(context, WorkoutPlanDetailScreen.ID, arguments: [Constants.userWeeklyWorkoutsList[index], userWorkout]);
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






