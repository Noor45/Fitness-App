class SupplementDetailModel {
  String calories;
  String des;
  String formula;
  String image;

  SupplementDetailModel({
    this.des,
    this.formula,
    this.calories,

  });

  Map<String, dynamic> toMap() {
    return {
      SupplementDetailModelFields.Calories: this.calories,
      SupplementDetailModelFields.DES: this.des,
      SupplementDetailModelFields.IMAGE: this.image,
      SupplementDetailModelFields.FORMULA: this.formula,
    };
  }

  SupplementDetailModel.fromMap(Map<String, dynamic> map) {
    this.des = map[SupplementDetailModelFields.DES];
    this.formula = map[SupplementDetailModelFields.FORMULA];
    this.calories = map[SupplementDetailModelFields.Calories];
    this.image = map[SupplementDetailModelFields.IMAGE];
  }

  @override
  String toString() {
    return 'SupplementDetailModel{formula: $formula, des: $des, calories: $calories, image: $image} ';
  }
}

class SupplementDetailModelFields {
  static const String Calories = "calories";
  static const String DES = "des";
  static const String IMAGE = "image";
  static const String FORMULA = "formula";
}
