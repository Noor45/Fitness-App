import 'dart:io';
import '../controllers/auth_controller.dart';
import '../models/mental_health_model/mental_health_model.dart';
import '../models/user_plan_data_model/user_data_model.dart';
import '../models/user_plan_data_model/user_meal_data_model.dart';
import '../models/user_plan_data_model/user_plan_data_model.dart';
import '../models/user_plan_data_model/user_workout_data_model.dart';
import '../database/local_storage_function.dart';
import '../models/meal_model/meal_plan_model.dart';
import '../models/supplement_model/supplement_model.dart';
import '../models/workout_model/workout_model.dart';
import '../utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DietPlanController {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final dbHelper = DatabaseHelper.instance;

  //************************** Meal Plan Functions **************************

  /**************************************************
      FUNCTION TO GET TODAY MEAL PLAN
   *********************************************////

  static todayMealPlan() async {
    try {
      Constants.userMealList.forEach((element) {
        if(element.week == Constants.userMealPlanData.currentWeek && element.day == Constants.userMealPlanData.currentDay){
          Constants.todayMealDetail =  MealPlanModel.fromMap(element.toMap());
        }
      });
      return;
    } on SocketException catch (error) {
      print("$error");
    } on FirebaseException catch (error) {
      print("$error");
    }
  }

  /**************************************************
      FUNCTION TO GET USER MEAL PLAN DETAIL
   *********************************************////

  static Future<void> getMealPlan() async {
    try {
      QuerySnapshot snapShot = await _firestore.collection('users')
          .doc(AuthController.currentUser.uid).collection('meals').orderBy('day', descending: false).get();
      if(snapShot.docs.isNotEmpty){
        if(Constants.planDetail.meal == 1) await dbHelper.removeMealPlan();
        final meals = snapShot.docs;
        Future.wait(
            meals.map((e) async{
              MealPlanModel  mealPlan = MealPlanModel.fromMap(e.data());
              await dbHelper.insertMealPlan(mealPlan);
            })
        );
        await dbHelper.setMealPlan();
      }
      return;
    } on SocketException catch (error) {
      print("$error");
    } on FirebaseException catch (error) {
      print("$error");
    }
  }

  /**************************************************
      FUNCTION TO SAVE USER MEAL DATA
   *********************************************////

  static Future<void> saveMealData() async {
    try {
      List mealData = [];
      Constants.userMealData.forEach((element) {
        mealData.add(element.toMap());
      });
      await _firestore.collection('user_plan_data')
          .doc(Constants.mealPlanData.id).update({'meal.data': mealData});
      return;
    } on SocketException catch (error) {
      print("$error");
    } on FirebaseException catch (error) {
      print("$error");
    }
  }

  /**************************************************
         FUNCTION TO INITIALIZE MEAL DATA
   *********************************************////

  static mealDataInserts() async{
    Constants.userMealPlanData.currentDate = Timestamp.now();
    Constants.userMealPlanData.currentDay = 1;
    List mealDataList = [];
    int day = 0;
    int week = 0;
    Constants.userMealData.clear();
    for(int i = 0; i<= Constants.mealPlanDetail.endDate.toDate().difference(Constants.mealPlanDetail.startDate.toDate()).inDays; i++){
      UserMealDataModel mealData = UserMealDataModel();
      day++;
      if(i%7 == 0)  week++;
      mealData.week = week;
      mealData.day = day;
      mealData.caloriesTaken = 0;
      mealData.extraCalories = 0;
      Constants.userMealList.forEach((element) {
        if(element.week == mealData.week && element.day == mealData.day){
          mealData.mealData =  List.filled(element.meals.length, {'mark': false, 'portion': 0});
        }
      });
      if(day%7 == 0)  day = 0;
      mealDataList.add(mealData.toMap());
      Constants.userMealData.add(mealData);
    }
    await _firestore.collection('user_plan_data').doc(Constants.mealPlanData.id)
        .update({'meal.current_day': Constants.userMealPlanData.currentDay, 'meal.current_date':Constants.userMealPlanData.currentDate,
      'meal.data': mealDataList});
  }

  /**************************************************
      FUNCTION TO UPDATE USER MEAL DATA FOR DAY
   *********************************************////

  static mealDataUpdates() async{
    DateTime perDate = Constants.userMealPlanData.currentDate.toDate();
    int diff = DateTime.now().day - Constants.userMealPlanData.currentDate.toDate().day;
    diff = (diff.isNegative || diff == 0) ? DateTime.now().difference(perDate).inDays : diff;
    if(Constants.userMealPlanData.currentDay == 7) Constants.userMealPlanData.currentDay = 1;
    else Constants.userMealPlanData.currentDay = DateTime.now().difference(perDate).inDays.isNegative ? (Constants.userMealPlanData.currentDay + 1) : (Constants.userMealPlanData.currentDay+diff);
    Constants.userMealPlanData.currentDate = Timestamp.now();
    await _firestore.collection('user_plan_data').doc(Constants.mealPlanData.id)
        .update({'meal.current_day': Constants.userMealPlanData.currentDay, 'meal.current_date':Constants.userMealPlanData.currentDate});
  }

  /**************************************************
        FUNCTION TO GET USER MEAL DATA
   *********************************************////

  static Future<void> getUserMealData() async {
    try {
      if(AuthController.currentUser != null){
        if(AuthController.currentUser.mealPlanDetail != null){
          QuerySnapshot snapShot= await _firestore.collection('user_plan_data').where('user_id', isEqualTo: AuthController.currentUser.uid).
          where('meal_plan_id', isEqualTo: AuthController.currentUser.mealPlanDetail['id']).get();
          if(snapShot.docs.isNotEmpty){
            List userData = snapShot.docs;
            userData.forEach((e) {
              DocumentSnapshot value = e;
              Constants.mealPlanData = UserDataModel.fromMap(value.data());
              if(AuthController.currentUser.mealPlanDetail != null){
                if(Constants.mealPlanData.mealPlanId == AuthController.currentUser.mealPlanDetail['id']){
                  if(Constants.mealPlanData.meal != null){
                    Constants.userMealPlanData.currentDay = Constants.mealPlanData.meal['current_day'];
                    Constants.userMealPlanData.currentWeek = Constants.mealPlanData.meal['current_week'];
                    Constants.userMealPlanData.weekDate = Constants.mealPlanData.meal['week_date'];
                    Constants.userMealPlanData.currentDate = Constants.mealPlanData.meal['current_date'];
                    Constants.userMealPlanData.data = Constants.mealPlanData.meal['data'];
                    Constants.userMealPlanData.data.forEach((e) {
                      UserMealDataModel mealData = UserMealDataModel.fromMap(e);
                      Constants.userMealData.add(mealData);
                    });
                  }
                }
              }
            });
          }
        }
      }
      return;
    } on SocketException catch (error) {
      print("$error");
    } on FirebaseException catch (error) {
      print("$error");
    }
  }

  /**************************************************
      FUNCTION TO GET USER MEAL DATA BY ID
   *********************************************////

  static Future getUserMealDataByPlanID(String planId) async {
    try {
      if(AuthController.currentUser != null){
        if(AuthController.currentUser.mealPlanDetail != null){
          QuerySnapshot snapShot= await _firestore.collection('user_plan_data').where('user_id', isEqualTo: AuthController.currentUser.uid).
          where('meal_plan_id', isEqualTo: planId).get();
          if(snapShot.docs.isNotEmpty){
            List userData = snapShot.docs;
            UserPlanDataModel userMealPlanData = UserPlanDataModel();
            List<UserMealDataModel> userMealData = [];
            userData.forEach((e) {
              DocumentSnapshot value = e;
              UserDataModel mealPlanData = UserDataModel.fromMap(value.data());
              if(AuthController.currentUser.mealPlanDetail != null){
                if(mealPlanData.mealPlanId == AuthController.currentUser.mealPlanDetail['id']){
                  if(mealPlanData.meal != null){
                    userMealPlanData.currentDay = mealPlanData.meal['current_day'];
                    userMealPlanData.currentWeek = mealPlanData.meal['current_week'];
                    userMealPlanData.weekDate = mealPlanData.meal['week_date'];
                    userMealPlanData.currentDate = mealPlanData.meal['current_date'];
                    userMealPlanData.data = mealPlanData.meal['data'];
                    userMealPlanData.data.forEach((e) {
                      UserMealDataModel mealData = UserMealDataModel.fromMap(e);
                      userMealData.add(mealData);
                    });
                  }
                }
              }
            });
            return [userMealPlanData, userMealData];
          }
        }
      }
      return;
    } on SocketException catch (error) {
      print("$error");
    } on FirebaseException catch (error) {
      print("$error");
    }
  }

  /**************************************************
     FUNCTION TO UPDATE USER MEAL DATA FOR WEEK
   *********************************************////

  static Future<void> checkMealWeekPlan() async {
    try {
      if(Constants.mealPlanData != null){
        if(Constants.mealPlanData.meal != null && Constants.mealPlanDetail != null){
          if(DateTime.now().isBefore(Constants.mealPlanDetail.endDate.toDate().add(Duration(days: 1))) == true){
            if(Constants.userMealPlanData.currentWeek <= Constants.mealPlanDetail.duration){
              DateTime nextWeekDate = DateTime(Constants.userMealPlanData.weekDate.toDate().year, Constants.userMealPlanData.weekDate.toDate().month, Constants.userMealPlanData.weekDate.toDate().day);
              DateTime currentDate = DateTime(Constants.userMealPlanData.currentDate.toDate().year, Constants.userMealPlanData.currentDate.toDate().month, Constants.userMealPlanData.currentDate.toDate().day);
              if(Constants.userMealPlanData.currentWeek == 0){
                Constants.userMealPlanData.currentWeek = Constants.userMealPlanData.currentWeek + 1;
                Constants.userMealPlanData.weekDate = Timestamp.fromDate(nextWeekDate.add(Duration(days: 7)));
                await _firestore.collection('user_plan_data').doc(Constants.mealPlanData.id).update({'meal.week_date': Constants.userMealPlanData.weekDate, 'meal.current_week': Constants.userMealPlanData.currentWeek});
                int diff = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).difference(AuthController.currentUser.mealPlanDetail['start_date'].toDate()).inDays;
                DateTime endDate = AuthController.currentUser.mealPlanDetail['end_date'].toDate();
                AuthController.currentUser.mealPlanDetail['start_date'] = Timestamp.fromDate(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
                AuthController.currentUser.mealPlanDetail['end_date'] = Timestamp.fromDate(endDate.add(Duration(days: diff)));
                await AuthController().updateUserFields();
              }else{
                if(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).isAfter(nextWeekDate) == true){
                  if(Constants.userMealPlanData.currentWeek == Constants.mealPlanDetail.duration) Constants.userMealPlanData.currentWeek = Constants.mealPlanDetail.duration ;
                  else Constants.userMealPlanData.currentWeek = Constants.userMealPlanData.currentWeek + 1;
                  Constants.userMealPlanData.weekDate = Timestamp.fromDate(nextWeekDate.add(Duration(days: 7)));
                  await _firestore.collection('user_plan_data').doc(Constants.mealPlanData.id)
                      .update({'meal.week_date': Constants.userMealPlanData.weekDate, 'meal.current_week': Constants.userMealPlanData.currentWeek});
                }
              }
              if(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).isAfter(currentDate) == true && Constants.userMealPlanData.currentDay != 0){
                await mealDataUpdates();
              }
              if(Constants.userMealPlanData.currentDay == 0){
                await mealDataInserts();
              }
            }
          }
        }
      }
      return;
    } on SocketException catch (error) {
      print("$error");
    } on FirebaseException catch (error) {
      print("$error");
    }
  }

  //************************** Workout Plan Functions **************************

  /**************************************************
      FUNCTION TO GET USER WORKOUT PLAN DETAIL
   *********************************************////

  static Future<void> getWorkoutPlan() async {
    try {
      QuerySnapshot snapShot = await _firestore.collection('users')
          .doc(AuthController.currentUser.uid).collection('workouts').orderBy('day', descending: false).get();
      if(Constants.planDetail.workout == 1) await dbHelper.removeWorkoutPlan();
      if(snapShot.docs.isNotEmpty){
        final meals = snapShot.docs;
        Future.wait(
            meals.map((e) async{
              WorkoutPlanModel  workoutPlan = WorkoutPlanModel.fromMap(e.data());
              await dbHelper.insertWorkoutPlan(workoutPlan);
            })
        );
        await dbHelper.setWorkoutPlan();
      }
      return;
    } on SocketException catch (error) {
      print("$error");
    } on FirebaseException catch (error) {
      print("$error");
    }
  }

  /**************************************************
         FUNCTION TO SAVE WORKOUT DATA
   *********************************************////

  static Future<void> saveWorkoutData() async {
    try {
      List workoutData = [];
      Constants.userWorkoutData.forEach((element) {
        workoutData.add(element.toMap());
      });
      await _firestore.collection('user_plan_data')
          .doc(Constants.workoutPlanData.id).update({'workout.data': workoutData});
      return;
    } on SocketException catch (error) {
      print("$error");
    } on FirebaseException catch (error) {
      print("$error");
    }
  }

  /**************************************************
    FUNCTION TO INITIALIZE WORKOUT DATA
   *********************************************////

  static workoutDataInserts() async{
    Constants.userWorkoutPlanData.currentDate = Timestamp.now();
    Constants.userWorkoutPlanData.currentDay = 1;
    List workoutDataList = [];
    int day = 0;
    int week = 0;
    for(int i = 0; i<= Constants.workoutPlanDetail.endDate.toDate().difference(Constants.workoutPlanDetail.startDate.toDate()).inDays; i++){
      UserWorkoutPlanModel workoutData = UserWorkoutPlanModel();
      day++;
      if(i%7 == 0)  week++;
      workoutData.week = week;
      workoutData.day = day;
      workoutData.caloriesBurn = 0;
      workoutData.workout = false;
      if(day%7 == 0)  day = 0;
      workoutDataList.add(workoutData.toMap());
      Constants.userWorkoutData.add(workoutData);
    }
    await _firestore.collection('user_plan_data').doc(Constants.workoutPlanData.id)
        .update({'workout.current_day': Constants.userWorkoutPlanData.currentDay, 'workout.current_date':Constants.userWorkoutPlanData.currentDate,
      'workout.data': workoutDataList});
  }

  /**************************************************
    FUNCTION TO UPDATE USER WORKOUT DATA FOR DAY
   *********************************************////

  static workoutDataUpdates() async{
    DateTime perDate = Constants.userWorkoutPlanData.currentDate.toDate();
    int diff = DateTime.now().day - Constants.userWorkoutPlanData.currentDate.toDate().day;
    diff = (diff.isNegative || diff == 0) ? DateTime.now().difference(perDate).inDays : diff;
    Constants.userWorkoutPlanData.currentDay =
    DateTime.now().difference(perDate).inDays.isNegative ? (Constants.userWorkoutPlanData.currentDay + 1) : (Constants.userWorkoutPlanData.currentDay + diff);
    Constants.userWorkoutPlanData.currentDate = Timestamp.now();
    await _firestore.collection('user_plan_data').doc(Constants.workoutPlanData.id)
        .update({'workout.current_day': Constants.userWorkoutPlanData.currentDay, 'workout.current_date':Constants.userWorkoutPlanData.currentDate});
  }

  /**************************************************
        FUNCTION TO GET USER WORKOUT DATA
   *********************************************////

  static Future<void> getUserWorkoutData() async {
    try {
      if(AuthController.currentUser != null){
        if(AuthController.currentUser.workoutPlanDetail != null){
          print('enter');
          QuerySnapshot snapShot= await _firestore.collection('user_plan_data').where('user_id', isEqualTo: AuthController.currentUser.uid).
          where('workout_plan_id', isEqualTo: AuthController.currentUser.workoutPlanDetail['id']).get();
          print( AuthController.currentUser.uid);
          print(AuthController.currentUser.workoutPlanDetail['id']);
          print(snapShot.docs.isEmpty);
          if(snapShot.docs.isNotEmpty){
            print('enter');
            print(snapShot.docs.isEmpty);
            List userData = snapShot.docs;
            userData.forEach((e) {
              DocumentSnapshot value = e;
              Constants.workoutPlanData = UserDataModel.fromMap(value.data());
              if(AuthController.currentUser.workoutPlanDetail != null){
                if(Constants.workoutPlanData.workoutPlanId == AuthController.currentUser.workoutPlanDetail['id']){
                  if(Constants.workoutPlanData.workout != null){
                    Constants.userWorkoutPlanData.currentDay = Constants.workoutPlanData.workout['current_day'];
                    Constants.userWorkoutPlanData.currentWeek = Constants.workoutPlanData.workout['current_week'];
                    Constants.userWorkoutPlanData.weekDate = Constants.workoutPlanData.workout['week_date'];
                    Constants.userWorkoutPlanData.currentDate = Constants.workoutPlanData.workout['current_date'];
                    Constants.userWorkoutPlanData.data = Constants.workoutPlanData.workout['data'];
                    Constants.userWorkoutPlanData.data.forEach((e) {
                      UserWorkoutPlanModel workoutData = UserWorkoutPlanModel.fromMap(e);
                      Constants.userWorkoutData.add(workoutData);
                    });
                  }
                }
              }
            });
          }
        }
      }
      return;
    } on SocketException catch (error) {
      print("$error");
    } on FirebaseException catch (error) {
      print("$error");
    }
  }

  /**************************************************
      FUNCTION TO GET USER WORKOUT DATA BY ID
   *********************************************////

  static Future getUserWorkoutDataByPlanID(String planId) async {
    try {
      if(AuthController.currentUser != null){
        if(AuthController.currentUser.workoutPlanDetail != null){
          QuerySnapshot snapShot= await _firestore.collection('user_plan_data').where('user_id', isEqualTo: AuthController.currentUser.uid).
          where('workout_plan_id', isEqualTo: planId).get();
          if(snapShot.docs.isNotEmpty){
            UserPlanDataModel userWorkoutPlanData = UserPlanDataModel();
            List<UserWorkoutPlanModel> userWorkoutData = [];
            List userData = snapShot.docs;
            userData.forEach((e) {
              DocumentSnapshot value = e;
              UserDataModel workoutPlanData = UserDataModel.fromMap(value.data());
              if(AuthController.currentUser.workoutPlanDetail != null){
                if(workoutPlanData.workoutPlanId == AuthController.currentUser.workoutPlanDetail['id']){
                  if(workoutPlanData.workout != null){
                    userWorkoutPlanData.currentDay = workoutPlanData.workout['current_day'];
                    userWorkoutPlanData.currentWeek = workoutPlanData.workout['current_week'];
                    userWorkoutPlanData.weekDate = workoutPlanData.workout['week_date'];
                    userWorkoutPlanData.currentDate = workoutPlanData.workout['current_date'];
                    userWorkoutPlanData.data = workoutPlanData.workout['data'];
                    userWorkoutPlanData.data.forEach((e) {
                      UserWorkoutPlanModel workoutData = UserWorkoutPlanModel.fromMap(e);
                      userWorkoutData.add(workoutData);
                    });
                  }
                }
              }
            });
            return [userWorkoutPlanData, userWorkoutData];
          }
        }
      }
      return;
    } on SocketException catch (error) {
      print("$error");
    } on FirebaseException catch (error) {
      print("$error");
    }
  }

  /**************************************************
    FUNCTION TO UPDATE USER WORKOUT DATA FOR WEEK
   *********************************************////

  static Future<void> checkWorkoutWeekPlan() async {
    try {
      print(Constants.workoutPlanData);
      if(Constants.workoutPlanData != null){
        if(Constants.workoutPlanData.workout != null && Constants.workoutPlanDetail != null){
          if(DateTime.now().isBefore(Constants.workoutPlanDetail.endDate.toDate().add(Duration(days: 1))) == true){
            if(Constants.userWorkoutPlanData.currentWeek <= Constants.workoutPlanDetail.duration){
              DateTime nextWeekDate = DateTime(Constants.userWorkoutPlanData.weekDate.toDate().year, Constants.userWorkoutPlanData.weekDate.toDate().month, Constants.userWorkoutPlanData.weekDate.toDate().day);
              DateTime currentDate = DateTime(Constants.userWorkoutPlanData.currentDate.toDate().year, Constants.userWorkoutPlanData.currentDate.toDate().month, Constants.userWorkoutPlanData.currentDate.toDate().day, 0, 0);
              if(Constants.userWorkoutPlanData.currentWeek == 0){
                Constants.userWorkoutPlanData.currentWeek = Constants.userWorkoutPlanData.currentWeek + 1;
                Constants.userWorkoutPlanData.weekDate = Timestamp.fromDate(nextWeekDate.add(Duration(days: 7)));
                await _firestore.collection('user_plan_data').doc(Constants.workoutPlanData.id).update({'workout.week_date': Constants.userWorkoutPlanData.weekDate, 'workout.current_week': Constants.userWorkoutPlanData.currentWeek});
                int diff = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).difference(AuthController.currentUser.workoutPlanDetail['start_date'].toDate()).inDays;
                DateTime endDate = AuthController.currentUser.workoutPlanDetail['end_date'].toDate();
                AuthController.currentUser.workoutPlanDetail['start_date'] = Timestamp.fromDate(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
                AuthController.currentUser.workoutPlanDetail['end_date'] = Timestamp.fromDate(endDate.add(Duration(days: diff)));
                await AuthController().updateUserFields();
              }else{
                if(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).isAfter(nextWeekDate) == true){
                  if(Constants.userWorkoutPlanData.currentWeek == Constants.workoutPlanDetail.duration) Constants.userWorkoutPlanData.currentWeek = Constants.userWorkoutPlanData.currentWeek ;
                  else Constants.userWorkoutPlanData.currentWeek = Constants.userWorkoutPlanData.currentWeek + 1;
                  Constants.userWorkoutPlanData.currentDay = 1;
                  Constants.userWorkoutPlanData.currentDate = Constants.userWorkoutPlanData.weekDate;
                  Constants.userWorkoutPlanData.currentDate =  Timestamp.fromDate(Constants.userWorkoutPlanData.currentDate.toDate().add(Duration(days: 1)));
                  Constants.userWorkoutPlanData.weekDate = Timestamp.fromDate(nextWeekDate.add(Duration(days: 7)));
                  await _firestore.collection('user_plan_data').doc(Constants.workoutPlanData.id).update({'workout.week_date': Constants.userWorkoutPlanData.weekDate, 'workout.current_week': Constants.userWorkoutPlanData.currentWeek});
                }
              }
              if(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).isAfter(currentDate) == true && Constants.userWorkoutPlanData.currentDay != 0){
                await workoutDataUpdates();
              }
              if(Constants.userWorkoutPlanData.currentDay == 0){
                await workoutDataInserts();
              }
            }
          }
        }
      }
      return;
    } on SocketException catch (error) {
      print("$error");
    } on FirebaseException catch (error) {
      print("$error");
    }
  }

  //************************** Supplement Plan Functions **************************

  /**************************************************
      FUNCTION TO GET USER SUPPLEMENTS PLAN DETAIL
   *********************************************////

  static Future<void> getSupplementPlan() async {
    try {
      QuerySnapshot snapShot = await _firestore.collection('users')
          .doc(AuthController.currentUser.uid).collection('supplements').orderBy('day', descending: false).get();
      if(snapShot.docs.isNotEmpty){
        if(Constants.planDetail.supplements == 1) await dbHelper.removeSupplementsPlan();
        final meals = snapShot.docs;
        Future.wait(
            meals.map((e) async{
              SupplementPlanModel supplementPlan = SupplementPlanModel.fromMap(e.data());
              await dbHelper.insertSupplementPlan(supplementPlan);
            })
        );
        await dbHelper.setSupplementPlan();
      }
      return;
    } on SocketException catch (error) {
      print("$error");
    } on FirebaseException catch (error) {
      print("$error");
    }
  }

  //************************** MindfulnessPlan Plan Functions **************************

  /**************************************************
    FUNCTION TO GET USER MINDFULNESS PLAN DETAIL
   *********************************************////

  static Future<void> getMindFullnessPlan() async {
    try {
      QuerySnapshot snapShot = await _firestore.collection('users')
          .doc(AuthController.currentUser.uid).collection('mindfulness').get();
      if(snapShot.docs.isNotEmpty){
        print(Constants.planDetail.mindfulness);
        if(Constants.planDetail.mindfulness == 1) await dbHelper.removeMindFullnessPlan();
        final meals = snapShot.docs;
        Future.wait(
            meals.map((e) async{
              MentalHealthModel mentalHealthPlan = MentalHealthModel.fromMap(e.data());
              await dbHelper.insertMindFullnessPlan(mentalHealthPlan);
            })
        );
        await dbHelper.setMindFullnessPlan();
      }
      return;
    } on SocketException catch (error) {
      print("$error");
    } on FirebaseException catch (error) {
      print("$error");
    }
  }

}