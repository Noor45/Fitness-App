class SupplementUseModel {
  String dosage;
  int durationWeek;
  int offWeek;
  String level;
  int grams;

  SupplementUseModel({
    this.durationWeek,
    this.offWeek,
    this.dosage,
    this.grams,
    this.level,

  });

  Map<String, dynamic> toMap() {
    return {
      SupplementUseModelFields.DOSAGE: this.dosage,
      SupplementUseModelFields.DURATION_WEEK: this.durationWeek,
      SupplementUseModelFields.WEEK_OFF: this.offWeek,
      SupplementUseModelFields.LEVEL: this.level,
      SupplementUseModelFields.GRAMS: this.grams,
    };
  }

  SupplementUseModel.fromMap(Map<String, dynamic> map) {
    this.durationWeek = map[SupplementUseModelFields.DURATION_WEEK];
    this.offWeek = map[SupplementUseModelFields.WEEK_OFF];
    this.dosage = map[SupplementUseModelFields.DOSAGE];
    this.grams = map[SupplementUseModelFields.GRAMS];
    this.level = map[SupplementUseModelFields.LEVEL];
  }

  @override
  String toString() {
    return 'SupplementUseModel{off_week: $offWeek, duration_week: $durationWeek, grams: $grams, level: $level, dosage: $dosage} ';
  }
}

class SupplementUseModelFields {
  static const String DOSAGE = "dosage";
  static const String DURATION_WEEK = "duration_week";
  static const String GRAMS = "grams";
  static const String LEVEL = "level";
  static const String WEEK_OFF = "off_week";
}
