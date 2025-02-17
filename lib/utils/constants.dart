import 'dart:io';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:t_fit/models/mental_health_model/mental_health_model.dart';
import 'package:t_fit/models/user_model/diary_model.dart';
import 'package:t_fit/models/user_model/local_notification_model.dart';
import 'package:t_fit/models/user_model/qoutes_model.dart';
import 'package:t_fit/models/user_model/user_weight_model.dart';
import 'package:t_fit/models/user_plan_data_model/user_data_model.dart';
import 'package:t_fit/models/user_plan_data_model/user_meal_data_model.dart';
import 'package:t_fit/models/user_plan_data_model/user_plan_data_model.dart';
import 'package:t_fit/models/user_plan_data_model/user_workout_data_model.dart';
import '../models/user_model/blog_model.dart';
import '../models/meal_model/meal_model.dart';
import '../models/meal_model/meal_plan_model.dart';
import '../models/user_model/par_q_model.dart';
import '../models/supplement_model/supplement_model.dart';
import '../models/user_model/user_plan_model.dart';
import '../models/workout_model/workout_detail_model.dart';
import '../models/workout_model/workout_model.dart';
import '../widgets/confirm_box.dart';
import '../models/user_plan_data_model/plans_model.dart';
import '../models/user_plan_data_model/user_plan_data_model.dart';
import 'dart:core';

int transitionDelay = 300;
Function kEmailValidator = (emailValue) {
  if (emailValue.isEmpty) {
    return 'Email is required';
  }
  String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
      "\\@" +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
      "(" +
      "\\." +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
      ")+";
  RegExp regExp = new RegExp(p);
  if (regExp.hasMatch(emailValue)) {
    return null;
  } else {
    return 'Email Syntax is not Correct';
  }
};

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

extension FileExtention on FileSystemEntity{
  String get name {
    return this?.path?.split("/")?.last;
  }
}

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}

extension DateOnlyCompare on DateTime {
  bool isEqual(DateTime other) {
    return year == other.year && month == other.month
        && day == other.day;
  }
}

class Constants {
 static bool update = false;
 static bool planMealAssign = false;
 static bool planWorkoutAssign = false;
 static bool planSupplementAssign = false;
 static double dayProgressValue = 100.0;
 static double mealProgressValue = 0.0;
 static double workoutProgressValue = 0.0;
 static String path = '';
 static String pdfID = '';
 static String pdfPath = '';
 static PlanModel mealPlanDetail;
 static PlanModel workoutPlanDetail;
 static PlanModel supplementPlanDetail;
 static MealPlanModel todayMealDetail;
 static List<MealPlanModel> userMealList = [];
 static Qoutes qoutes = Qoutes();
 static LocalNotificationTimeModel notificationTime = LocalNotificationTimeModel();
 static List<WorkoutPlanModel> userWorkoutsList = [];
 static List<DiaryModel> journalList = [];
 static List<SupplementPlanModel> userSupplementsList = [];
  static List<WorkoutPlanModel> userWeeklyWorkoutsList = [];
 static List<MealPlanModel> userWeeklyMealList = [];
 static List<SupplementPlanModel> userWeeklySupplementsList = [];
  static List<WorkoutDetailModel> workoutDetailList = [];
  static List<MealModel> mealDetailList = [];
 static List<PARQModel> parQList  = [];
 static List<UserWeightModel> userWeightList  = [];
 static UserWeightModel dailyWeight  = UserWeightModel();
 static List<BlogModel> blogList  = [];
 static List<MentalHealthModel> mentalHealthBlogList  = [];
 static MentalHealthModel mentalHealthBlog = MentalHealthModel();
 static UserDataModel mealPlanData;
 static UserDataModel workoutPlanData;
 static UserPlanDataModel userMealPlanData = UserPlanDataModel();
 static UserPlanDataModel userWorkoutPlanData = UserPlanDataModel();
 static PlanAssignModel planDetail = PlanAssignModel();
 static List<UserMealDataModel> userMealData = [];
 static List<UserWorkoutPlanModel> userWorkoutData  = [];
 static int totalUserWorkoutData = 0;
 static int totalWorkoutData = 0;
 static int totalMealData = 0;
 static int totalUserMealData = 0;
 static bool fullScreen = false;
 static ThemeMode theme = ThemeMode.light;
 static bool notificationVisibility = false;
 static void showModel(BuildContext context){
   showDialog(
     context: context,
     builder: (BuildContext context) {
       return ConfirmBox(
         title: 'Workout Completed',
         subTitle: 'Feeling better!',
         firstButtonTitle: 'Good Job! View Insights',
         firstButtonOnPressed: (){
           Navigator.pop(context);
         },
       );
     },
   );
 }
}

class VideoTools {
  static int setNo = 1;
  static bool workoutStart = false;
  static bool videoShow = false;
  static bool timerShow = false;
  static int workoutIndex = 0;
  static int duration = 10;
  static CountDownController countController = CountDownController();
  static int secs = 30;
  static int mins = 0;
  static String videoID = '';
  static Widget videoWidget;
  static bool setsButtonDisable;
  static bool exerciseButtonDisable;
  static Color setsButtonColor;
  static Color repColor;
  static Color restColor;
  static String setButtonTitle;
  static String exerciseButtonTitle;
  static WorkoutDetailModel workout = WorkoutDetailModel();
  static Color exerciseButtonColor;
  static bool videoLoad = false;
}


