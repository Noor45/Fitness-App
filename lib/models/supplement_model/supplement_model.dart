import '../../models/supplement_model/supplement_detail_model.dart';
import '../../models/supplement_model/supplement_use_model.dart';

class SupplementPlanModel {
  var detail;
  var use;
  String id;
  String planId;
  String name;
  int week;
  int day;


  SupplementPlanModel({
    this.detail,
    this.name,
    this.week,
    this.use,
    this.id,
    this.planId,

  });

  Map<String, dynamic> toMap() {
    return {
      SupplementsPlanModelFields.ID: this.id,
      SupplementsPlanModelFields.DETAILS: this.detail,
      SupplementsPlanModelFields.NAME: this.name,
      SupplementsPlanModelFields.PLAN_ID: this.planId,
      SupplementsPlanModelFields.DAY: this.day,
      SupplementsPlanModelFields.WEEK: this.week,
      SupplementsPlanModelFields.USE: this.use,
    };
  }

  SupplementPlanModel.fromMap(Map<String, dynamic> map) {
    this.detail = SupplementDetailModel.fromMap(map[SupplementsPlanModelFields.DETAILS]).toMap();
    this.name = map[SupplementsPlanModelFields.NAME];
    this.day = map[SupplementsPlanModelFields.DAY];
    this.week = map[SupplementsPlanModelFields.WEEK];
    this.use =  SupplementUseModel.fromMap(map[SupplementsPlanModelFields.USE]).toMap();
    this.id = map[SupplementsPlanModelFields.ID];
    this.planId = map[SupplementsPlanModelFields.PLAN_ID];
  }

  @override
  String toString() {
    return 'SupplementPlanModel{detail: $detail, week: $week, use: $use, title: $name, id: $id, day: $day, plan_id: $planId} ';
  }
}

class SupplementsPlanModelFields {
  static const String ID = "id";
  static const String DETAILS = "detail";
  static const String NAME = "title";
  static const String DAY = "day";
  static const String WEEK = "week";
  static const String USE = "use";
  static const String PLAN_ID = "plan_id";
}
