import '../../models/workout_model/user_workout_model.dart';

class UserWorkoutPlanModel {
  var cardioAbs;
  var training;

  UserWorkoutPlanModel({
    this.cardioAbs,
    this.training,
  });

  Map<String, dynamic> toMap() {
    return {
      UserWorkoutPlanModelFields.CARDIO_ABS: this.cardioAbs,
      UserWorkoutPlanModelFields.TRAINING: this.training,
    };
  }

  UserWorkoutPlanModel.fromMap(Map<String, dynamic> map) {
    if(map != null){
      this.cardioAbs = UserWorkoutModel.fromMap(map[UserWorkoutPlanModelFields.CARDIO_ABS]).toMap();
      this.training = UserWorkoutModel.fromMap(map[UserWorkoutPlanModelFields.TRAINING]).toMap();
    }
  }

  @override
  String toString() {
    return 'UserWorkoutPlanModel{cardio_abs: $cardioAbs, training: $training} ';
  }
}

class UserWorkoutPlanModelFields {
  static const String CARDIO_ABS = "cardio_abs";
  static const String TRAINING = "training";

}
