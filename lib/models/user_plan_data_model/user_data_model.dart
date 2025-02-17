import 'package:t_fit/models/user_plan_data_model/user_plan_data_model.dart';

class UserDataModel {
  String id;
  String uid;
  String mealPlanId;
  String workoutPlanId;
  var workout;
  var meal;

  UserDataModel({
    this.workout,
    this.meal,
    this.id,
    this.uid,
    this.mealPlanId,
    this.workoutPlanId,
  });

  Map<String, dynamic> toMap() {
    return {
      UserDataModelFields.ID: this.id,
      UserDataModelFields.WORKOUT: this.workout,
      UserDataModelFields.MEAL: this.meal,
      UserDataModelFields.MEAL_PLAN_ID: this.meal,
      UserDataModelFields.WORKOUT_PLAN_ID: this.meal,
      UserDataModelFields.USER_ID: this.meal,
    };
  }

  UserDataModel.fromMap(Map<String, dynamic> map) {
    this.meal = map[UserDataModelFields.MEAL] == null ? null : UserPlanDataModel.fromMap(map[UserDataModelFields.MEAL]).toMap();
    this.workout = map[UserDataModelFields.WORKOUT] == null ? null : UserPlanDataModel.fromMap(map[UserDataModelFields.WORKOUT]).toMap();
    this.id = map[UserDataModelFields.ID];
    this.mealPlanId = map[UserDataModelFields.MEAL_PLAN_ID];
    this.workoutPlanId = map[UserDataModelFields.WORKOUT_PLAN_ID];
    this.uid = map[UserDataModelFields.USER_ID];
  }

  @override
  String toString() {
    return 'UserDataModel{meal: $meal, workout: $workout, meal_plan_id: $mealPlanId, workout_plan_id: $workoutPlanId, user_id: $uid} ';
  }
}

class UserDataModelFields {
  static const String ID = "id";
  static const String WORKOUT = "workout";
  static const String MEAL = "meal";
  static const String MEAL_PLAN_ID = "meal_plan_id";
  static const String WORKOUT_PLAN_ID = "workout_plan_id";
  static const String USER_ID = "user_id";

}
