import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t_fit/cards/mind_fullness_card.dart';
import 'package:t_fit/models/mental_health_model/mental_health_model.dart';
import 'package:t_fit/screens/mental_health_screens/read_article_sceen.dart';
import '../../utils/colors.dart';
import '../../utils/style.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class WrittenBlogScreen extends StatefulWidget {
  static const String ID = "/written_blog_screen";
  @override
  _WrittenBlogScreenState createState() => _WrittenBlogScreenState();
}

class _WrittenBlogScreenState extends State<WrittenBlogScreen> {
  List<MentalHealthModel> writtenBlogList = [];
  @override
  Widget build(BuildContext context) {
    writtenBlogList = ModalRoute.of(context).settings.arguments;
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
        backgroundColor: theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
        appBar: AppBar(
          elevation: theme.lightTheme == true ? 3 : 0,
          iconTheme: IconThemeData(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
          systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
          centerTitle: true,
          title: Text(
            'Read Blogs',
            style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 14),
          ),
        ),
        body: SafeArea(
          child: Container(
              padding: EdgeInsets.only(top: 30, left: 15, right: 15),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: writtenBlogList == null || writtenBlogList.length == 0
                    ? [Container()]
                    : writtenBlogList.map((e){
                  return Column(
                    children: [
                      BelowCard(
                        text: e.title,
                        image: e.fileUrl,
                        tag: e.tags[0],
                        onTap: () {
                          Navigator.pushNamed(context, ReadArticle.ID, arguments: e);
                        },
                      ),
                    ],
                  );
                }).toList(),
              ),
          ),
        )
    );
  }
}



