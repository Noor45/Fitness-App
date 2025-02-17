
class MealCaloriesModel {
  int carbs;
  int protein;
  int fats;

  MealCaloriesModel({
    this.carbs,
    this.protein,
    this.fats,
  });

  Map<String, dynamic> toMap() {
    return {
      MealCaloriesModelFields.CARBS: this.carbs,
      MealCaloriesModelFields.PROTEIN: this.protein,
      MealCaloriesModelFields.FATS: this.fats,
    };
  }

  MealCaloriesModel.fromMap(Map<String, dynamic> map) {
    if(map != null){
      this.carbs = map[MealCaloriesModelFields.CARBS];
      this.protein = map[MealCaloriesModelFields.PROTEIN];
      this.fats = map[MealCaloriesModelFields.FATS];
    }
  }

  @override
  String toString() {
    return 'MealCaloriesModel{carbs: $carbs, protien: $protein, fats: $fats} ';
  }
}

class MealCaloriesModelFields {
  static const String CARBS = "carbs";
  static const String PROTEIN = "protien";
  static const String FATS = "fats";

}
