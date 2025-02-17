class UserWorkoutPlanModel {
  bool workout;
  int week;
  int day;
  int caloriesBurn;

  UserWorkoutPlanModel({
    this.workout,
    this.week,
    this.day,
    this.caloriesBurn,
  });

  Map<String, dynamic> toMap() {
    return {
      UserWorkoutPlanModelFields.CALORIES_BURN: this.caloriesBurn,
      UserWorkoutPlanModelFields.WORKOUT: this.workout,
      UserWorkoutPlanModelFields.DAY: this.day,
      UserWorkoutPlanModelFields.WEEK: this.week,
    };
  }

  UserWorkoutPlanModel.fromMap(Map<String, dynamic> map) {
    this.workout = map[UserWorkoutPlanModelFields.WORKOUT];
    this.day = map[UserWorkoutPlanModelFields.DAY];
    this.week = map[UserWorkoutPlanModelFields.WEEK];
    this.caloriesBurn = map[UserWorkoutPlanModelFields.CALORIES_BURN];
  }

  @override
  String toString() {
    return 'UserWorkoutPlanModel{week: $week, cal_burn: $caloriesBurn, workout: $workout, day: $day} ';
  }
}

class UserWorkoutPlanModelFields {
  static const String WORKOUT = "workout";
  static const String DAY = "day";
  static const String WEEK = "week";
  static const String CALORIES_BURN = "cal_burn";
}
