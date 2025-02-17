import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  int age;
  var hire;
  String uid;
  String name;
  String email;
  String fcm;
  String gender;
  double neck;
  double waist;
  double hips;
  double bmi;
  double bfp;
  List parq;
  var weight;
  var height;
  List reports;
  bool updatePlan;
  bool mentalHealth;
  String allergies;
  int selectedGoal;
  String activity;
  var macroNutrients;
  int accountStatus;
  List instructors;
  Timestamp createdAt;
  String profileImageUrl;
  var mealPlanDetail;
  var workoutPlanDetail;
  var supplementPlanDetail;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.activity,
    this.bmi,
    this.gender,
    this.age,
    this.parq,
    this.bfp,
    this.weight,
    this.hire,
    this.neck,
    this.waist,
    this.hips,
    this.fcm,
    this.createdAt,
    this.updatePlan,
    this.height,
    this.mentalHealth,
    this.reports,
    this.allergies,
    this.instructors,
    this.selectedGoal,
    this.accountStatus,
    this.macroNutrients,
    this.mealPlanDetail,
    this.profileImageUrl,
    this.workoutPlanDetail,
    this.supplementPlanDetail,
  });

  Map<String, dynamic> toMap() {
    return {
      UserModelFields.UID: this.uid,
      UserModelFields.NAME: this.name,
      UserModelFields.EMAIL: this.email,
      UserModelFields.AGE: this.age,
      UserModelFields.PARQ: this.parq,
      UserModelFields.GENDER: this.gender,
      UserModelFields.WEIGHT: this.weight,
      UserModelFields.FCM: this.fcm,
      UserModelFields.ACTIVITY: this.activity,
      UserModelFields.PROFILE_IMAGE_URL: this.profileImageUrl,
      UserModelFields.HEIGHT: this.height,
      UserModelFields.REPORTS: this.reports,
      UserModelFields.BMI: this.bmi,
      UserModelFields.SELECTED_GOAL: this.selectedGoal,
      UserModelFields.ALLERGIES: this.allergies,
      UserModelFields.CREATED_AT: this.createdAt,
      UserModelFields.NECK: this.neck,
      UserModelFields.WAIST: this.waist,
      UserModelFields.HIPS: this.hips,
      UserModelFields.HIRE: this.hire,
      UserModelFields.MENTAL_HEALTH: this.mentalHealth,
      UserModelFields.UPDATE_PLAN: this.updatePlan,
      UserModelFields.BFP: this.bfp,
      UserModelFields.INSTRUCTORS: this.instructors,
      UserModelFields.MACRO_NUTRIENTS: this.macroNutrients,
      UserModelFields.ACCOUNT_STATUS: this.accountStatus,
      UserModelFields.MEAL_PLAN_DETAIL: this.mealPlanDetail,
      UserModelFields.WORKOUT_PLAN_DETAIL: this.workoutPlanDetail,
      UserModelFields.SUPPLEMENT_PLAN_DETAIL: this.supplementPlanDetail,
    };
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    this.uid = map[UserModelFields.UID];
    this.name = map[UserModelFields.NAME];
    this.email = map[UserModelFields.EMAIL];
    this.gender = map[UserModelFields.GENDER];
    this.age = map[UserModelFields.AGE];
    this.parq = map[UserModelFields.PARQ];
    this.weight = map[UserModelFields.WEIGHT];
    this.bmi = map[UserModelFields.BMI];
    this.selectedGoal = map[UserModelFields.SELECTED_GOAL];
    this.createdAt = map[UserModelFields.CREATED_AT];
    this.profileImageUrl = map[UserModelFields.PROFILE_IMAGE_URL];
    this.height = map[UserModelFields.HEIGHT];
    this.activity = map[UserModelFields.ACTIVITY];
    this.allergies = map[UserModelFields.ALLERGIES];
    this.neck = map[UserModelFields.NECK];
    this.waist = map[UserModelFields.WAIST];
    this.hips = map[UserModelFields.HIPS];
    this.bfp = map[UserModelFields.BFP];
    this.fcm = map[UserModelFields.FCM];
    this.macroNutrients = map[UserModelFields.MACRO_NUTRIENTS];
    this.accountStatus = map[UserModelFields.ACCOUNT_STATUS];
    this.reports = map[UserModelFields.REPORTS];
    this.updatePlan = map[UserModelFields.UPDATE_PLAN];
    this.mealPlanDetail = map[UserModelFields.MEAL_PLAN_DETAIL];
    this.workoutPlanDetail = map[UserModelFields.WORKOUT_PLAN_DETAIL];
    this.supplementPlanDetail = map[UserModelFields.SUPPLEMENT_PLAN_DETAIL];
    this.hire = map[UserModelFields.HIRE];
    this.mentalHealth = map[UserModelFields.MENTAL_HEALTH];
    this.instructors = map[UserModelFields.INSTRUCTORS];
  }

  @override
  String toString() {
    return 'UserModel{uid: $uid, name: $name, email: $email, gender: $gender, activity: $activity, '
        'profileImageUrl: $profileImageUrl, age: $age, weight: $weight, height: $height, goal: $selectedGoal, allergies: $allergies, reports: $reports '
        'createdAt: $createdAt, account_status: $accountStatus, instructors: $instructors, hire: $hire, par_q: $parq, bmi: $bmi, waist_value: $waist, '
        'hip_value: $hips, mental_health: $mentalHealth, neck_value: $neck, macro_nutrients: $macroNutrients, bfp: $bfp, meal_plan_detail: $mealPlanDetail, fcm: $fcm, '
        'workout_plan_detail: $workoutPlanDetail, supplement_plan_detail: $supplementPlanDetail, update_plan: $updatePlan,} ';
  }
}

class UserModelFields {
  static const String UID = "uid";
  static const String NAME = "name";
  static const String EMAIL = "email";
  static const String GENDER = "gender";
  static const String AGE = "age";
  static const String WEIGHT = "weight";
  static const String CREATED_AT = "created_at";
  static const String PROFILE_IMAGE_URL = "profile_image_url";
  static const String HEIGHT = "height";
  static const String BMI = "bmi";
  static const String PARQ = "par_q";
  static const String ALLERGIES = "allergies";
  static const String SELECTED_GOAL = "goal";
  static const String NECK = "neck_value";
  static const String FCM = "fcm";
  static const String WAIST = "waist_value";
  static const String HIPS = "hip_value";
  static const String BFP = "bfp";
  static const String ACTIVITY = "activity";
  static const String MACRO_NUTRIENTS = "macro_nutrients";
  static const String ACCOUNT_STATUS = "account_status";
  static const String REPORTS = "reports";
  static const String MEAL_PLAN_DETAIL = "meal_plan_detail";
  static const String WORKOUT_PLAN_DETAIL = "workout_plan_detail";
  static const String SUPPLEMENT_PLAN_DETAIL = "supplement_plan_detail";
  static const String INSTRUCTORS = "instructors";
  static const String HIRE = "hire";
  static const String MENTAL_HEALTH = "mental_health";
  static const String UPDATE_PLAN = "update_plan";
}
