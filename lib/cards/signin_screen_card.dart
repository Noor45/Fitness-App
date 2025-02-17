import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class SocialMediaIcons extends StatefulWidget {
  SocialMediaIcons({this.icon, this.color, this.onPressed});
  final Color color;
  final String icon;
  final Function onPressed;
  @override
  _SocialMediaIconsState createState() => _SocialMediaIconsState();
}

class _SocialMediaIconsState extends State<SocialMediaIcons> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return InkWell(
      onTap: widget.onPressed,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        child: Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: theme.lightTheme == true ? Colors.white : Colors.white12,
              shape: BoxShape.circle,
            ),
            child: Container(
                child: SvgPicture.asset(
              widget.icon,
              width: 20,
              height: 20,
            ))),
      ),
    );
  }
}
