class GetStaffUserModel {
  String name;
  String job;
  int onlineStatus;
  String bio;
  String id;
  String image;


  GetStaffUserModel({
    this.name,
    this.job,
    this.onlineStatus,
    this.id,
    this.image,

  });

  Map<String, dynamic> toMap() {
    return {
      GetStaffUserModelFields.ID: this.id,
      GetStaffUserModelFields.NAME: this.name,
      GetStaffUserModelFields.IMAGE: this.image,
      GetStaffUserModelFields.JOB: this.job,
      GetStaffUserModelFields.BIO: this.bio,
      GetStaffUserModelFields.ONLINE_STATUS: this.onlineStatus,
    };
  }

  GetStaffUserModel.fromMap(Map<String, dynamic> map) {
    this.id = map[GetStaffUserModelFields.ID];
    this.name = map[GetStaffUserModelFields.NAME];
    this.job = map[GetStaffUserModelFields.JOB];
    this.bio = map[GetStaffUserModelFields.BIO];
    this.image = map[GetStaffUserModelFields.IMAGE];
    this.onlineStatus = map[GetStaffUserModelFields.ONLINE_STATUS];
  }

  @override
  String toString() {
    return 'GetStaffUserModel{name: $name, state: $onlineStatus, job: $job, id: $id, bio: $bio, images: $image} ';
  }
}

class GetStaffUserModelFields {
  static const String ID = "id";
  static const String NAME = "name";
  static const String JOB = "job";
  static const String BIO = "bio";
  static const String IMAGE = "images";
  static const String ONLINE_STATUS = "state";
}
