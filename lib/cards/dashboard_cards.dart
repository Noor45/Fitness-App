import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:t_fit/utils/fonts.dart';
import '../utils/colors.dart';
import '../utils/style.dart';
import 'dart:math' as math;
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class WeightHistoryCard extends StatelessWidget {
  WeightHistoryCard({this.day, this.weight, this.diff, this.note, this.color, this.onTap});
  final String day;
  final String diff;
  final String note;
  final String weight;
  final Color color;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor, width: 2))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(day, style: TextStyle(fontSize: 13)),
            Row(
              children: [
                Text(diff, style: TextStyle(fontSize: 13, color: color)),
                SizedBox(width: 10),
                Text(weight, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, )),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class WeightHistoryCardWithInfo extends StatelessWidget {
  WeightHistoryCardWithInfo({this.day, this.weight, this.diff, this.note, this.color});
  final String day;
  final String diff;
  final String note;
  final String weight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor, width: 2))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () async{
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        insetPadding: EdgeInsets.only(left: 20, right: 20,),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(shape: BoxShape.rectangle, color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.black, offset: Offset(0, 10), blurRadius: 10),]),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(top:10, right:10),
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    child: Icon(CupertinoIcons.clear_thick_circled, color: Colors.grey.withOpacity(0.4), size: 27,),
                                  ),
                                ),
                              ),
                              Container(
                                child: note == null ?
                                Center(
                                  child: Padding(
                                    padding:  EdgeInsets.only(bottom: 20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          CupertinoIcons.square_list,
                                          color: Colors.grey.withOpacity(0.4),
                                          size: 50,
                                        ),
                                        SizedBox(height: 6),
                                        AutoSizeText(
                                          'Empty',
                                          style: TextStyle(
                                              color: Colors.grey.withOpacity(0.4),
                                              fontFamily: FontRefer.OpenSans,
                                              fontSize: 20),
                                        )
                                      ],
                                    ),
                                  ),
                                ) :
                                Container(
                                  padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                                  child: Text(note == null ? '' : note, style: TextStyle(color: Colors.black)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 5, right: 10),
                  child: Icon(Icons.info_outlined, color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, size: 22),
                ),
              ),
              Text(day, style: TextStyle(fontSize: 13)),
            ],
          ),
          Row(
            children: [
              Text(diff, style: TextStyle(fontSize: 13, color: color)),
              SizedBox(width: 10),
              Text(weight, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, )),
            ],
          )
        ],
      ),
    );
  }
}


class WeightHistoryCardExpandable extends StatefulWidget {
  WeightHistoryCardExpandable({this.day, this.weight, this.widget, this.diff, this.color, this.dayColor});
  final String day;
  final String diff;
  final String weight;
  final Widget widget;
  final Color color;
  final Color dayColor;
  @override
  _WeightHistoryCardExpandableState createState() => _WeightHistoryCardExpandableState();
}

class _WeightHistoryCardExpandableState extends State<WeightHistoryCardExpandable> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return ExpandableNotifier(
        child: Column(
          children: <Widget>[
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: true,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapHeaderToExpand: true,
                  hasIcon: false,
                ),
                header: Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor, width: 2))
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.day, style: TextStyle(fontSize: 15, color: widget.dayColor)),
                            Row(
                              children: [
                                Text(widget.diff, style: TextStyle(fontSize: 15, color: widget.color)),
                                SizedBox(width: 10),
                                Text(widget.weight, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, )),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      ExpandableIcon(
                        theme: ExpandableThemeData(
                          expandIcon: Icons.expand_more_outlined,
                          collapseIcon: Icons.expand_less_outlined,
                          iconSize: 28.0,
                          iconColor: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white,
                          iconRotationAngle: math.pi / 2,
                          iconPadding: EdgeInsets.only(right: 5),
                        ),
                      ),
                    ],
                  ),
                ),
                expanded: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: widget.widget,
                    ),
                  ],
                ),
                builder: (_, collapsed, expanded) {
                  return Expandable(
                    collapsed: collapsed,
                    expanded: expanded,
                    theme: const ExpandableThemeData(crossFadePoint: 0),
                  );
                }, collapsed: null,
              ),
            ),
          ],
        ));
  }
}


class ValueCard extends StatelessWidget {
  ValueCard({this.title1, this.title2, this.color});
  final Color color;
  final String title1;
  final String title2;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AutoSizeText(
          title1,
          style: StyleRefer.kTextStyle
              .copyWith(fontWeight: FontWeight.w900, fontSize: 13.5),
        ),
        AutoSizeText(
          title2,
          style: StyleRefer.kTextStyle.copyWith(color: color, fontWeight: FontWeight.w900, fontSize: 12),
        ),
      ],
    );
  }
}

class DaysCard extends StatelessWidget {
  DaysCard({this.title1, this.title2, this.color, this.check, this.currentDay, this.subtitle = '0', this.showSubtitle = false, this.positiveValue = false, this.space});
  final Color color;
  final String title1;
  final String title2;
  final String subtitle;
  final bool showSubtitle;
  final bool check;
  final bool positiveValue;
  final bool currentDay;
  final double space;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: space),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: check,
            child: Icon(
              Icons.check,
              color: ColorRefer.kRedColor,
            ),
          ),
          AutoSizeText(
            title1,
            style: StyleRefer.kTextStyle.copyWith(
                color: check == true
                    ? ColorRefer.kLightGreenColor
                    : color,
                fontWeight: FontWeight.w900,
                fontSize: 13.5),
          ),
          AutoSizeText(
            title2,
            style: StyleRefer.kTextStyle.copyWith(
                color: check == true
                    ? ColorRefer.kLightGreenColor
                    : color,
                fontWeight: FontWeight.w900,
                fontSize: 12),
          ),
          Visibility(
            visible: showSubtitle,
            child: AutoSizeText(
              int.parse(subtitle) == 0 ? '' : positiveValue == true ? '+ $subtitle' : subtitle,
              style: StyleRefer.kTextStyle.copyWith(
                  color: positiveValue == true ? Colors.red : Colors.orange,
                  fontWeight: FontWeight.w900,
                  fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  PlanCard({this.title, this.subtitle, this.image, this.onPressed});
  final String image;
  final String title;
  final String subtitle;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final theme = Provider.of<DarkThemeProvider>(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: Column(
          children: [
            Container(
              width: width,
              height: width / 2.5,
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                image: DecorationImage(image: ExactAssetImage(image), fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(theme.lightTheme == true ? 0.3 : 0.5), BlendMode.darken)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    title,
                    style: StyleRefer.kTextStyle
                        .copyWith(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22),
                  ),
                  SizedBox(height: 2),
                  AutoSizeText(
                    subtitle,
                    style: StyleRefer.kTextStyle.copyWith(color: ColorRefer.kLightGreyColor, fontSize: 13),
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

class WeeklyChart extends StatelessWidget {
  WeeklyChart({this.calories, this.text1, this.text2, this.goal});
  final String text1;
  final String text2;
  final int calories;
  final int goal;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 15),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Center(
                        child: Text(calories.toString(),
                            style: StyleRefer.kTextStyle
                                .copyWith(fontWeight: FontWeight.bold, fontSize: 14))),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Center(
                        child: Text(text1,
                            style: StyleRefer.kTextStyle
                                .copyWith(fontWeight: FontWeight.bold, fontSize: 12))),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Center(
                        child: Text(goal.toString(),
                            style: StyleRefer.kTextStyle
                                .copyWith(fontWeight: FontWeight.bold, fontSize: 14))),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Center(
                        child: Text(text2,
                            style: StyleRefer.kTextStyle
                                .copyWith(fontWeight: FontWeight.bold, fontSize: 12))),
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

class EmptyDashboard extends StatelessWidget {
  EmptyDashboard({this.title, this.subTitle});
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    double height = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: height / 4, left: 30, right: 30),
      child: Column(
        children: [
          SvgPicture.asset('assets/icons/wait.svg'),
          SizedBox(height: 8),
          AutoSizeText(
            title,
            style: StyleRefer.kTextStyle
                .copyWith(color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 17, fontWeight: FontWeight.w900),
          ),
          AutoSizeText(
            subTitle,
            textAlign: TextAlign.center,
            style: StyleRefer.kTextStyle
                .copyWith(height: 1.5, color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontWeight: FontWeight.w900),
          )
        ],
      ),
    );
  }
}

class BottomCard extends StatefulWidget {
  BottomCard({this.onTap, this.title, this.subTitle});
  final Function onTap;
  final String title;
  final String subTitle;
  @override
  _BottomCardState createState() => _BottomCardState();
}

class _BottomCardState extends State<BottomCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
        decoration: BoxDecoration(
          color: theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: StyleRefer.kTextStyle
                      .copyWith(color: ColorRefer.kRedColor, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  widget.subTitle,
                  style: StyleRefer.kTextStyle
                      .copyWith(color: ColorRefer.kLightColor, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SvgPicture.asset('assets/icons/arrow.svg'),
          ],
        ),
      ),
    );
  }
}

class GraphSign extends StatelessWidget {
  GraphSign({this.color, this.onTap, this.icon});
  final Color color;
  final Function onTap;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.all(Radius.circular(5))),
          padding: EdgeInsets.all(7),
          child: SvgPicture.asset(icon, color: Colors.white, height: 18, width: 18)),
    );
  }
}
