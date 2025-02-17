import 'dart:convert';
import 'dart:io' show Directory;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;
import 'package:t_fit/controllers/auth_controller.dart';
import 'package:t_fit/models/mental_health_model/mental_health_model.dart';
import 'package:t_fit/models/user_model/diary_model.dart';
import 'package:t_fit/models/user_model/user_weight_model.dart';
import '../models/meal_model/meal_plan_model.dart';
import '../models/supplement_model/supplement_model.dart';
import '../models/workout_model/workout_model.dart';
import '../utils/constants.dart';
import 'package:intl/intl.dart';

class DatabaseHelper {
  static final _databaseName = "t-fit.db";
  static final _databaseVersion = 1;
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: onCreate
      );
  }

   Future onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE meal (id TEXT, user_id TEXT, plan_id TEXT, calories_level TEXT, day INTEGER, week INTEGER, meals_in_each_day INTEGER, meals TEXT, total_calories INTEGER)');
    await db.execute('CREATE TABLE supplements (id TEXT, user_id TEXT, plan_id TEXT, name TEXT, day INTEGER, week INTEGER, use TEXT, detail TEXT)');
    await db.execute('CREATE TABLE workouts (id TEXT, user_id TEXT, plan_id TEXT, title TEXT, workout_exercises TEXT, day INTEGER, week INTEGER, category INTEGER, calories_burn INTEGER)');
    await db.execute('CREATE TABLE plans (user_id TEXT PRIMARY KEY, meal INTEGER, workouts INTEGER, supplements INTEGER, mindfulness INTEGER, weight INTEGER)');
    await db.execute('CREATE TABLE downloadPath (UniqueId TEXT PRIMARY KEY, LocalPath TEXT)');
    await db.execute('CREATE TABLE user_weight_data (id TEXT PRIMARY KEY, uid TEXT, note TEXT, key TEXT, weight INTEGER, date TEXT)');
    await db.execute('CREATE TABLE diary (id TEXT PRIMARY KEY, uid TEXT, title TEXT, text TEXT, created_at TEXT)');
    await db.execute('CREATE TABLE mindfulness (id TEXT PRIMARY KEY, user_id TEXT, title TEXT, description TEXT, type INTEGER, file_url TEXT, exercise TEXT, tags TEXT)');
    await db.execute('CREATE TABLE localNotificationTime (uid TEXT, meal_one TEXT, meal_two TEXT, meal_three TEXT, meal_four TEXT, meal_five TEXT, meal_six TEXT, workout TEXT, alarm TEXT)');
  }

  //****************** Meal Plan Functions ******************

  Future setMealPlan() async {
    try{
      Database db = await instance.database;
      await db.rawUpdate('UPDATE plans SET meal = ? WHERE user_id = ?', [1, AuthController.currentUser.uid]);
      Constants.planDetail.meal= 1;
    }catch(e){
      print(e);
    }
  }

  Future removeMealPlan() async {
    try{
      Database db = await instance.database;
      await db.rawDelete('DELETE FROM meal WHERE user_id = ?', [AuthController.currentUser.uid]);
    }catch(e){
      print(e);
    }
  }

  Future selectMealPlan() async {
    try{
      if(Constants.mealPlanDetail != null){
        Database db = await DatabaseHelper.instance.database;
        await db.rawQuery('SELECT * FROM meal where user_id = "'+AuthController.currentUser.uid+'" AND plan_id = "'+Constants.mealPlanDetail.id+'"  ORDER BY day ASC').then((value) {
          Constants.userMealList = [];
          for (var meal in value) {
            List mealData = json.decode(meal['meals']);
            MealPlanModel mealPlan = MealPlanModel();
            mealPlan.day = meal['day'];
            mealPlan.week = meal['week'];
            mealPlan.id = meal['id'];
            mealPlan.mealsInEachDay = meal['meals_in_each_day'];
            mealPlan.caloriesLevel = json.decode(meal['calories_level']);
            mealPlan.meals = mealData;
            mealPlan.totalDayCalories = meal['total_calories'];
            Constants.userMealList.add(mealPlan);
          }
        });
      }
    }catch(e){
      print(e);
    }
  }

  Future insertMealPlan(MealPlanModel mealData) async {
    try{
      print('meal');
      Database db = await instance.database;
      await  db.rawInsert('INSERT INTO meal(id, user_id, plan_id, day, week, meals_in_each_day, meals, calories_level, total_calories) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)',
          [mealData.id, AuthController.currentUser.uid, mealData.planId, mealData.day, mealData.week, mealData.mealsInEachDay, json.encode(mealData.meals), json.encode(mealData.caloriesLevel), mealData.totalDayCalories]);
    }catch(e){
      print(e);
    }
  }

  Future<List> selectMealPlanByID(String planId) async {
    List<MealPlanModel> userMealList = [];
    Database db = await DatabaseHelper.instance.database;
    await db.rawQuery('SELECT * FROM meal where user_id = "'+AuthController.currentUser.uid+'" AND plan_id = "'+planId+'"  ORDER BY day ASC').then((value) {
      for (var meal in value) {
        List mealData = json.decode(meal['meals']);
        MealPlanModel mealPlan = MealPlanModel();
        mealPlan.day = meal['day'];
        mealPlan.week = meal['week'];
        mealPlan.id = meal['id'];
        mealPlan.mealsInEachDay = meal['meals_in_each_day'];
        mealPlan.caloriesLevel = json.decode(meal['calories_level']);
        mealPlan.meals = mealData;
        mealPlan.totalDayCalories = meal['total_calories'];
        userMealList.add(mealPlan);
      }
    }).onError((error, stackTrace) => null);
    return userMealList;
  }

  //****************** Workout Plan Functions ******************

  Future setWorkoutPlan() async {
    try{
      Database db = await instance.database;
      await db.rawUpdate('UPDATE plans SET workouts = ? WHERE user_id = ?', [1, AuthController.currentUser.uid]);
      Constants.planDetail.workout = 1;
    }catch(e){
      print(e);
    }
  }

  Future removeWorkoutPlan() async {
    try{
      Database db = await instance.database;
      await db.rawDelete('DELETE FROM workouts WHERE user_id = ?', [AuthController.currentUser.uid]);
    }catch(e){
      print(e);
    }
  }

  Future selectWorkoutPlan() async {
    try{
      if(Constants.workoutPlanDetail != null){
        Database db = await DatabaseHelper.instance.database;
        await db.rawQuery('SELECT * FROM workouts where user_id = "'+AuthController.currentUser.uid+'" AND plan_id = "'+Constants.workoutPlanDetail.id+'" ORDER BY day ASC').then((value) {
          Constants.userWorkoutsList = [];
          for (var workout in value) {
            WorkoutPlanModel workoutPlan = WorkoutPlanModel();
            workoutPlan.day = workout['day'];
            workoutPlan.week = workout['week'];
            workoutPlan.id = workout['id'];
            workoutPlan.title = workout['title'];
            workoutPlan.workouts = json.decode(workout['workout_exercises']);
            workoutPlan.category = workout['category'];
            workoutPlan.caloriesBurn = workout['calories_burn'];
            Constants.userWorkoutsList.add(workoutPlan);
          }
        });
      }
    }catch(e){
      print(e);
    }
  }

  Future selectWorkoutPlanById(String planId) async {
    List<WorkoutPlanModel> userWorkoutsList = [];
    Database db = await DatabaseHelper.instance.database;
    await db.rawQuery('SELECT * FROM workouts where user_id = "'+AuthController.currentUser.uid+'" AND plan_id = "'+planId+'" ORDER BY day ASC').then((value) {
      for (var workout in value) {
        WorkoutPlanModel workoutPlan = WorkoutPlanModel();
        workoutPlan.day = workout['day'];
        workoutPlan.week = workout['week'];
        workoutPlan.id = workout['id'];
        workoutPlan.title = workout['title'];
        workoutPlan.workouts = json.decode(workout['workout_exercises']);
        workoutPlan.category = workout['category'];
        workoutPlan.caloriesBurn = workout['calories_burn'];
        userWorkoutsList.add(workoutPlan);
      }
    }).onError((error, stackTrace) => null);
    return userWorkoutsList;
  }

  Future insertWorkoutPlan(WorkoutPlanModel workoutData) async {
    try{
      print('workout');
      Database db = await instance.database;
      await  db.rawInsert('INSERT INTO workouts(id, user_id, plan_id, day, week, title, category, calories_burn, workout_exercises) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)',
          [workoutData.id, AuthController.currentUser.uid, workoutData.planId, workoutData.day, workoutData.week, workoutData.title, workoutData.category, workoutData.caloriesBurn, json.encode(workoutData.workouts)]);
    }catch(e){
      print(e);
    }
  }

  //****************** Supplement Plan Functions ******************

  Future setSupplementPlan() async {
    try{
      Database db = await instance.database;
      await db.rawUpdate('UPDATE plans SET supplements = ? WHERE user_id = ?', [1, AuthController.currentUser.uid]);
      Constants.planDetail.supplements = 1;
    }catch(e){
      print(e);
    }
  }

  Future removeSupplementsPlan() async {
    try{
      Database db = await instance.database;
      await db.rawDelete('DELETE FROM supplements WHERE user_id = ?', [AuthController.currentUser.uid]);
    }catch(e){
      print(e);
    }
  }

  Future selectSupplementPlan() async {
    try{
      if(Constants.supplementPlanDetail != null){
        Database db = await DatabaseHelper.instance.database;
        await db.rawQuery('SELECT * FROM supplements where user_id = "'+AuthController.currentUser.uid+'" AND plan_id = "'+Constants.supplementPlanDetail.id+'"  ORDER BY day ASC').then((value) {
          Constants.userSupplementsList = [];
          for (var supplement in value) {
            SupplementPlanModel supplementPlan = SupplementPlanModel();
            supplementPlan.day = supplement['day'];
            supplementPlan.week = supplement['week'];
            supplementPlan.id = supplement['id'];
            supplementPlan.name = supplement['name'];
            supplementPlan.use = json.decode(supplement['use']);
            supplementPlan.detail = json.decode(supplement['detail']);
            Constants.userSupplementsList.add(supplementPlan);
          }
        });
      }
    }catch(e){
      print(e);
    }
  }

  Future insertSupplementPlan(SupplementPlanModel supplementData) async {
    try{
      print('supplement');
      Database db = await DatabaseHelper.instance.database;
      await  db.rawInsert('INSERT INTO supplements(id, user_id, plan_id, day, week, name, use, detail) VALUES(?, ?, ?, ?, ?, ?, ?, ?)',
          [supplementData.id, AuthController.currentUser.uid, supplementData.planId, supplementData.day, supplementData.week, supplementData.name, json.encode(supplementData.use), json.encode(supplementData.detail)]);
    }catch(e){
      print(e);
    }
  }

  //****************** Mindfulness Plan Functions ******************

  Future setMindFullnessPlan() async {
    try{
      Database db = await instance.database;
      await db.rawUpdate('UPDATE plans SET mindfulness = ? WHERE user_id = ?', [1, AuthController.currentUser.uid]);
      Constants.planDetail.mindfulness = 1;
    }catch(e){
      print(e);
    }
  }

  Future selectMindFullnessPlan() async {
    try{
      if(AuthController.currentUser.mentalHealth == true){
        Database db = await DatabaseHelper.instance.database;
        await db.rawQuery('SELECT * FROM mindfulness where user_id = "'+AuthController.currentUser.uid+'"').then((value) {
          Constants.mentalHealthBlogList = [];
          for (var mindFullness in value) {
            MentalHealthModel mindFullnessPlan = MentalHealthModel();
            mindFullnessPlan.description = mindFullness['description'];
            mindFullnessPlan.fileUrl = mindFullness['file_url'];
            mindFullnessPlan.id = mindFullness['id'];
            mindFullnessPlan.exercise = json.decode(mindFullness['exercise']);
            mindFullnessPlan.tags = json.decode(mindFullness['tags']);
            mindFullnessPlan.title = mindFullness['title'];
            mindFullnessPlan.type = mindFullness['type'];
            mindFullnessPlan.uid = mindFullness['user_id'];
            Constants.mentalHealthBlogList.add(mindFullnessPlan);
          }
        });
      }
    }catch(e){
      print(e);
    }
  }

  Future removeMindFullnessPlan() async {
    try{
      Database db = await instance.database;
      await db.rawDelete('DELETE FROM mindfulness WHERE user_id = ?', [AuthController.currentUser.uid]);
    }catch(e){
      print(e);
    }
  }

  Future insertMindFullnessPlan(MentalHealthModel mentalHealthModel) async {
    try{
      print('mindfulness');
      Database db = await DatabaseHelper.instance.database;
      await  db.rawInsert('INSERT INTO mindfulness(id, user_id, title, description, type, file_url, exercise, tags) VALUES(?, ?, ?, ?, ?, ?, ?, ?)',
          [mentalHealthModel.id, AuthController.currentUser.uid, mentalHealthModel.title, mentalHealthModel.description, mentalHealthModel.type, mentalHealthModel.fileUrl, json.encode(mentalHealthModel.exercise), json.encode(mentalHealthModel.tags)]);
    }catch(e){
      print(e);
    }
  }

  //****************** Weight Plan Functions ******************

  Future setWeightPlan() async {
    try{
      Database db = await instance.database;
      await db.rawUpdate('UPDATE plans SET weight = ? WHERE user_id = ?', [1, AuthController.currentUser.uid]);
      Constants.planDetail.weight = 1;
    }catch(e){
      print(e);
    }
  }

  Future removeWeight() async {
    try{
      Database db = await instance.database;
      await db.rawDelete('DELETE FROM user_weight_data WHERE uid = ?', [AuthController.currentUser.uid]);
    }catch(e){
      print(e);
    }
  }

  Future selectWeightDetail() async {
    try{
        Database db = await DatabaseHelper.instance.database;
        await db.rawQuery('SELECT * FROM user_weight_data where uid = "'+AuthController.currentUser.uid+'"').then((value) {
          Constants.userWeightList = [];
          for (var weightDetail in value) {
            UserWeightModel userWeightPlan = UserWeightModel();
            userWeightPlan.date = Timestamp.fromDate(DateTime.parse(weightDetail['date']));
            userWeightPlan.weight = double.parse(weightDetail['weight'].toString());
            userWeightPlan.key = weightDetail['key'];
            userWeightPlan.note = weightDetail['note'];
            userWeightPlan.id = weightDetail['id'];
            userWeightPlan.uid = weightDetail['uid'];
            Constants.userWeightList.add(userWeightPlan);
          }
        });
        print(Constants.userWeightList);
    }catch(e){
      print(e);
    }
  }

  Future insertWeightData(UserWeightModel weightData) async {
    try{
      Database db = await DatabaseHelper.instance.database;
      await  db.rawInsert('INSERT INTO user_weight_data(id, uid, note, key, weight, date) VALUES(?, ?, ?, ?, ?, ?)',
          [weightData.id, AuthController.currentUser.uid, weightData.note, weightData.key, weightData.weight, weightData.date.toDate().toString()]);
    }catch(e){
      print(e);
    }
  }
  //****************** Notifications Functions ******************

  Future getNotificationTime() async {
    try{
      Database db = await DatabaseHelper.instance.database;
      await db.rawQuery('SELECT * FROM localNotificationTime where uid = "'+AuthController.currentUser.uid+'"').then((value) {
        if(value.isEmpty){
          DatabaseHelper.instance.insertLocalNotificationTime();
        }else{
          for (var mindFullness in value) {
            Constants.notificationTime.workout = mindFullness['workout'];
            Constants.notificationTime.mealOne = mindFullness['meal_one'];
            Constants.notificationTime.mealTwo = mindFullness['meal_two'];
            Constants.notificationTime.mealThree = mindFullness['meal_three'];
            Constants.notificationTime.mealFour = mindFullness['meal_four'];
            Constants.notificationTime.mealFive = mindFullness['meal_five'];
            Constants.notificationTime.mealSix = mindFullness['meal_six'];
            Constants.notificationTime.alarm = mindFullness['alarm'];
          }
        }
      });
    }catch(e){
      print(e);
    }
  }

  Future insertLocalNotificationTime() async{
    try{
      Database db = await instance.database;
      await  db.rawInsert('INSERT INTO localNotificationTime(uid, meal_one, meal_two, meal_three, meal_four, meal_five, meal_six, workout, alarm) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)',
          [AuthController.currentUser.uid, '', '', '', '', '', '', '', '']);
      await DatabaseHelper.instance.getNotificationTime();
    }catch(e){
      print(e);
    }
  }

  Future saveNotificationTime(String field, String time) async {
    try{
      Database db = await instance.database;
      await db.rawUpdate('UPDATE localNotificationTime SET $field = ? WHERE uid = ?', [time, AuthController.currentUser.uid]);
      await DatabaseHelper.instance.getNotificationTime();
    }catch(e){
      print(e);
    }
  }

  //****************** Journals Functions ******************

  Future getJournals() async {
    try{
      Database db = await DatabaseHelper.instance.database;
      await db.rawQuery('SELECT * FROM diary where uid = "'+AuthController.currentUser.uid+'" ORDER BY created_at ASC').then((value) {
        Constants.journalList = [];
        for (var detail in value) {
          DiaryModel journal = DiaryModel();
          DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(detail['created_at']);
          journal.uid = detail['uid'];
          journal.id = detail['id'];
          journal.title = detail['title'];
          journal.text = detail['text'];
          journal.createdAt = Timestamp.fromDate(tempDate);
          Constants.journalList.add(journal);
        }
      });
    }catch(e){
      print(e);
    }
  }

  Future saveJournal(DiaryModel journal) async{
    try{
      Database db = await instance.database;
      await  db.rawInsert('INSERT INTO diary(id, uid, title, text, created_at) VALUES(?, ?, ?, ?, ?)',
          [journal.id, journal.uid, journal.title, journal.text, journal.createdAt.toDate().toString()]);
    }catch(e){
      print(e);
    }
  }

  Future updateJournal(DiaryModel journal) async {
    try{
      Database db = await instance.database;
      await db.rawUpdate('UPDATE diary SET title = ?, text = ? WHERE uid = ?', [journal.title, journal.text, journal.uid]);
    }catch(e){
      print(e);
    }
  }

  //****************** Select Plans Function ******************

  Future selectPlanDetail() async {
    try{
      Database db = await DatabaseHelper.instance.database;
      var details = await db.rawQuery('SELECT * FROM plans where user_id = "'+AuthController.currentUser.uid+'"');
      if(details.isNotEmpty){
        for (var detail in details) {
          Constants.planDetail.meal = detail['meal'];
          Constants.planDetail.workout = detail['workouts'];
          Constants.planDetail.supplements = detail['supplements'];
          Constants.planDetail.mindfulness = detail['mindfulness'];
          Constants.planDetail.weight = detail['weight'];
          Constants.planDetail.userId = detail['user_id'];
        }
      }else{
        await db.rawInsert('INSERT INTO plans(user_id, meal, workouts, mindfulness, supplements, weight) VALUES(?, ?, ?, ?, ?, ?)', [AuthController.currentUser.uid, 0, 0, 0, 0, 0]);
        var details = await db.rawQuery('SELECT * FROM plans where user_id = "'+AuthController.currentUser.uid+'"');
        for (var detail in details) {
          Constants.planDetail.meal = detail['meal'];
          Constants.planDetail.workout = detail['workouts'];
          Constants.planDetail.supplements = detail['supplements'];
          Constants.planDetail.mindfulness = detail['mindfulness'];
          Constants.planDetail.weight = detail['weight'];
          Constants.planDetail.userId = detail['user_id'];
        }
      }
    }catch(e){
      print(e);
    }
  }

  //****************** save path Functions ******************

  Future<int> insertPath(String path, String uid) async {
    try{
    Database db = await database;
    int id = await db.insert('downloadPath', {"UniqueId": uid, "LocalPath": path});
    return id;
    }catch(e){
      print(e);
    }
  }

  Future deletePathFromDb(String uid) async {
    try{
      Database db = await database;
      await db.delete('downloadPath', where: "UniqueId = ?", whereArgs: [uid]);
    }catch(e){
      print(e);
    }
  }

  Future<List<Map<String, dynamic>>> queryPath(String uid) async {
    try{
      Database db = await database;
      List<Map<String, dynamic>> list =
      await db.query('downloadPath', where: "UniqueId = ?", whereArgs: [uid]);
      return list;
    }catch(e){
      print(e);
    }
  }

  //****************** delete Table Function ******************

  Future removeTable() async {
    try{
      Database db = await instance.database;
      await db.rawDelete('DELETE FROM workouts WHERE user_id = ?', [AuthController.currentUser.uid]);
      await db.rawDelete('DELETE FROM meal WHERE user_id = ?', [AuthController.currentUser.uid]);
      await db.rawDelete('DELETE FROM supplements WHERE user_id = ?', [AuthController.currentUser.uid]);
      await db.rawDelete('DELETE FROM mindfulness WHERE user_id = ?', [AuthController.currentUser.uid]);
    }catch(e){
      print(e);
    }
  }






}