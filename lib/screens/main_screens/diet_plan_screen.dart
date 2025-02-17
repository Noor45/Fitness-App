import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:t_fit/controllers/auth_controller.dart';
import 'package:t_fit/controllers/general_controller.dart';
import 'package:t_fit/database/local_storage_function.dart';
import 'package:t_fit/screens/diet_plan_screens/workout_plan/workout_month_plan_screen.dart';
import 'package:t_fit/screens/mental_health_screens/mind_fullness_screen.dart';
import '../../cards/dashboard_cards.dart';
import '../../screens/diet_plan_screens/meal_plan/meal_month_plan_screen.dart';
import '../../screens/diet_plan_screens/supplements_plan/suppliment_month_plan_screen.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/style.dart';

class DietPlanScreen extends StatefulWidget {
  @override
  _DietPlanScreenState createState() => _DietPlanScreenState();
}

class _DietPlanScreenState extends State<DietPlanScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Constants.planMealAssign == false && Constants.planWorkoutAssign == false && Constants.planSupplementAssign == false && AuthController.currentUser.mentalHealth == false
            ?  EmptyDashboard(
            title: 'Hold Tight!',
            subTitle: 'Your customized meal and workout plan will be soon available.')
            : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: AutoSizeText(
                        'Your customized plans are ready. Start reaching your goals.',
                        style: StyleRefer.kTextStyle
                            .copyWith(color: ColorRefer.kPinkColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 5),
                    Visibility(
                      visible: Constants.planWorkoutAssign == false ? false : true,
                      child: PlanCard(
                        title: Constants.workoutPlanDetail != null ? '${Constants.workoutPlanDetail.duration * 7} Days Workout Routine' : 'Workout Routine',
                        subtitle:  Constants.workoutPlanDetail != null ? '${Constants.workoutPlanDetail.duration} ${Constants.workoutPlanDetail.duration == 1 ? 'Week' :'Weeks'} Workout Plan' : 'Workout Plan for weeks',
                        image: 'assets/images/workout.png',
                        onPressed: () async{

                          Navigator.pushNamed(context, WorkoutMonthPlanScreen.ID);
                        },
                      ),
                    ),
                    Visibility(
                      visible: Constants.mealPlanDetail == null ? false : Constants.planMealAssign == false ? false : true,
                      child: PlanCard(
                        title: Constants.mealPlanDetail != null ? '${Constants.mealPlanDetail.duration * 7} Days ${Constants.mealPlanDetail.planName}' : 'Diet Plan',
                        subtitle: Constants.mealPlanDetail != null ? '${Constants.mealPlanDetail.duration} ${Constants.mealPlanDetail.duration == 1 ? 'Week' :'Weeks'} Customised Diet Plan' : 'Customised Diet Plan for weeks',
                        image: 'assets/images/meal.png',
                        onPressed: () async{
                          Navigator.pushNamed(context, MealMonthPlanScreen.ID);
                        },
                      ),
                    ),
                    Visibility(
                      visible: Constants.supplementPlanDetail == null ? false : Constants.planSupplementAssign == false ? false : true,
                      child: PlanCard(
                        title: 'Daily Supplements',
                        subtitle: 'Your Prescribed Supplements',
                        image: 'assets/images/supplements.png',
                        onPressed: () {
                          // GeneralController.getUserWeight();
                          Navigator.pushNamed(context, SupplimentMonthPlanScreen.ID);
                        },
                      ),
                    ),

                    Visibility(
                      visible: AuthController.currentUser.mentalHealth,
                      child: PlanCard(
                        title: 'Mindfulness',
                        subtitle: 'Lorem Ipsum Dolor Sit Amet.',
                        image: 'assets/images/mindfullness.png',
                        onPressed: () async{
                          await DatabaseHelper.instance.getNotificationTime();
                          Navigator.pushNamed(context, MindFullnessMainScreen.ID);
                        },
                      ),
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}