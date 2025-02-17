import 'package:cloud_firestore/cloud_firestore.dart';

class BlogModel {
  String name;
  String profileImage;
  String post;
  String file;
  int type;
  Timestamp time;
  String id;
  List favorites;
  List likes;

  BlogModel({
    this.post,
    this.name,
    this.profileImage,
    this.file,
    this.time,
    this.id,
    this.favorites,
    this.likes,
    this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      BlogModelFields.UID: this.id,
      BlogModelFields.FILE: this.file,
      BlogModelFields.NAME: this.name,
      BlogModelFields.POST: this.post,
      BlogModelFields.PROFILE_IMAGE: this.profileImage,
      BlogModelFields.TIME: this.time,
      BlogModelFields.TYPE: this.type,
      BlogModelFields.LIKES: this.likes,
      BlogModelFields.FAVORITES: this.favorites,
    };
  }

  BlogModel.fromMap(Map<String, dynamic> map) {
    this.name = map[BlogModelFields.NAME];
    this.post = map[BlogModelFields.POST];
    this.profileImage = map[BlogModelFields.PROFILE_IMAGE];
    this.time = map[BlogModelFields.TIME];
    this.file = map[BlogModelFields.FILE];
    this.id = map[BlogModelFields.UID];
    this.favorites = map[BlogModelFields.FAVORITES];
    this.type = map[BlogModelFields.TYPE];
    this.likes = map[BlogModelFields.LIKES];
  }

  @override
  String toString() {
    return 'BlogModel{profile_image: $profileImage, time: $time, likes: $likes, file: $file, type: $type, name: $name, id: $id, post: $post, favorites: $favorites} ';
  }
}

class BlogModelFields {
  static const String UID = "id";
  static const String NAME = "name";
  static const String LIKES = "likes";
  static const String POST = "post";
  static const String PROFILE_IMAGE = "profile_image";
  static const String TIME = "time";
  static const String FILE = "file";
  static const String TYPE = "type";
  static const String FAVORITES = "favorites";
}
