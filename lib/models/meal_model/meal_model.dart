class MealModel {
  String des;
  String image;
  String time;
  var caloriesIntake;

  MealModel({
    this.time,
    this.image,
    this.des,
    this.caloriesIntake,
  });

  Map<String, dynamic> toMap() {
    return {
      MealModelFields.DES: this.des,
      MealModelFields.IMAGE: this.image,
      MealModelFields.TIME: this.time,
      MealModelFields.CALORIES_INTAKE: this.caloriesIntake,
    };
  }

  MealModel.fromMap(Map<String, dynamic> map) {
    if(map != null){
      this.des = map[MealModelFields.DES];
      this.image = map[MealModelFields.IMAGE];
      this.time = map[MealModelFields.TIME];
      this.caloriesIntake = map[MealModelFields.CALORIES_INTAKE];
    }
  }

  @override
  String toString() {
    return 'MealModel{des: $des, time: $time, image: $image, calories_intake: $caloriesIntake} ';
  }
}

class MealModelFields {
  static const String DES = "des";
  static const String TIME = "time";
  static const String IMAGE = "image";
  static const String CALORIES_INTAKE = "calories_intake";

}
