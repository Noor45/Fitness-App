class UserMealDetailModel {
  String detail;
  String image;

  UserMealDetailModel({
    this.detail,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      UserMealDetailModelFields.DETAIL: this.detail,
      UserMealDetailModelFields.IMAGE: this.image,
    };
  }

  UserMealDetailModel.fromMap(Map<String, dynamic> map) {
    this.detail = map[UserMealDetailModelFields.DETAIL];
    this.image = map[UserMealDetailModelFields.IMAGE];
  }

  @override
  String toString() {
    return 'UserMealDetailModel{detail: $detail, image: $image}';
  }
}

class UserMealDetailModelFields {
  static const String DETAIL = "detail";
  static const String IMAGE = "image";
}
