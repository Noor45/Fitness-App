class PARQModel {
  String ques ;
  String id ;

  PARQModel({
    this.ques,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      PARQModelFields.QUES: this.ques,
      PARQModelFields.ID: this.id,
    };
  }

  PARQModel.fromMap(Map<String, dynamic> map) {
    if(map != null){
      this.ques = map[PARQModelFields.QUES] ?? "";
      this.id = map[PARQModelFields.ID] ?? "";
    }
  }

  @override
  String toString() {
    return 'PARQModel{ques: $ques, id: $id} ';
  }
}

class PARQModelFields {
  static const String QUES = "ques";
  static const String ID = "id";

}
