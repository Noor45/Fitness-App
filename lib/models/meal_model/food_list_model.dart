import 'package:cloud_firestore/cloud_firestore.dart';

class FoodListModel {
  List food;
  Timestamp time;

  FoodListModel({
    this.food,
    this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      FoodListModelFields.FOOD: this.food,
      FoodListModelFields.TIME: this.time,
    };
  }

  FoodListModel.fromMap(Map<String, dynamic> map) {
    this.food = map[FoodListModelFields.FOOD];
    this.time = map[FoodListModelFields.TIME];
  }

  @override
  String toString() {
    return 'FoodListModel{food: $food, time: $time}';
  }
}

class FoodListModelFields {
  static const String FOOD = "food";
  static const String TIME = "time";
}
