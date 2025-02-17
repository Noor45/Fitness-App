import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:t_fit/utils/strings.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  static const String ID = "/privacy_policy_screen";
  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  PDFDocument doc;
  Future<void> getFile() async {
    doc = await PDFDocument.fromAsset('assets/files/Privacy_Policy.pdf');
    setState(() {});
  }

  @override
  void initState() {
    getFile();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Text(StringRefer.dummyString),
            ),
          )
      ),
      // body: Container(
      //     child: doc == null ? Center(child: CircularProgressIndicator(color: ColorRefer.kRedColor,)) :
      //     PDFViewer(
      //         document: doc,
      //         scrollDirection: Axis.vertical,
      //         showIndicator : false,
      //         showPicker: false,
      //         showNavigation: false,
      //         zoomSteps: 2,
      //         progressIndicator: Center(child: CircularProgressIndicator(color: ColorRefer.kRedColor,))
      //         // enableSwipeNavigation: false,
      //     )
      // ),
    );
  }
}
