import 'package:flutter/material.dart';
import '../utils/style.dart';

class TextCard extends StatelessWidget {
  TextCard({this.text, this.size, this.color});
  final String text;
  final double size;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: StyleRefer.kTextStyle.copyWith(
          color: color,
          fontWeight: FontWeight.w900,
          fontSize: size,
          height: 1.5
      ),
    );
  }
}
