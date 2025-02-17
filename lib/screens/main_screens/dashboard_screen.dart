import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:t_fit/cards/main_graph_card.dart';
import 'package:t_fit/functions/global_functions.dart';
import 'package:t_fit/functions/meal_plan_functions.dart';
import 'package:t_fit/functions/user_progress_function.dart';
import 'package:t_fit/functions/workout_plan_functions.dart';
import 'package:t_fit/models/user_model/user_model.dart';
import 'package:t_fit/screens/calculators/fat_calculator_screen.dart';
import 'package:t_fit/screens/weight_screens/measure_weight_screen.dart';
import '../../cards/dashboard_cards.dart';
import '../../cards/drop_down_card.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/style.dart';
import '../../cards/meal_activity_card.dart';
import '../../cards/workout_activity_card.dart';
import 'package:intl/intl.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  String _date;
  int touchedIndex = -1;
  int willTabBarCurrentValue = 0;
  void _initData() {
    var formatter = new DateFormat('dd MMMM yyyy');
    _date = formatter.format(DateTime.now());
    if(AuthController.currentUser.mealPlanDetail != null || AuthController.currentUser.workoutPlanDetail != null)
    UserProgressFunction.getDayProgress();
    getUserMealPlanDetail(Constants.userMealPlanData.currentWeek);
    getUserWorkoutPlanDetail();
  }

  @override
  void initState() {
    _initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 15, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    'Hi ${AuthController.currentUser.name}!',
                    style: StyleRefer.kTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  AutoSizeText(
                    Constants.qoutes == null ? 'Get comfortable with being uncomfortable' : Constants.qoutes.qoutesList[DateTime.now().difference(Constants.qoutes.startDate.toDate()).inDays],
                      style: StyleRefer.kTextStyle
                        .copyWith(color: ColorRefer.kPinkColor),
                  ),
                  SizedBox(height: 5),
                  AutoSizeText(
                    _date,
                    style: StyleRefer.kTextStyle
                        .copyWith(color: ColorRefer.kThirdBlueColor),
                  ),
                ],
              ),
            ),
            Container(
              child: Constants.planMealAssign == false && Constants.planWorkoutAssign == false && Constants.planSupplementAssign == false &&  AuthController.currentUser.mentalHealth == false
                  ?  EmptyDashboard(
                  title: 'Hold Tight!',
                  subTitle: 'Your customized meal and workout plan will be soon available.')
                  :  Constants.planMealAssign == false && Constants.planWorkoutAssign == false && Constants.planSupplementAssign == false && AuthController.currentUser.mentalHealth == true ?
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection('users').doc(AuthController.currentUser.uid).snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    UserModel object = UserModel.fromMap(snapshot.data.data());
                    updatePlan(object.updatePlan);
                  }
                  return EmptyDashboard(
                      title: 'Hold Tight!',
                      subTitle: 'Your customized meal and workout plan will be soon available.');
                }
              ) :
              StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance.collection('users').doc(AuthController.currentUser.uid).snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      UserModel object = UserModel.fromMap(snapshot.data.data());
                      updatePlan(object.updatePlan);
                      Constants.mealProgressValue = 0.0;
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MainGraph(),
                        Visibility(
                          visible: Constants.planMealAssign == true ? true : false,
                          child: DropDownCard(
                            title: 'Meal Activity',
                            widget: MealActivity(),
                          ),
                        ),
                        Visibility(
                          visible: Constants.planDetail.workout == 1 ? true : false,
                          child: DropDownCard(
                            title: 'Workout Activity',
                            widget: WorkoutActivity(),
                          ),
                        ),
                        BottomCard(
                          title: 'WEIGHT',
                          subTitle: 'Measure your weight',
                          onTap: () async{
                            await Navigator.pushNamed(context,  MeasureWeightScreen.ID);
                            setState(() {});
                          },
                        ),
                        BottomCard(
                          title: 'FAT',
                          subTitle: 'Body Fat Calculator',
                          onTap: () async{
                            await Navigator.pushNamed(context, FatCalculatorScreen.ID);
                            setState(() {});
                          },
                        ),
                        SizedBox(height: 35),
                      ],
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}

