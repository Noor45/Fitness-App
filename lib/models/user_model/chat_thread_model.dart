import 'package:cloud_firestore/cloud_firestore.dart';

class AppMessagesThread {

  String senderId;
  String lastMessage;
  List chatListUsers = [];
  String threadId;
  String name;
  int type;
  Timestamp lastMessageTime;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'sender_id': senderId,
      'thread_id': threadId,
      'chat_list_users': chatListUsers,
      'type': type,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
    };
  }

  AppMessagesThread();

  static AppMessagesThread mapToMessage(Map<String, dynamic> map) {
    AppMessagesThread appMessage = new AppMessagesThread();
    appMessage.senderId = map['sender_id'];
    appMessage.name = map['name'];
    appMessage.type = map['type'];
    appMessage.lastMessage = map['message'] ?? "";
    appMessage.chatListUsers = map['chat_list_users'] ?? "";
    appMessage.threadId = map["thread_id"];
    appMessage.lastMessageTime = map["time"];
    return appMessage;
  }
}
