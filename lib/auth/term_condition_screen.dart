import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:t_fit/utils/strings.dart';
import 'package:flutter/material.dart';

class TermConditionScreen extends StatefulWidget {
  static const String ID = "/term_condition_screen";
  @override
  _TermConditionScreenState createState() => _TermConditionScreenState();
}

class _TermConditionScreenState extends State<TermConditionScreen> {
  PDFDocument doc;
  Future<void> getFile() async {
    doc = await PDFDocument.fromAsset('assets/files/Terms_Conditions.pdf');
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
        title: Text('Terms and Conditions'),
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
      //         progressIndicator: Center(child: CircularProgressIndicator(color: ColorRefer.kRedColor,))
      //     )
      // ),
    );
  }
}
