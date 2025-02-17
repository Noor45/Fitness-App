class MedicalReportModel {
  var name;
  var file;
  var type;

  MedicalReportModel({
    this.name,
    this.file,
    this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      MedicalReportModelFields.NAME: this.name,
      MedicalReportModelFields.FILE: this.file,
      MedicalReportModelFields.TYPE: this.type,
    };
  }

  MedicalReportModel.fromMap(Map<String, dynamic> map) {
    this.name = map[MedicalReportModelFields.NAME];
    this.file = map[MedicalReportModelFields.FILE];
    this.type = map[MedicalReportModelFields.TYPE];
  }

  @override
  String toString() {
    return 'MedicalReportModel{name: $name, file: $file, type: $type} ';
  }
}

class MedicalReportModelFields {
  static const String NAME = "name";
  static const String FILE = "file";
  static const String TYPE = "type";
}
