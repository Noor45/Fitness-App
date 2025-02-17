class LocalNotificationTimeModel {
  String uid;
  String mealOne;
  String mealTwo;
  String mealThree;
  String mealFour;
  String mealFive;
  String mealSix;
  String workout;
  String alarm;


  LocalNotificationTimeModel({
    this.uid,
    this.mealOne,
    this.mealTwo,
    this.mealThree,
    this.mealFour,
    this.mealFive,
    this.mealSix,
    this.workout,
    this.alarm,

  });

  Map<String, dynamic> toMap() {
    return {
      LocalNotificationTimeModelFields.UID: this.uid,
      LocalNotificationTimeModelFields.MEAL_ONE: this.mealOne,
      LocalNotificationTimeModelFields.MEAL_TWO: this.mealTwo,
      LocalNotificationTimeModelFields.MEAL_THREE: this.mealThree,
      LocalNotificationTimeModelFields.MEAL_FOUR: this.mealFour,
      LocalNotificationTimeModelFields.MEAL_FIVE: this.mealFive,
      LocalNotificationTimeModelFields.MEAL_SIX: this.mealSix,
      LocalNotificationTimeModelFields.WORKOUT: this.workout,
      LocalNotificationTimeModelFields.ALARM: this.alarm,

    };
  }

  LocalNotificationTimeModel.fromMap(Map<String, dynamic> map) {
    this.uid = map[LocalNotificationTimeModelFields.UID];
    this.mealOne = map[LocalNotificationTimeModelFields.MEAL_ONE];
    this.mealTwo = map[LocalNotificationTimeModelFields.MEAL_TWO];
    this.mealThree = map[LocalNotificationTimeModelFields.MEAL_THREE];
    this.mealFour = map[LocalNotificationTimeModelFields.MEAL_FOUR];
    this.mealFive = map[LocalNotificationTimeModelFields.MEAL_FOUR];
    this.mealSix = map[LocalNotificationTimeModelFields.MEAL_SIX];
  }

  @override
  String toString() {
    return 'LocalNotificationTimeModel{uid: $uid, meal_one: $mealOne, meal_two: $mealTwo, meal_three: $mealThree, meal_four: $mealFour, meal_five: $mealFive, meal_six: $mealSix, workout: $workout, alarm_ring: $alarm} ';
  }
}

class LocalNotificationTimeModelFields {
  static const String UID = "uid";
  static const String MEAL_ONE = "meal_one";
  static const String MEAL_TWO = "meal_two";
  static const String MEAL_THREE = "meal_three";
  static const String MEAL_FOUR = "meal_four";
  static const String MEAL_FIVE = "meal_five";
  static const String MEAL_SIX = "meal_six";
  static const String WORKOUT = "workout";
  static const String ALARM = "alarm_ring";
}
