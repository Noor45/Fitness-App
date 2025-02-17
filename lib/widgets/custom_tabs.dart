import 'package:flutter/material.dart';
import '../utils/fonts.dart';

class CustomTabs extends StatelessWidget {
  final String title;
  final Color selectionColor;
  final Color barColor;
  final Function onSelect;
  final EdgeInsetsGeometry padding;
  final double width;
  final double fontSize;
  final Color backColor;
  const CustomTabs({
    Key key,
    this.title,
    this.selectionColor,
    this.onSelect,
    this.barColor,
    this.padding,
    this.backColor,
    this.width,
    this.fontSize,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        decoration: BoxDecoration(
            color: backColor,
            border: Border(bottom: BorderSide(color: barColor, width: 2))
        ),
        padding: this.padding,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: this.selectionColor, fontSize: this.fontSize ?? 16, fontWeight: FontWeight.w400, fontFamily: FontRefer.SansSerif),
          ),
        ),
      ),
    );
  }
}