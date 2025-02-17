import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/style.dart';
import '../../widgets/round_button.dart';
import 'package:toast/toast.dart';
import '../../utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';
import 'package:file_picker/file_picker.dart';

class PARQAttachmentScreen extends StatefulWidget {
  static const String ID = "/parq_attachment_screen";
  @override
  _PARQAttachmentScreenState createState() => _PARQAttachmentScreenState();
}

class _PARQAttachmentScreenState extends State<PARQAttachmentScreen> {
  String firstFile = '';
  String secondFile = '';
  String thirdFile = '';
  bool _isLoading = false;
  bool saved = false;
  List<dynamic> files = [];
  @override
  void initState() {
    if(AuthController.currentUser.reports.isNotEmpty){
       AuthController.currentUser.reports.forEach((e) {
        if(e['type'] == 0){
          firstFile = e['name'];
        }
        if(e['type'] == 1){
          secondFile = e['name'];
        }
        if(e['type'] == 2){
          thirdFile = e['name'];
        }
      });
    }
    super.initState();
  }

   attachFile() async{
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    return result;
  }

  @override
  void dispose() {
    saved = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      progressIndicator: Theme(
        data: Theme.of(context).copyWith(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorRefer.kRedColor)),
        child: CircularProgressIndicator(),
      ),
      child: Scaffold(
        backgroundColor: theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
        appBar: AppBar(
          elevation: theme.lightTheme == true ? 3 : 0,
          iconTheme: IconThemeData(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
          systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
          centerTitle: true,
          title: Text(
            'PAR-Q & You',
            style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 14),
          ),
        ),
        body: SafeArea(
            child: Container(
              width: width,
              height: height,
              padding: EdgeInsets.only(left: 5, right: 5, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                        child: AutoSizeText(
                          'Attach Medical Information.',
                          style: StyleRefer.kTextStyle
                              .copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 8),
                        child: AutoSizeText(
                          'Attach medical document.',
                          style: StyleRefer.kTextStyle
                              .copyWith(color: ColorRefer.kPinkColor, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      FileAttachmentCard(
                        title: 'Tap to attach your medical history report',
                        doc: firstFile,
                        onCancel: (){
                          setState(() {
                            firstFile = '';
                            saved = true;
                            if(AuthController.currentUser.reports.length >= 1)
                            AuthController.currentUser.reports.removeWhere((element) => element['type'] == 0);
                          });
                        },
                        onTap: () async{
                          FilePickerResult result = await attachFile();
                          File file;
                          if (result != null) {
                            file = File(result.files.single.path);
                            PlatformFile detail = result.files.first;
                            setState(() {
                              saved = true;
                              firstFile = detail.name;
                              files.removeWhere((element) => element['type'] == 0);
                              files.add({
                                'type': 0,
                                'file': file,
                                'name': firstFile
                              });
                            });
                          }
                        },
                      ),
                      FileAttachmentCard(
                        title: 'Tap to attach your Blood Sugar report',
                        doc: secondFile,
                        onCancel: (){
                          setState(() {
                            saved = true;
                            secondFile = '';
                            if(AuthController.currentUser.reports.length >= 2)
                            files.removeWhere((element) => element['type'] == 1);
                          });
                        },
                        onTap: () async{
                          FilePickerResult result = await attachFile();
                          File file;
                          if (result != null) {
                            file = File(result.files.single.path);
                            PlatformFile detail = result.files.first;
                            setState(() {
                              saved = true;
                              secondFile = detail.name;
                              files.removeWhere((element) => element['type'] == 1);
                              files.add({
                                'type': 1,
                                'file': file,
                                'name': secondFile
                              });
                            });
                          }
                        },
                      ),
                      FileAttachmentCard(
                        title: 'Tap to attach your COVID-19 test report',
                        doc: thirdFile,
                        onCancel: (){
                          setState(() {
                            saved = true;
                            thirdFile = '';
                            if(AuthController.currentUser.reports.length >= 2)
                            files.removeWhere((element) => element['type'] == 2);
                          });
                        },
                        onTap: () async{
                          FilePickerResult result = await attachFile();
                          File file;
                          if (result != null) {
                            file = File(result.files.single.path);
                            PlatformFile detail = result.files.first;
                            setState(() {
                              saved = true;
                              thirdFile = detail.name;
                              files.removeWhere((element) => element['type'] == 2);
                              files.add({
                                'type': 2,
                                'file': file,
                                'name': thirdFile
                              });
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: ButtonWithIcon(
                        title: 'Done',
                        buttonRadius: 5,
                        colour: ColorRefer.kRedColor,
                        height: 35,
                        onPressed: () async{
                          if(saved == true){
                            if(files.isNotEmpty){
                              setState(() {
                                _isLoading = true;
                              });
                              await Future.wait(
                                  files.map((e) async{
                                    await AuthController().updateUserReportFiles(e['file'], e['name'], e['type'], true);
                                  })
                              ).then((value) => AuthController().updateUserFields());
                              setState(() {
                                _isLoading = false;
                              });
                            }else{
                              AuthController().updateUserFields();
                            }
                            saved = false;
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Toast.show("Saved", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                          }
                          else{
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                        }
                    ),
                  ),

                ],
              ),
            )),
      ),
    );
  }
}

class FileAttachmentCard extends StatefulWidget {
  FileAttachmentCard({this.onTap, this.title, this.doc, this.onCancel,});
  final Function onTap;
  final String title;
  final String doc;
  final Function onCancel;
  @override
  _FileAttachmentCardState createState() => _FileAttachmentCardState();
}

class _FileAttachmentCardState extends State<FileAttachmentCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
          decoration: BoxDecoration(
            color: theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: InkWell(
            onTap: widget.onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: StyleRefer.kTextStyle.copyWith(color: ColorRefer.kLightColor, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Attach PDF file',
                        style: StyleRefer.kTextStyle.copyWith(color: ColorRefer.kLightColor, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                Icon(CupertinoIcons.paperclip, color: ColorRefer.kLightColor,),
              ],
            ),
          ),
        ),
        Visibility(
          visible: widget.doc == '' ? false : true,
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Text(
                  widget.doc,
                  style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kLightColor, fontSize: 12),
                ),
                IconButton(icon: Icon(Icons.cancel_rounded, color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kLightColor, size: 15), onPressed: widget.onCancel)
              ],
            ),
          ),
        )
      ],
    );
  }
}
