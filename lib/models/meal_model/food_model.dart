class FoodModel {
  String food;
  int grams;
  int piece;

  FoodModel({
    this.food,
    this.grams,
    this.piece,
  });

  Map<String, dynamic> toMap() {
    return {
      FoodModelFields.FOOD: this.food,
      FoodModelFields.GRAMS: this.grams,
      FoodModelFields.PIECE: this.piece,
    };
  }

  FoodModel.fromMap(Map<String, dynamic> map) {
    this.food = map[FoodModelFields.FOOD];
    this.grams = map[FoodModelFields.GRAMS];
    this.piece = map[FoodModelFields.PIECE];
  }

  @override
  String toString() {
    return 'FoodModel{food: $food, grams: $grams, piece: $piece} ';
  }
}

class FoodModelFields {
  static const String FOOD = "food";
  static const String GRAMS = "grams";
  static const String PIECE = "piece";
}
