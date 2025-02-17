class CaloriesDetailModel {
  int intake = 0;
  int level = 0;

  CaloriesDetailModel({
    this.intake,
    this.level,
  });

  Map<String, dynamic> toMap() {
    return {
      CaloriesDetailModelFields.INTAKE: this.intake,
      CaloriesDetailModelFields.LEVEL: this.level,
    };
  }

  CaloriesDetailModel.fromMap(Map<String, dynamic> map) {
    if(map != null){
      this.level = map[CaloriesDetailModelFields.LEVEL] ?? 0;
    }
  }

  @override
  String toString() {
    return 'CaloriesDetailModel{intake: $intake, level: $level} ';
  }
}

class CaloriesDetailModelFields {
  static const String INTAKE = "intake";
  static const String LEVEL = "level";

}
