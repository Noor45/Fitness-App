import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/colors.dart';
import '../utils/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatefulWidget {
  RoundedButton(
      {this.title, this.colour, this.height, this.fontSize, @required this.onPressed, this.buttonRadius});

  final Color colour;
  final String title;
  final double height;
  final double buttonRadius;
  final Function onPressed;
  final double fontSize;
  @override
  _RoundedButtonState createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: widget.onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.buttonRadius),
      ),
      highlightElevation: 0,
      height: widget.height,
      elevation: 0,
      color: widget.colour,
      minWidth: MediaQuery.of(context).size.width,
      child: Text(
        widget.title,
        style: TextStyle(color: Colors.white, fontSize: widget.fontSize ?? 13, fontFamily: FontRefer.OpenSans),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  SubmitButton({this.title, this.colour, this.height, this.width, this.buttonRadius, @required this.onPressed});

  final Color colour;
  final String title;
  final double height;
  final double width;
  final double buttonRadius;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          height: height,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class ButtonWithOutline extends StatelessWidget {
  ButtonWithOutline(
      {this.title,
      this.colour,
      this.radius,
      this.height,
      this.textColor,
      this.borderColor,
      @required this.onPressed});
  final Color colour;
  final String title;
  final Function onPressed;
  final Color borderColor;
  final Color textColor;
  final double radius;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: height,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: borderColor, width: 2.0),
            left: BorderSide(color: borderColor, width: 2.0),
            right: BorderSide(color: borderColor, width: 2.0),
            bottom: BorderSide(color: borderColor, width: 2.0),
          ),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: textColor,
              ),
            ),
            SizedBox(width: 12),
            SvgPicture.asset('assets/icons/video_camera.svg')
          ],
        ),
      ),
    );
  }
}


class ButtonWithIcon extends StatelessWidget {
  ButtonWithIcon(
      {this.title, this.colour, this.height, @required this.onPressed, this.buttonRadius});

  final Color colour;
  final String title;
  final double height;
  final Function onPressed;
  final double buttonRadius;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: colour,
      borderRadius: BorderRadius.circular(buttonRadius),
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: MediaQuery.of(context).size.width,
        child: Container(
          height: height,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ' ',
                style: TextStyle(
                  color: ColorRefer.kRedColor,
                ),
              ),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontFamily: FontRefer.OpenSans),
              ),
              Icon(
                CupertinoIcons.arrow_right,
                color: Colors.white,
                size: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
