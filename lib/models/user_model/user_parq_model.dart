class UserPARQModel {
  int ans ;
  String ques ;

  UserPARQModel({
    this.ans,
    this.ques,
  });

  Map<String, dynamic> toMap() {
    return {
      UserPARQModelFields.ANS: this.ans,
      UserPARQModelFields.QUES_ID: this.ques,
    };
  }

  UserPARQModel.fromMap(Map<String, dynamic> map) {
    if(map != null){
      this.ans = map[UserPARQModelFields.ANS] ?? "";
      this.ques = map[UserPARQModelFields.QUES_ID] ?? "";
    }
  }

  @override
  String toString() {
    return 'UserPARQModel{ans: $ans, ques: $ques} ';
  }
}

class UserPARQModelFields {
  static const String ANS = "ans";
  static const String QUES_ID = "ques";

}
