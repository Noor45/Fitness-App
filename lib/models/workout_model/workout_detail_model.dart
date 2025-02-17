class WorkoutDetailModel {
  String name = "";
  String link = "";
  String des = "";
  int repeat = 0;
  int sets = 0;
  int rest = 0;
  int burnCal = 0;
  int mins = 0;

  WorkoutDetailModel({
    this.name,
    this.link,
    this.repeat,
    this.rest,
    this.sets,
    this.burnCal,
    this.mins,
  });

  Map<String, dynamic> toMap() {
    return {
      WorkoutDetailModelFields.NAME: this.name,
      WorkoutDetailModelFields.LINK: this.link,
      WorkoutDetailModelFields.REST: this.rest,
      WorkoutDetailModelFields.REPEAT: this.repeat,
      WorkoutDetailModelFields.SETS: this.sets,
      WorkoutDetailModelFields.BURN_CAL: this.burnCal,
      WorkoutDetailModelFields.MINS: this.mins,
      WorkoutDetailModelFields.DES: this.des,
    };
  }

  WorkoutDetailModel.fromMap(Map<String, dynamic> map) {
    if(map != null){
      this.name = map[WorkoutDetailModelFields.NAME];
      this.link = map[WorkoutDetailModelFields.LINK];
      this.repeat = map[WorkoutDetailModelFields.REPEAT];
      this.rest = map[WorkoutDetailModelFields.REST];
      this.sets = map[WorkoutDetailModelFields.SETS];
      this.burnCal = map[WorkoutDetailModelFields.BURN_CAL];
      this.mins = map[WorkoutDetailModelFields.MINS];
      this.des = map[WorkoutDetailModelFields.DES];
    }
  }

  @override
  String toString() {
    return 'WorkoutDetailModel{title: $name, video_link: $link, repeat: $repeat, sets: $sets, rest: $rest, burn_cal: $burnCal, mins: $mins, description: $des} ';
  }
}

class WorkoutDetailModelFields {
  static const String NAME = "title";
  static const String LINK = "video_link";
  static const String REPEAT = "repeat";
  static const String SETS = "sets";
  static const String REST = "rest";
  static const String BURN_CAL = "burn_cal";
  static const String MINS = "mins";
  static const String DES = "description";

}
