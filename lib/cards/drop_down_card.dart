import 'package:flutter/material.dart';
import 'package:t_fit/utils/colors.dart';
import '../utils/style.dart';
import 'package:expandable/expandable.dart';
import 'dart:math' as math;
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class DropDownCard extends StatefulWidget {
  DropDownCard({this.title, this.widget});
  final String title;
  final Widget widget;
  @override
  _DropDownCardState createState() => _DropDownCardState();
}

class _DropDownCardState extends State<DropDownCard> {
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
                  padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.title,
                          style: StyleRefer.kTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
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