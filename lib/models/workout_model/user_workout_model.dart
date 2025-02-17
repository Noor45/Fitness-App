class UserWorkoutModel {
  String name = "";
  String workoutId = "";

  UserWorkoutModel({
    this.name,
    this.workoutId,
  });

  Map<String, dynamic> toMap() {
    return {
      UserWorkoutModelFields.NAME: this.name,
      UserWorkoutModelFields.WORKOUT_ID: this.workoutId,
    };
  }

  UserWorkoutModel.fromMap(Map<String, dynamic> map) {
    if(map != null){
      this.name = map[UserWorkoutModelFields.NAME] ?? "";
      this.workoutId = map[UserWorkoutModelFields.WORKOUT_ID] ?? "";
    }
  }

  @override
  String toString() {
    return 'UserWorkoutModel{name: $name, workout_id: $workoutId} ';
  }
}

class UserWorkoutModelFields {
  static const String NAME = "name";
  static const String WORKOUT_ID = "workout_id";

}
