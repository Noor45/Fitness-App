import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WorkoutCard extends StatefulWidget {
  WorkoutCard({this.onPressed, this.title, this.icon, this.color, this.textColor});
  final String icon;
  final String title;
  final Color textColor;
  final Color color;
  final Function onPressed;
  @override
  _WorkoutCardState createState() => _WorkoutCardState();
}

class _WorkoutCardState extends State<WorkoutCard> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        width: width / 2.3,
        height: height / 4,
        padding: EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 15),
                Center(child: SvgPicture.asset(widget.icon)),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: AutoSizeText(
                  widget.title,
                  style: TextStyle(color: widget.textColor, fontWeight: FontWeight.bold, fontSize: 14.5)
              ),
            ),
          ],
        ),
      ),
    );
  }
}