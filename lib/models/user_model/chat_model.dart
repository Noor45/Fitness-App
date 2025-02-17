import 'package:cloud_firestore/cloud_firestore.dart';

class AppMessages {

  String senderId;
  String receiverId;
  String message;
  String file;
  String threadId;
  String id;
  int type;
  Timestamp time;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'thread_id': threadId,
      'file': file,
      'type': type,
      'message': message,
      'time': time,
    };
  }

  AppMessages();

  static AppMessages mapToMessage(Map<String, dynamic> map) {
    AppMessages appMessage = new AppMessages();
    appMessage.senderId = map['sender_id'];
    appMessage.id = map['id'];
    appMessage.receiverId = map['receiver_id'];
    appMessage.type = map['type'];
    appMessage.message = map['message'] ?? "";
    appMessage.file = map['file'] ?? "";
    appMessage.threadId = map["thread_id"];
    appMessage.time = map["time"];
    return appMessage;
  }
}
