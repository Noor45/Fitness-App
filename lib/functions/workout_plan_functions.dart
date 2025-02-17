import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:eval_ex/built_ins.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../controllers/general_controller.dart';
import '../controllers/user_plan_controller.dart';
import '../database/local_storage_function.dart';
import '../models/meal_model/meal_plan_model.dart';
import '../shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';
import '../controllers/auth_controller.dart';
import 'package:recursive_regex/recursive_regex.dart';
import 'package:intl/intl.dart';

getUserWeeklyWorkout(int week){
  Constants.totalUserWorkoutData = 0;
  Constants.totalWorkoutData = 0;
  Constants.userWorkoutsList.forEach((element) {
    if(element.week == week){
      Constants.totalWorkoutData = Constants.totalWorkoutData + element.caloriesBurn;
    }
  });

  Constants.userWorkoutData.forEach((element) {
    if(element.week == week){
      Constants.totalUserWorkoutData = Constants.totalUserWorkoutData + element.caloriesBurn;
    }
  });
}

getUserWorkoutPlanDetail(){
  if(Constants.userWorkoutPlanData != null){
    Constants.totalUserWorkoutData = 0;
    Constants.totalWorkoutData = 0;
    if(Constants.planDetail.workout == 1){
      Constants.userWorkoutsList.forEach((element) {
        if(element.week == Constants.userWorkoutPlanData.currentWeek){
          Constants.totalWorkoutData = Constants.totalWorkoutData + element.caloriesBurn;
        }
      });
      Constants.userWorkoutData.forEach((element) {
        if(element.week == Constants.userWorkoutPlanData.currentWeek){
          Constants.totalUserWorkoutData = Constants.totalUserWorkoutData + element.caloriesBurn;
        }
      });
    }
  }
}