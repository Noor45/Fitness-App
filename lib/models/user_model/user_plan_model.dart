import 'package:cloud_firestore/cloud_firestore.dart';

class PlanModel {
  String des;
  String id;
  int duration;
  bool updatePlan;
  String planName;
  int planType;
  Timestamp endDate;
  Timestamp startDate;
  Timestamp assignedDate;

  PlanModel({
    this.planName,
    this.duration,
    this.updatePlan,
    this.startDate,
    this.planType,
    this.endDate,
    this.id,
    this.des,
    this.assignedDate,
  });

  Map<String, dynamic> toMap() {
    return {
      PlanModelFields.ID: this.id,
      PlanModelFields.DES: this.des,
      PlanModelFields.PLAN_NAME: this.planName,
      PlanModelFields.UPDATE_PLAN: this.updatePlan,
      PlanModelFields.DURATION: this.duration,
      PlanModelFields.START_DATE: this.startDate,
      PlanModelFields.END_DATE: this.endDate,
      PlanModelFields.PLAN_TYPE: this.planType,
      PlanModelFields.ASSIGNED_DATE: this.assignedDate,
    };
  }

  PlanModel.fromMap(Map<String, dynamic> map) {
    this.id = map[PlanModelFields.ID];
    this.planType = map[PlanModelFields.PLAN_TYPE];
    this.des = map[PlanModelFields.DES];
    this.planName = map[PlanModelFields.PLAN_NAME];
    this.updatePlan = map[PlanModelFields.UPDATE_PLAN];
    this.duration = map[PlanModelFields.DURATION];
    this.startDate = map[PlanModelFields.START_DATE];
    this.endDate = map[PlanModelFields.END_DATE];
    this.assignedDate = map[PlanModelFields.ASSIGNED_DATE];
  }

  @override
  String toString() {
    return 'UserPlanModel{des: $des, duration: $duration, plan_type: $planType, update_plan: $updatePlan, start_date: $startDate, end_date: $endDate, title: $planName, id: $id, assigned_date: $assignedDate} ';
  }
}

class PlanModelFields {
  static const String ID = "id";
  static const String DES = "des";
  static const String PLAN_NAME = "title";
  static const String DURATION = "duration";
  static const String END_DATE = "end_date";
  static const String START_DATE = "start_date";
  static const String ASSIGNED_DATE = "assigned_date";
  static const String UPDATE_PLAN = "update_plan";
  static const String PLAN_TYPE = "plan_type";
  // static const String WEEKLY_CALORIES = "weekly_calories";
}
