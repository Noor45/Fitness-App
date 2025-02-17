import 'package:cloud_firestore/cloud_firestore.dart';

class UserWeightModel {
  String uid;
  String id;
  String key;
  String note;
  double weight;
  Timestamp date;

  UserWeightModel({
    this.weight,
    this.date,
    this.id,
    this.key,
    this.uid,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      UserWeightModelFields.ID: this.id,
      UserWeightModelFields.KEY: this.key,
      UserWeightModelFields.UID: this.uid,
      UserWeightModelFields.WEIGHT: this.weight,
      UserWeightModelFields.DATE: this.date,
      UserWeightModelFields.NOTE: this.note,
    };
  }

  UserWeightModel.fromMap(Map<String, dynamic> map) {
    this.id = map[UserWeightModelFields.ID];
    this.key = map[UserWeightModelFields.KEY];
    this.uid = map[UserWeightModelFields.UID];
    this.weight = map[UserWeightModelFields.WEIGHT] ?? 0;
    this.date = map[UserWeightModelFields.DATE];
    this.note = map[UserWeightModelFields.NOTE];
  }

  @override
  String toString() {
    return 'UserWeightModel{uid: $uid, weight: $weight, note: $note, date: $date, id: $id, key: $key} ';
  }
}

class UserWeightModelFields {
  static const String ID = "id";
  static const String KEY = "key";
  static const String UID = "uid";
  static const String WEIGHT = "weight";
  static const String DATE = "date";
  static const String NOTE = "note";
}
