import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:t_fit/models/mental_health_model/mental_health_model.dart';
import 'package:t_fit/utils/fonts.dart';
import 'package:t_fit/utils/constants.dart';

class MindFullnessReadingScreen extends StatefulWidget {
  static String ID = "/mindfulness_reading_screen";
  @override
  _MindFullnessReadingScreenState createState() => _MindFullnessReadingScreenState();
}

class _MindFullnessReadingScreenState extends State<MindFullnessReadingScreen> {
  int views = 0;
  MentalHealthModel detail = MentalHealthModel();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    detail = ModalRoute.of(context).settings.arguments;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Container(
            height: height,
            width: width,
            child: Stack(
              children: <Widget>[
                Image.asset(
                  'assets/images/bg.png',
                  alignment: Alignment.center,
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                          AutoSizeText(
                            Constants.mentalHealthBlog.title,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: FontRefer.SansSerif,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 20)
                        ],
                      ),
                      SizedBox(height: 20),
                      Html(
                        data: Constants.mentalHealthBlog.description,
                        style: {
                          "p": Style(
                              width: MediaQuery.of(context).size.width, fontSize: FontSize.large,
                              color: Colors.white, margin: EdgeInsets.all(0), padding: EdgeInsets.all(0)
                          ),
                          "div": Style(
                              width: MediaQuery.of(context).size.width, fontSize: FontSize.large,
                              color: Colors.white, margin: EdgeInsets.all(0), padding: EdgeInsets.all(0)
                          ),
                        },
                        onLinkTap: (url, context, map, element){},
                      ),
                    ],
                  ),
                ),
              ],
            ),


            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Container(
            //       alignment: Alignment.topLeft,
            //       child: AutoSizeText(
            //         text,
            //         style: TextStyle(
            //             fontFamily: FontRefer.OpenSans,
            //             fontSize: 14,
            //             fontWeight: FontWeight.w600,
            //             color: Colors.white
            //         ),
            //       ),
            //     ),
            //     // Container(
            //     //   alignment: Alignment.center,
            //     //   child: SvgPicture.asset(
            //     //     'assets/icons/player.svg',
            //     //   ),
            //     // ),
            //     Container(
            //       alignment: Alignment.bottomRight,
            //       child: SvgPicture.asset(
            //         'assets/icons/song.svg',
            //         width: 30,
            //         height: 30,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ],
            // ),
          ),
      ),
    );
  }
}
