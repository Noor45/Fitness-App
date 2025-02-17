class WorkoutPlanModel {
  int category;
  int caloriesBurn;
  List workouts;
  int week;
  int day;
  String id;
  String planId;
  String title;

  WorkoutPlanModel({
    this.category,
    this.caloriesBurn,
    this.workouts,
    this.week,
    this.title,
    this.id,
    this.planId,
  });

  Map<String, dynamic> toMap() {
    return {
      WorkoutPlanModelFields.ID: this.id,
      WorkoutPlanModelFields.CATEGORY: this.category,
      WorkoutPlanModelFields.WORKOUTS: this.workouts,
      WorkoutPlanModelFields.DAY: this.day,
      WorkoutPlanModelFields.WEEK: this.week,
      WorkoutPlanModelFields.TITLE: this.title,
      WorkoutPlanModelFields.PLAN_ID: this.planId,
      WorkoutPlanModelFields.CALORIES_BURN: this.caloriesBurn,
    };
  }

  WorkoutPlanModel.fromMap(Map<String, dynamic> map) {
    this.category = map[WorkoutPlanModelFields.CATEGORY];
    this.workouts = map[WorkoutPlanModelFields.WORKOUTS];
    this.day = map[WorkoutPlanModelFields.DAY];
    this.week = map[WorkoutPlanModelFields.WEEK];
    this.title =  map[WorkoutPlanModelFields.TITLE];
    this.id = map[WorkoutPlanModelFields.ID];
    this.planId = map[WorkoutPlanModelFields.PLAN_ID];
    this.caloriesBurn = map[WorkoutPlanModelFields.CALORIES_BURN];
  }

  @override
  String toString() {
    return 'WorkoutPlanModel{category: $category, week: $week, title: $title, workout_exercises: $workouts, id: $id, day: $day, calories_burn: $caloriesBurn, plan_id: $planId} ';
  }
}

class WorkoutPlanModelFields {
  static const String ID = "id";
  static const String CATEGORY = "category";
  static const String WORKOUTS = "workout_exercises";
  static const String DAY = "day";
  static const String WEEK = "week";
  static const String TITLE = "title";
  static const String PLAN_ID = "plan_id";
  static const String CALORIES_BURN = "calories_burn";
}
