import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:t_fit/utils/constants.dart';
import 'package:t_fit/utils/fonts.dart';
import '../../utils/colors.dart';
import '../../utils/style.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class AlarmCard extends StatelessWidget {
  AlarmCard({this.title, this.onPressed});
  final String title;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return  Card(
      elevation: 7,
      color: theme.lightTheme == true ? Colors.white : ColorRefer.kBoxColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: width,
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 15),
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/alarm.svg',
                width: 30,
                height: 30,
                color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : Colors.white,
              ),
              SizedBox(width: 10),
              Text(
                title,
                style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : Colors.white, fontWeight: FontWeight.w900, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WrittenBlogCard extends StatelessWidget {
  WrittenBlogCard({this.title, this.images, this.tag, this.showDes, this.onTap, this.localImage = false});
  final String images;
  final String title;
  final bool showDes;
  final bool localImage;
  final List tag;
  final Function onTap;

  String shortTitle(String title){
    if (title.length > 30) {
      return title.substring(0, 30)+'...';
    }else{
      return title;
    }
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width/1.6,
        margin: EdgeInsets.only(right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: width/2.5,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(image: localImage == true ? AssetImage(images) : NetworkImage(images), fit: BoxFit.fill)
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: tag == null || tag.length == 0
                    ? [Container()]
                    : tag.mapIndexed((e, index){
                  if(index > 3){
                    return Container();
                  }else{
                    return Visibility(
                      visible: showDes,
                      child: Container(
                        margin: EdgeInsets.only(top: 10, right: 5),
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
            SizedBox(height: 10),
            AutoSizeText(
              shortTitle(title),
              style: TextStyle(
                  fontFamily: FontRefer.OpenSans,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: theme.lightTheme == true ? Colors.black : Colors.white
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ReadingBlogCard extends StatelessWidget {
  ReadingBlogCard({this.title, this.des, this.onTap});
  final String des;
  final String title;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1.0, color: ColorRefer.kLightGreyColor))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                'Topic:  $title',
                style: TextStyle(
                    fontFamily: FontRefer.OpenSans,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                ),
              ),
            ],
          ),
        ),
    );
  }
}


class AudioBlogCard extends StatelessWidget {
  AudioBlogCard({this.text, this.images, this.height, this.width, this.radius, this.onTap});
  final double width;
  final double height;
  final String images;
  final String text;
  final Function onTap;
  final BorderRadius radius;

  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: theme.lightTheme == true ? ColorRefer.kLightGreyColor: ColorRefer.kBoxColor,
            borderRadius: radius,
        ),
        child: Stack(
          children: <Widget>[
            SvgPicture.asset(
              'assets/icons/player.svg',
              color: ColorRefer.kPinkColor,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: AutoSizeText(
                      text,
                      style: TextStyle(
                          fontFamily: FontRefer.OpenSans,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: SvgPicture.asset(
                      'assets/icons/song.svg',
                      width: 40,
                      height: 40,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BelowCard extends StatelessWidget {
  BelowCard({this.image, this.text, this.tag, this.onTap});
  final String text;
  final String image;
  final String tag;
  final Function onTap;
  String shortTitle(String title){
    if (title.length > 30) {
      return title.substring(0, 30)+'...';
    }else{
      return title;
    }
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        padding: EdgeInsets.only(bottom: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: width/4.5,
              width: width/4.5,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(image: NetworkImage(image), fit: BoxFit.fill)
              ),
            ),
            SizedBox(width: 10),
            Container(
              width: width/1.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                  shortTitle(text),
                    style: TextStyle(
                        fontFamily: FontRefer.OpenSans,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: theme.lightTheme == true ? Colors.black : Colors.white
                    ),
                  ),
                  SizedBox(height: 2),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color(0xff918CEF)
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        fontFamily: FontRefer.OpenSans,
                        fontSize: 8,
                        color: Colors.white
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}


