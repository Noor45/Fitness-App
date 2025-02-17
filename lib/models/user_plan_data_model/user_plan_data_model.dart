import 'package:cloud_firestore/cloud_firestore.dart';

class UserPlanDataModel {
  List data;
  int currentWeek;
  int currentDay;
  Timestamp weekDate;
  Timestamp currentDate;

  UserPlanDataModel({
    this.data,
    this.currentWeek,
    this.currentDay,
    this.weekDate,
    this.currentDate,
  });

  Map<String, dynamic> toMap() {
    return {
      UserPlanDataModelFields.DATA: this.data,
      UserPlanDataModelFields.DAY: this.currentDay,
      UserPlanDataModelFields.WEEK: this.currentWeek,
      UserPlanDataModelFields.WEEK_DATE: this.weekDate,
      UserPlanDataModelFields.CURRENT_DATE: this.currentDate,
    };
  }

  UserPlanDataModel.fromMap(Map<String, dynamic> map) {
    this.data = map[UserPlanDataModelFields.DATA];
    this.currentDay = map[UserPlanDataModelFields.DAY];
    this.currentWeek = map[UserPlanDataModelFields.WEEK];
    this.weekDate = map[UserPlanDataModelFields.WEEK_DATE];
    this.currentDate = map[UserPlanDataModelFields.CURRENT_DATE];
  }

  @override
  String toString() {
    return 'UserPlanDataModel{data: $data, current_day: $currentDay, current_week: $currentWeek, current_date: $currentDate, week_date: $weekDate} ';
  }
}

class UserPlanDataModelFields {
  static const String DATA = "data";
  static const String DAY = "current_day";
  static const String WEEK = "current_week";
  static const String WEEK_DATE = "week_date";
  static const String CURRENT_DATE = "current_date";
}
