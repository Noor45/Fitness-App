import 'package:cloud_firestore/cloud_firestore.dart';
class DiaryModel {
  String uid;
  Timestamp createdAt;
  String text;
  String title;
  String id;

  DiaryModel({
    this.uid,
    this.text,
    this.title,
    this.id,
    this.createdAt,
  });


  Map<String, dynamic> toMap()  {
    return {
      DiaryModelFields.CREATED_DATE : createdAt,
      DiaryModelFields.UID: uid,
      DiaryModelFields.TITLE : title,
      DiaryModelFields.TEXT : text,
      DiaryModelFields.ID : id,
    };
  }

  DiaryModel.fromMap(Map<String, dynamic> map) {
    if(map != null){
      this.createdAt = map[DiaryModelFields.CREATED_DATE];
      this.id = map[DiaryModelFields.ID];
      this.title = map[DiaryModelFields.TITLE];
      this.text = map[DiaryModelFields.TEXT];
      this.uid = map[DiaryModelFields.UID];
    }
  }

  @override
  String toString() {
    return 'DiaryModel{id: $id, uid: $uid, title: $title, created_at: $createdAt, text: $text} ';
  }
}

class DiaryModelFields {
  static const String ID = "id";
  static const String UID = "uid";
  static const String CREATED_DATE = "created_at";
  static const String TITLE = "title";
  static const String TEXT = "text";
}
