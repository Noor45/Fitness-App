class MealPlanModel {
  var caloriesLevel;
  List meals;
  int week;
  int day;
  String id;
  String planId;
  int mealsInEachDay;
  int totalDayCalories;


  MealPlanModel({
    this.caloriesLevel,
    this.meals,
    this.week,
    this.mealsInEachDay,
    this.day,
    this.id,
    this.planId,
    this.totalDayCalories,

  });

  Map<String, dynamic> toMap() {
    return {
      MealPlanModelFields.ID: this.id,
      MealPlanModelFields.CALORIES_LEVEL: this.caloriesLevel,
      MealPlanModelFields.WEEKLY_CALORIES: this.totalDayCalories,
      MealPlanModelFields.MEALS: this.meals,
      MealPlanModelFields.DAY: this.day,
      MealPlanModelFields.PLAN_ID: this.planId,
      MealPlanModelFields.MEAL_IN_EACH_DAY: this.mealsInEachDay,
      MealPlanModelFields.WEEK: this.week,
    };
  }

  MealPlanModel.fromMap(Map<String, dynamic> map) {
    this.caloriesLevel = map[MealPlanModelFields.CALORIES_LEVEL];
    this.meals = map[MealPlanModelFields.MEALS];
    this.day = map[MealPlanModelFields.DAY];
    this.week = map[MealPlanModelFields.WEEK];
    this.totalDayCalories = map[MealPlanModelFields.WEEKLY_CALORIES];
    this.id = map[MealPlanModelFields.ID];
    this.planId = map[MealPlanModelFields.PLAN_ID];
    this.mealsInEachDay = map[MealPlanModelFields.MEAL_IN_EACH_DAY];
  }

  @override
  String toString() {
    return 'MealPlanModel{calories_level: $caloriesLevel, week: $week, total_calories: $totalDayCalories, meals: $meals, id: $id, day: $day, meals_in_each_day: $mealsInEachDay, plan_id: $planId} ';
  }
}

class MealPlanModelFields {
  static const String ID = "id";
  static const String CALORIES_LEVEL = "calories_level";
  static const String MEALS = "meals";
  static const String DAY = "day";
  static const String WEEK = "week";
  static const String WEEKLY_CALORIES = "total_calories";
  static const String PLAN_ID = "plan_id";
  static const String MEAL_IN_EACH_DAY = "meals_in_each_day";
}
