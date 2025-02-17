import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:t_fit/models/mental_health_model/mental_health_model.dart';
import 'package:t_fit/utils/fonts.dart';
import 'package:t_fit/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';


class ReadArticle extends StatefulWidget {
  static String ID = "/read_article_screen";
  @override
  _ReadArticleState createState() => _ReadArticleState();
}

class _ReadArticleState extends State<ReadArticle> {
  int views = 0;
  MentalHealthModel detail = MentalHealthModel();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    detail = ModalRoute.of(context).settings.arguments;
    final theme = Provider.of<DarkThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width,
                  height: height/4,
                  padding: EdgeInsets.only(left: 10, top: 10),
                  decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(detail.fileUrl), fit: BoxFit.fill)),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Container(
                      child: IconButton(icon: Platform.isIOS ? Icon(Icons.arrow_back_ios_sharp) : Icon(Icons.arrow_back_rounded),
                          color: theme.lightTheme == true ? Colors.black : Colors.white, onPressed: (){ Navigator.pop(context); },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 18, right: 20, top: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            detail.title,
                            style: TextStyle(
                                fontFamily: FontRefer.OpenSans,
                                fontSize: 17,
                                fontWeight: FontWeight.w900,
                                color: theme.lightTheme == true ? Colors.black : Colors.white,
                                height: 1.4
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: detail.tags == null || detail.tags.length == 0
                                  ? [Container()]
                                  : detail.tags.mapIndexed((e, index){
                                if(index > 3){
                                  return Container();
                                }else{
                                  return Visibility(
                                    visible: true,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10),
                                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                          color: Color(0xff918CEF)
                                      ),
                                      child: AutoSizeText(
                                        e,
                                        style: TextStyle(
                                            fontFamily: FontRefer.OpenSans,
                                            fontSize: 10,
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              }).toList(),
                            ),
                          ),
                          SizedBox(height: 15),
                          Html(
                            data: detail.description,
                            style: {
                              "p": Style(
                                  width: MediaQuery.of(context).size.width, fontSize: FontSize.large, fontFamily: FontRefer.OpenSans, color: theme.lightTheme == true ? Colors.black : Colors.white,
                                  margin: EdgeInsets.all(0), padding: EdgeInsets.all(0)
                              ),
                              "div": Style(
                                  width: MediaQuery.of(context).size.width, fontSize: FontSize.large, fontFamily: FontRefer.OpenSans, color: theme.lightTheme == true ? Colors.black : Colors.white,
                                  margin: EdgeInsets.all(0), padding: EdgeInsets.all(0)
                              ),
                            },
                            onLinkTap: (url, context, map, element){},
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
