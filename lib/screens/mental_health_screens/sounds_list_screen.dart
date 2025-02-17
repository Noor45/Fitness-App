import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t_fit/cards/mind_fullness_card.dart';
import 'package:t_fit/models/mental_health_model/mental_health_model.dart';
import 'package:t_fit/screens/mental_health_screens/play_sound_screen.dart';
import '../../utils/colors.dart';
import '../../utils/style.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';



class SoundBlogScreen extends StatefulWidget {
  static const String ID = "/sound_blog_screen";
  @override
  _SoundBlogScreenState createState() => _SoundBlogScreenState();
}

class _SoundBlogScreenState extends State<SoundBlogScreen> {
  List<MentalHealthModel> soundBlogList = [];
  @override
  Widget build(BuildContext context) {
    soundBlogList = ModalRoute.of(context).settings.arguments;
    double width = MediaQuery.of(context).size.width;
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
        backgroundColor: theme.lightTheme == false ? Colors.white : ColorRefer.kBackgroundColor,
        appBar: AppBar(
          elevation: theme.lightTheme == false ? 3 : 0,
          iconTheme: IconThemeData(color: theme.lightTheme == false ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
          systemOverlayStyle: theme.lightTheme == false ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
          centerTitle: true,
          title: Text(
            'Sounds',
            style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == false ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 14),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 30, left: 15, right: 15),
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: soundBlogList == null || soundBlogList.length == 0
                  ? [Container()]
                  : soundBlogList.map((e){
                return Column(
                  children: [
                  AudioBlogCard(
                    height: width/3.5,
                    width: width,
                    onTap: (){
                      Navigator.pushNamed(context, PlaySoundScreen.ID, arguments: e);
                    },
                    radius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5), topRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
                    images: e.fileUrl,
                    text: e.title,

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