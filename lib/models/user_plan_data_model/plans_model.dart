class PlanAssignModel {
  String userId;
  int meal;
  int workout;
  int supplements;
  int mindfulness;
  int weight;


  PlanAssignModel({
    this.userId,
    this.meal,
    this.workout,
    this.weight,
    this.mindfulness,
    this.supplements,
  });


  PlanAssignModel.fromMap(Map<String, dynamic> map) {
    this.userId = map[PlanAssignModelFields.USER_ID];
    this.workout = map[PlanAssignModelFields.WORKOUT];
    this.meal = map[PlanAssignModelFields.MEAL];
    this.weight = map[PlanAssignModelFields.WEIGHT];
    this.mindfulness = map[PlanAssignModelFields.MINDFULNESS];
    this.supplements = map[PlanAssignModelFields.SUPPLEMENTS];
  }

  @override
  String toString() {
    return 'PlanAssignModel{meal: $meal, supplements: $supplements, mindfulness: $mindfulness, user_id: $userId, workout: $workout, weight: $weight} ';
  }
}

class PlanAssignModelFields {
  static const String USER_ID = "user_id";
  static const String WORKOUT = "workout";
  static const String MEAL = "meal";
  static const String WEIGHT = "weight";
  static const String SUPPLEMENTS = "supplements";
  static const String MINDFULNESS = "mindfulness";
}
