import 'dart:io';
import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_fit/controllers/general_controller.dart';
import 'package:t_fit/models/user_model/chat_thread_model.dart';
import 'package:t_fit/widgets/confirm_box.dart';
import 'package:t_fit/widgets/main_bottom_sheet.dart';
import '../../cards/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/user_model/get_staff_user_model.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';
import '../../utils/constants.dart';
import '../../models/user_model/chat_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class ChatScreen extends StatefulWidget {
  static const String ID = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ProgressDialog pr;
  GetStaffUserModel instructor;
  var kMessageTextFieldDecoration;
  final _firestore = FirebaseFirestore.instance;
  final messageTextController = TextEditingController();
  String messageText;
  File file;
  int type = 0;
  bool sendFile = false;
  String threadId;
  bool _isLoading = false;
  File selectedFile;
  final picker = ImagePicker();
  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  String createChatKey(String uid1, String uid2) {
    if (uid1.compareTo(uid2) > 0) {
      return uid1 + "_" + uid2;
    }else{
      return uid2 + "_" + uid1;
    }
  }
  void pickImage(ImageSource imageSource, DarkThemeProvider theme) async {
    XFile galleryImage = await picker.pickImage(source: imageSource, imageQuality: 15);
    setState(() {
      if (galleryImage != null) {
        file = File(galleryImage.path);
        if(sendFile == false){
          messageText = '';
          file = file;
          type = 1;
          sendMessageFile();
        }
      }
    });
  }
  void pickVideo(ImageSource videoSource, DarkThemeProvider theme) async {
    await picker.pickVideo(source: videoSource).then((value) async{
      if (value != null) {
        file = File(value.path);
        if(sendFile == false){
            messageText = '';
            file = file;
            type = 2;
            sendMessageFile();
        }
      }
    });
  }

  void initState() {
    pr = ProgressDialog(context);
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.style(
        message: 'Uploading file...',
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(color: Colors.red),
    );

    super.initState();
  }

  getData(List args, DarkThemeProvider theme){
    if(sendFile == false){
      if(args[1] == 1){
        var detail = args[2];
        messageText = detail['text'];
        file = detail['file'];
        type = detail['type'];
        sendMessageFile();
      }
    }
    kMessageTextFieldDecoration = InputDecoration(
      fillColor: ColorRefer.kGreyColor,
      filled: true,
      hintStyle: TextStyle(
          fontSize: 14,
          fontFamily: FontRefer.SansSerif,
          color: theme.lightTheme == true ? Colors.white : ColorRefer.kDarkColor),
      contentPadding: EdgeInsets.only(left: 15),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorRefer.kGreyColor, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorRefer.kGreyColor, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorRefer.kGreyColor, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorRefer.kGreyColor, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    List args = ModalRoute.of(context).settings.arguments;
    instructor = args[0];
    threadId = createChatKey(instructor.id, AuthController.currentUser.uid);
    getData(args, theme);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, statusBarBrightness: theme.lightTheme == true ? Brightness.dark : Brightness.light),
      child: ModalProgressHUD(
        inAsyncCall: _isLoading,
        progressIndicator: CircularProgressIndicator(backgroundColor: ColorRefer.kRedColor),
        child: Scaffold(
          backgroundColor: theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBackgroundColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 50, 10, 0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width/3,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Platform.isIOS == true ? Icons.arrow_back_ios : Icons.arrow_back,
                                size: 25,
                                color: Colors.white,
                              ),
                              onPressed: (){
                                Navigator.pop(context);
                              },
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 0, right: 10),
                              child: ClipRRect(
                                child:  instructor.image == null ?
                                Image.asset('assets/images/user.png', width: 35, height: 35, fit: BoxFit.fill) :
                                FadeInImage.assetNetwork(placeholder: 'assets/images/user.png', image: instructor.image, width: 40, height: 40, fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(right: 35),
                                  child: AutoSizeText(
                                    instructor.job == 'admin' ? 'Support Team' : instructor.name.capitalize(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: FontRefer.SansSerif,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Visibility(
                                  visible:instructor.job == 'admin' ? false : true ,
                                  child: Row(
                                    children: [
                                      Icon(Icons.circle, size: 12, color: instructor.onlineStatus == 0 ? Colors.orange : Colors.green,),
                                      SizedBox(width: 5),
                                      AutoSizeText(
                                        instructor.onlineStatus == 0 ? 'Away':'Active now',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: FontRefer.SansSerif,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: (){
                            return showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                                    child: Container(
                                      height: 250,
                                      child: CameraVideoBottomSheet(
                                        cameraClick: () => pickImage(ImageSource.camera, theme),
                                        galleryClick: () => pickVideo(ImageSource.camera, theme),
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Icon(
                            FontAwesomeIcons.ellipsisV,
                            size: 20,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 8,
                            blurRadius: 7,
                            offset: Offset(0, 6)
                        ),
                      ],
                    ),
                    child: Container(
                      padding: EdgeInsets.only(bottom:6),
                      child: Column(
                        children: [
                          MessagesStream(
                              this.threadId,
                              instructor.name,
                              instructor.id,
                          ),
                          Expanded(
                            flex: 0,
                            child: Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  color: ColorRefer.kGreyColor,
                                  borderRadius:BorderRadius.all(Radius.circular(30))
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: TextField(
                                      controller: messageTextController,
                                      onChanged: (value) {
                                        setState(() {
                                          messageText = value;
                                        });
                                      },
                                      style: TextStyle(
                                          color: ColorRefer.kDarkColor),
                                      decoration: kMessageTextFieldDecoration.copyWith(
                                          hintText: 'Type a message...'
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: (){
                                        sendMessage();
                                      },
                                      child: SendButton()
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  sendMessage() async {
    print('text send');
    if(messageTextController.text != null && messageTextController.text.isNotEmpty){
      AppMessages message = AppMessages();
      AppMessagesThread storeThread = AppMessagesThread();
      message.threadId = this.threadId; storeThread.threadId = this.threadId;
      message.senderId = AuthController.currentUser.uid; storeThread.senderId = AuthController.currentUser.uid;
      message.type = 0; storeThread.type = 0;
      message.message = messageTextController.text; storeThread.lastMessage = messageTextController.text;
      message.receiverId = instructor.id; storeThread.name = instructor.name;
      storeThread.chatListUsers.add(message.receiverId);
      storeThread.chatListUsers.add(message.senderId);
      message.time = Timestamp.now(); storeThread.lastMessageTime = Timestamp.now();
      message.file = null;
      message.id = getRandomString(16).substring(2);
      messageTextController.clear();
      await _firestore.collection('messages').doc(message.id).set(message.toMap());
      _firestore.collection('threads').doc(this.threadId).set(storeThread.toMap());

    }
  }

  sendMessageFile() async {
    print('file send');
      if(file != null){
        _loader();
        sendFile = true;
        AppMessages message = AppMessages();
        AppMessagesThread storeThread = AppMessagesThread();
        message.threadId = this.threadId; storeThread.threadId = this.threadId;
        message.senderId = AuthController.currentUser.uid; storeThread.senderId = AuthController.currentUser.uid;
        message.type = type; storeThread.type = type;
        message.message = messageText; storeThread.lastMessage = messageTextController.text;
        message.receiverId = instructor.id; storeThread.name = instructor.name;
        storeThread.chatListUsers.add(message.receiverId);
        storeThread.chatListUsers.add(message.senderId);
        message.id = getRandomString(16).substring(2);
        messageTextController.clear();
        message.time = Timestamp.now(); storeThread.lastMessageTime = Timestamp.now();
        if(type != 0) message.file = await GeneralController.uploadChatFile(file, this.threadId);
        await _firestore.collection('messages').doc(message.id).set(message.toMap());
        _firestore.collection('threads').doc(this.threadId).set(storeThread.toMap());
        Navigator.pop(context);
        sendFile = false;
      }
  }

  _loader() async {
    WidgetsBinding.instance.addPostFrameCallback((_){
       showDialog(
          context: context,
          builder: (BuildContext context) {
              return ProgressDialogBox();
          },
        );
    });
  }
}



class SendButton extends StatefulWidget {
  @override
  _SendButtonState createState() => _SendButtonState();
}

class _SendButtonState extends State<SendButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      margin: EdgeInsets.only(right: 15),
      padding: EdgeInsets.all(8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorRefer.kRedColor
      ),
      child: SvgPicture.asset('assets/icons/send.svg'),
    );
  }
}