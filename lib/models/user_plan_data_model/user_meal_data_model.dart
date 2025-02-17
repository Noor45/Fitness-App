class UserMealDataModel {
  List mealData;
  int week;
  int day;
  int extraCalories;
  int caloriesTaken;


  UserMealDataModel({
    this.mealData,
    this.week,
    this.day,
    this.extraCalories,
    this.caloriesTaken,
  });

  Map<String, dynamic> toMap() {
    return {
      UserMealDataModelFields.CALORIES_TAKEN: this.caloriesTaken,
      UserMealDataModelFields.MEAL_DATA: this.mealData,
      UserMealDataModelFields.DAY: this.day,
      UserMealDataModelFields.WEEK: this.week,
      UserMealDataModelFields.EXTRA_CALORIES: this.extraCalories,
    };
  }

  UserMealDataModel.fromMap(Map<String, dynamic> map) {
    this.mealData = map[UserMealDataModelFields.MEAL_DATA];
    this.day = map[UserMealDataModelFields.DAY];
    this.week = map[UserMealDataModelFields.WEEK];
    this.caloriesTaken = map[UserMealDataModelFields.CALORIES_TAKEN];
    this.extraCalories = map[UserMealDataModelFields.EXTRA_CALORIES];
  }

  @override
  String toString() {
    return 'UserMealDataModel{week: $week, cal_taken: $caloriesTaken, extra_cal: $extraCalories, meal: $mealData, day: $day,} ';
  }
}

class UserMealDataModelFields {
  static const String MEAL_DATA = "meal";
  static const String DAY = "day";
  static const String WEEK = "week";
  static const String CALORIES_TAKEN = "cal_taken";
  static const String EXTRA_CALORIES = "extra_cal";
}
