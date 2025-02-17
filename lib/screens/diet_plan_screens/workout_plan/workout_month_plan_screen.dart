import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../../../cards/custom_cards.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/style.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';
import '../../../screens/diet_plan_screens/workout_plan/workout_week_plan_screen.dart';


class WorkoutMonthPlanScreen extends StatefulWidget {
  static const String ID = "/workout_month_plan_screen";
  @override
  _WorkoutMonthPlanScreenState createState() => _WorkoutMonthPlanScreenState();
}

class _WorkoutMonthPlanScreenState extends State<WorkoutMonthPlanScreen> {
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor:  theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
        centerTitle: true,
        title: Text(
          '${Constants.workoutPlanDetail.planName}',
          style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 15),
        ),
        systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      ),
      body: SafeArea(
        child: ModalProgressHUD(
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
                    title: '${Constants.workoutPlanDetail.duration * 7} Days Workout Routine',
                    subtitle: '${Constants.workoutPlanDetail.duration} ${Constants.workoutPlanDetail.duration == 1 ? 'Week' :'Weeks'}, ${Constants.workoutPlanDetail.duration * 7} Days',
                  ),
                  SizedBox(height: 15),
                  Container(
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: Constants.workoutPlanDetail.duration,
                        itemBuilder: (BuildContext context, int index) {
                          return WeekCards(
                            title: 'WEEK ${index + 1}',
                            subtitle: '7 Days Workout Routine',
                            icon: 'assets/icons/workout.svg',
                            onPressed: () async {
                              Constants.userWeeklyWorkoutsList = [];
                              Constants.userWorkoutsList.forEach((element) {
                                if(element.week == index+1){
                                  Constants.userWeeklyWorkoutsList.add(element);
                                }
                              });
                                Navigator.pushNamed(context, WorkoutWeekPlanScreen.ID, arguments: index + 1);
                            },
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
