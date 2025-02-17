import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/colors.dart';
import '../utils/style.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';


class GoalCard extends StatefulWidget {
  GoalCard({this.onPressed, this.title, this.icon, this.color, this.select});
  final String icon;
  final bool select;
  final String title;
  final Color color;
  final Function onPressed;
  @override
  _GoalCardState createState() => _GoalCardState();
}

class _GoalCardState extends State<GoalCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        width: width / 2.6,
        height: height / 5.5,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(widget.icon, height: 60, width: 60,),
            SizedBox(height: 10),
            AutoSizeText(widget.title, textAlign: TextAlign.center,
                style: TextStyle(color: theme.lightTheme == true ? widget.select == true ? Colors.white : ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                    fontWeight: FontWeight.bold, fontSize: 12,
           )),
          ],
        ),
      ),
    );
  }
}

class CustomTabs extends StatelessWidget {
  CustomTabs({this.title, this.color, this.textColor, this.onTap});
  final String title;
  final Color color;
  final Color textColor;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Text(
          title,
          style: StyleRefer.kTextStyle.copyWith(color: textColor, fontSize: 13),
        ),
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  ImageCard({this.title, this.subtitle, this.image});
  final String image;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Image.asset(image, fit: BoxFit.fitWidth, width: width,
            color: Colors.black.withOpacity(theme.lightTheme == true ? 0.3 : 0.5),
            colorBlendMode: BlendMode.darken),
        Container(
          width: width,
          padding: EdgeInsets.only(top: width/5),
          alignment: Alignment.center,
          child: Column(
            children: [
              AutoSizeText(
                title,
                style: StyleRefer.kTextStyle.copyWith(color:  Colors.white, fontWeight: FontWeight.w900, fontSize: 20),
              ),
              SizedBox(height: 10),
              AutoSizeText(
                subtitle,
                style: StyleRefer.kTextStyle.copyWith(color: ColorRefer.kRedColor, fontWeight: FontWeight.w900, fontSize: 15),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class WeekCards extends StatefulWidget {
  WeekCards({this.onPressed, this.title, this.subtitle, this.icon, this.showSubtitle = true});
  final String title;
  final String icon;
  final String subtitle;
  final bool showSubtitle;
  final Function onPressed;
  @override
  _WeekCardsState createState() => _WeekCardsState();
}

class _WeekCardsState extends State<WeekCards> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: widget.onPressed,
            child: Container(
              width: width,
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border(
                  bottom: BorderSide(width: 1, color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : Colors.white),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(widget.icon),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        widget.title,
                        style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Visibility(
                        visible: widget.showSubtitle,
                        child: Container(
                          padding: EdgeInsets.only(top: 2),
                          child: AutoSizeText(
                            widget.subtitle,
                            style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GenderSelection extends StatefulWidget {
  GenderSelection({this.text, this.select, this.onPressed});
  final String text;
  final bool select;
  final Function onPressed;
  @override
  _GenderSelectionState createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        width: width/2.3,
        height: 45,
        alignment: Alignment.center,
        // padding: EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          color: widget.select == true ? ColorRefer.kNavyBlueColor: theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: AutoSizeText(
          widget.text,
          style: StyleRefer.kTextStyle.copyWith(
              fontSize: 14,
              color: theme.lightTheme == true ? widget.select == true ? Colors.white : Colors.black54  : Colors.white,
              fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}