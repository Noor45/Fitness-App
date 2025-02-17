class MentalHealthModel {
  String id;
  String uid;
  int type;
  String title;
  String fileUrl;
  List tags;
  String description;
  var exercise;



  MentalHealthModel({
    this.tags,
    this.title,
    this.fileUrl,
    this.description,
    this.exercise,
    this.id,
    this.uid,
    this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      MentalHealthModelFields.ID: this.id,
      MentalHealthModelFields.DESCRIPTION: this.description,
      MentalHealthModelFields.EXERCISE: this.exercise,
      MentalHealthModelFields.TITLE: this.title,
      MentalHealthModelFields.TAGS: this.tags,
      MentalHealthModelFields.FILE_URL: this.fileUrl,
      MentalHealthModelFields.TYPE: this.type,
      MentalHealthModelFields.UID: this.uid,
    };
  }

  MentalHealthModel.fromMap(Map<String, dynamic> map) {
    this.title = map[MentalHealthModelFields.TITLE];
    this.tags = map[MentalHealthModelFields.TAGS];
    this.exercise = map[MentalHealthModelFields.EXERCISE];
    this.fileUrl = map[MentalHealthModelFields.FILE_URL];
    this.description = map[MentalHealthModelFields.DESCRIPTION];
    this.id = map[MentalHealthModelFields.ID];
    this.uid = map[MentalHealthModelFields.UID];
    this.type = map[MentalHealthModelFields.TYPE];
  }

  @override
  String toString() {
    return 'MentalHealthModel{file_url: $fileUrl, exercise: $exercise, description: $description, type: $type, title: $title, id: $id, tags: $tags, uid: $uid} ';
  }
}

class MentalHealthModelFields {
  static const String ID = "id";
  static const String TITLE = "title";
  static const String TAGS = "tags";
  static const String FILE_URL = "file_url";
  static const String EXERCISE = "exercise";
  static const String DESCRIPTION = "description";
  static const String TYPE = "type";
  static const String UID = "uid";
}
