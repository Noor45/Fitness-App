import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:t_fit/models/mental_health_model/mental_health_model.dart';
import 'package:t_fit/models/user_model/qoutes_model.dart';
import 'package:t_fit/models/user_model/user_weight_model.dart';
import 'package:t_fit/models/user_plan_data_model/plans_model.dart';
import 'package:t_fit/models/user_plan_data_model/user_plan_data_model.dart';
import 'package:t_fit/services/user_presence.dart';
import '../controllers/general_controller.dart';
import '../controllers/user_plan_controller.dart';
import '../controllers/blogs_controller.dart';
import '../database/local_storage_function.dart';
import '../models/meal_model/meal_plan_model.dart';
import '../utils/constants.dart';
import '../controllers/auth_controller.dart';
import 'package:recursive_regex/recursive_regex.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
final dbHelper = DatabaseHelper.instance;

  DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }

  DateTime findLastDateOfTheWeek(DateTime dateTime) {
    return dateTime.add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }

  int checkVideoType(String videoLink){
    int videoID = 0;
    if(videoLink.contains('https://vimeo.com')){
      videoID = 1;
    }
    if(videoLink.contains('https://www.youtube')){
      videoID = 2;
    }
    if(videoLink.contains('https://firebasestorage.googleapis')){
      videoID = 3;
    }
    return videoID;
  }

  String getVimeoVideoID (String videoLink) {
  final input = videoLink + '.';
  String videoID = '';
  final regex = RecursiveRegex(
    startDelimiter: RegExp(r'https://vimeo.com/'),
    endDelimiter: RegExp(r'[.]'),
    captureGroupName: 'value',
    caseSensitive: true,
  );
  regex.getMatches(input).forEach((element) {
    String id = element.namedGroup('value');
    if (id.contains('/')) {
      List word = id.split('/');
      videoID = word[0];
    } else {
      videoID = id;
    }
  });
  return videoID;
}

  String getYoutubeVideoID (String url) {
    final regex = RegExp(r'.*\?v=(.+?)($|[\&])', caseSensitive: false);
    String videoID = '';
    if (regex.hasMatch(url)) {
      return  videoID  = regex.firstMatch(url).group(1);
    }
    return videoID;
  }

  getWeeksForRange(DateTime start, DateTime end) {
    var date = DateTime.now();
    var totalDays = end.difference(start).inDays;
    var totalWeeks = (totalDays/7).floor();
    int currentDay = end.difference(date).inDays;
    int dayNumber = totalDays - currentDay;
    int weekNumber = (dayNumber/totalWeeks).floor();
    return [dayNumber, weekNumber];
  }



  clearData() {
    Constants.update = false;
    Constants.planMealAssign = false;
    Constants.planWorkoutAssign = false;
    Constants.planSupplementAssign = false;
    Constants.path = '';
    Constants.pdfID = '';
    Constants.pdfPath = '';
    Constants.dayProgressValue = 100.0;
    Constants.todayMealDetail = MealPlanModel();
    Constants.qoutes = Qoutes();
    Constants.mealPlanDetail = null;
    Constants.workoutPlanDetail = null;
    Constants.supplementPlanDetail = null;
    Constants.userMealList = [];
    Constants.userWorkoutsList = [];
    Constants.workoutDetailList = [];
    Constants.userWeeklyMealList = [];
    Constants.mealDetailList = [];
    Constants.parQList  = [];
    Constants.blogList  = [];
    Constants.journalList = [];
    Constants.userSupplementsList = [];
    Constants.userWeeklyWorkoutsList = [];
    Constants.userWeeklySupplementsList = [];
    Constants.userWorkoutData  = [];
    Constants.totalUserWorkoutData = 0;
    Constants.totalWorkoutData = 0;
    Constants.totalMealData = 0;
    Constants.totalUserMealData = 0;
    Constants.notificationVisibility = false;
    VideoTools.workoutStart = false;
    VideoTools.workoutIndex = 0;
    Constants.mealProgressValue = 0;
    Constants.workoutProgressValue = 0;
    Constants.fullScreen = false;
    Constants.userWeightList  = [];
    Constants.dailyWeight  = UserWeightModel();
    Constants.mentalHealthBlog = MentalHealthModel();
    Constants.userMealPlanData = UserPlanDataModel();
    Constants.userWorkoutPlanData = UserPlanDataModel();
    Constants.planDetail = PlanAssignModel();
    Constants.mentalHealthBlogList  = [];
    Constants.userMealData = [];

    VideoTools.duration = 10;
    VideoTools.countController = CountDownController();
    VideoTools.videoShow = false;
    VideoTools.timerShow = false;
    VideoTools.workoutStart = false;
    VideoTools.setNo = 1;
  }

  // saveCurrentDateLocally(int day, int month, int year) async{
  //   await LocalPreferences.preferences.setInt(LocalPreferences.currentDay, day);
  //   await LocalPreferences.preferences.setInt(LocalPreferences.currentMonth, month);
  //   await LocalPreferences.preferences.setInt(LocalPreferences.currentYear, year);
  // }

  Future getUserData() async {
    await AuthController.getUserInfo(_auth.currentUser.uid);
    await DietPlanController.getUserMealData();
    await DietPlanController.getUserWorkoutData();
    await dbHelper.selectPlanDetail();
    if(AuthController.currentUser.mealPlanDetail != null){
      if(Constants.planDetail.meal == 0) await DietPlanController.getMealPlan();
      await dbHelper.selectMealPlan();
    }
    if(AuthController.currentUser.workoutPlanDetail != null){
      if(Constants.planDetail.workout == 0) await DietPlanController.getWorkoutPlan();
      await dbHelper.selectWorkoutPlan();
    }
    if(AuthController.currentUser.supplementPlanDetail != null){
      if(Constants.planDetail.supplements == 0) await DietPlanController.getSupplementPlan();
      await dbHelper.selectSupplementPlan();
    }
    if(AuthController.currentUser.mentalHealth == true){
      if(Constants.planDetail.mindfulness == 0) await DietPlanController.getMindFullnessPlan();
      await dbHelper.selectMindFullnessPlan();
    }
    if(Constants.planDetail.weight == 0) await GeneralController.getUserWeight();
    await dbHelper.selectMindFullnessPlan();
    GeneralController.getDailyWeight();
    await DietPlanController.checkMealWeekPlan();
    await DietPlanController.checkWorkoutWeekPlan();
    await dbHelper.selectPlanDetail();
    DietPlanController.todayMealPlan();

  }

  Future updatePlan(bool update) async{
    if(update == true){
      await DietPlanController.getMealPlan();
      await DietPlanController.getWorkoutPlan();
      await DietPlanController.getSupplementPlan();
      await DietPlanController.getMindFullnessPlan();
      AuthController.currentUser.updatePlan = false;
      await AuthController().updatePlan(false);
      await dbHelper.selectMealPlan();
      await dbHelper.selectWorkoutPlan();
      await dbHelper.selectSupplementPlan();
      await dbHelper.selectMindFullnessPlan();
      await dbHelper.selectPlanDetail();
      DietPlanController.todayMealPlan();
    }
  }

  Future getAppData() async {
    await GeneralController.getQoutes();
    await GeneralController.getPARQ();
    await BlogsController.getBlogs();
    if(AuthController.currentUser != null) UserPresence().connectToServer();
  }
