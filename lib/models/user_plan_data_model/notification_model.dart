import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String id;
  String userId;
  String title;
  String body;
  int type;
  int md;
  int mealPortion;
  Timestamp createdAt;

  NotificationModel({
    this.userId,
    this.id,
    this.title,
    this.body,
    this.type,
    this.md,
    this.mealPortion,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      NotificationModelFields.CREATED_AT: this.createdAt,
      NotificationModelFields.USER_ID: this.userId,
      NotificationModelFields.ID: this.id,
      NotificationModelFields.TITLE: this.title,
      NotificationModelFields.TYPE: this.type,
      NotificationModelFields.BODY: this.body,
      NotificationModelFields.MD: this.md,
      NotificationModelFields.MEAL_PORTION: this.mealPortion,
    };
  }

  NotificationModel.fromMap(Map<String, dynamic> map) {
    this.userId = map[NotificationModelFields.USER_ID];
    this.id = map[NotificationModelFields.ID];
    this.title = map[NotificationModelFields.TITLE];
    this.type = map[NotificationModelFields.TYPE];
    this.body = map[NotificationModelFields.BODY];
    this.md = map[NotificationModelFields.MD];
    this.mealPortion = map[NotificationModelFields.MEAL_PORTION];
    this.createdAt = map[NotificationModelFields.CREATED_AT];
  }

  @override
  String toString() {
    return 'NotificationModel{body: $body, created_at: $createdAt, title: $title, md: $md, meal_portion: $mealPortion, type: $type, user_id: $userId, id: $id} ';
  }
}

class NotificationModelFields {
  static const String TITLE = "title";
  static const String USER_ID = "user_id";
  static const String TYPE = "type";
  static const String BODY = "body";
  static const String ID = "id";
  static const String MEAL_PORTION = "meal_portion";
  static const String MD = "md";
  static const String CREATED_AT = "created_at";
}
