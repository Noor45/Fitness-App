import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:t_fit/widgets/file_video_player.dart';
import '../utils/colors.dart';
import '../utils/fonts.dart';
import '../models/user_model/chat_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MessagesStream extends StatefulWidget {
  final String threadId;
  final String name;
  final String id;

  MessagesStream(this.threadId, this.name, this.id, );
  @override
  _MessagesStreamState createState() => _MessagesStreamState();
}

class _MessagesStreamState extends State<MessagesStream> {
  final _firestore = FirebaseFirestore.instance;
  final List<Map<String, dynamic >> messageList = [];

  @override
  Widget build(BuildContext context) {
    var formatter = new DateFormat('MMM dd, yyyy');
    var timeFormatter = new DateFormat('hh:mm a');
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('messages')
          .where("thread_id", isEqualTo: widget.threadId)
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        List<MessageBubble> messageBubbles = [];
        if (snapshot.hasData) {
          final messages = snapshot.data.docs;
          try {
            for (var message in messages) {
              AppMessages appMessages = AppMessages.mapToMessage(message.data());
              final messageText = appMessages.message;
              final messageFile = appMessages.file;
              final messageSender = appMessages.senderId ?? "";
              final currentUser = AuthController.currentUser.uid;
              final type = appMessages.type;
              final date = appMessages.time;
              final id = appMessages.id;
              timeFormatter.format(date.toDate());
              final messageBubble = MessageBubble(
                key: UniqueKey(),
                sender: messageSender,
                text: messageText ?? "",
                type: type,
                file: messageFile,
                messageId: id,
                time: timeFormatter.format(date.toDate()),
                isMe: currentUser == messageSender,
              );
              messageBubbles.add(messageBubble);
            }
          } catch (e) {
            print(e);
          }
        }
        return Expanded(
          child: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25)),
            ),
            child: Column(
              children: [
                AutoSizeText(formatter.format(DateTime.now()), style: TextStyle(color: ColorRefer.kLightGreyColor, fontSize: 14),),
                Flexible(
                  child: ListView(
                    reverse: true,
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    semanticChildCount: messageBubbles.length,
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    children: messageBubbles,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }



}

class MessageBubble extends StatefulWidget {
  MessageBubble({this.sender, this.text, this.isMe, this.time, this.type, this.file, this.messageId, Key key}): super(key: key);
  final String time;
  final String sender;
  final String messageId;
  final String text;
  final String file;
  final int type;
  final bool isMe;
  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
        widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Material(
              borderRadius: widget.isMe
                  ? BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  bottomLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0))
                  : BorderRadius.only(
                topLeft: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
              elevation: 3.0,
              color: widget.isMe ? ColorRefer.kRedColor : ColorRefer.kLightGreyColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: widget.type == 1 ? true : false,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: InkWell(
                          onTap: (){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  insetPadding: EdgeInsets.only(top: 30, left: 0, right: 0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                  child: Container(
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight:  Radius.circular(10))
                                          ),
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              AutoSizeText('Preview', style: TextStyle(fontSize: 15, color: Colors.black),),
                                              InkWell(
                                                onTap: (){
                                                  Navigator.pop(context);
                                                },
                                                child: Icon(Icons.close, color: Colors.black),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight:  Radius.circular(10))
                                          ),
                                          padding: EdgeInsets.only(bottom: 30),
                                          child: CachedNetworkImage(
                                            imageUrl: widget.file,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: CachedNetworkImage(
                            imageUrl: widget.file,
                            width: MediaQuery.of(context).size.width/1.5,
                            height: MediaQuery.of(context).size.width/1.5,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.type == 2 ? true : false,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: FileVideoPlayer(
                        width: MediaQuery.of(context).size.width/1.5,
                        height: MediaQuery.of(context).size.width/1.5,
                        loaderPadding: EdgeInsets.all(95),
                        buttonPadding: EdgeInsets.only(top: 110, left: 110, ),
                        file: widget.file,
                        messageId: widget.messageId,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.text == '' ? false : true,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        widget.text,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: FontRefer.SansSerif,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            widget.time,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontFamily: FontRefer.SansSerif,
              fontSize: 10.0,
            ),
          )
        ],
      ),
    );
  }
}