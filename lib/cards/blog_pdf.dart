import 'dart:async';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:t_fit/database/local_storage_function.dart';
import 'package:t_fit/utils/colors.dart';
import 'package:t_fit/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFCard extends StatefulWidget {
  static const String ID = "/pdf_screen";
  @override
  _PDFCardState createState() => _PDFCardState();
}

class _PDFCardState extends State<PDFCard> with WidgetsBindingObserver {
  PDFDocument doc;
  Future<void> getFile() async {
    doc = await PDFDocument.fromURL(Constants.pdfPath);
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
        title: Text('File'),
      ),
      body: Container(
        child: doc == null ? Center(child: CircularProgressIndicator(color: ColorRefer.kRedColor,)) :
        PDFViewer(document: doc)
      ),
    );
  }
}
