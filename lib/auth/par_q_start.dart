import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../screens/par_q_screens/par_q_screen.dart';
import '../utils/colors.dart';
import '../utils/fonts.dart';
import '../utils/strings.dart';
import '../widgets/round_button.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class PARQStartScreen extends StatefulWidget {
  static String ID = "/parq_start_screen";
  @override
  _PARQStartScreenState createState() => _PARQStartScreenState();
}

class _PARQStartScreenState extends State<PARQStartScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
      body: SafeArea(
          child: Container(
            width: width,
            height: height,
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              'PAR-Q & You',
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: FontRefer.OpenSans,
                  color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white,
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(height: 10),
            AutoSizeText(
              StringRefer.kPARQStartString,
              style: TextStyle(
                fontSize: 14.5,
                height: 1.3,
                color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white,
                fontFamily: FontRefer.OpenSans,
              ),
            ),
            SizedBox(height: 30),
            ButtonWithIcon(
                title: 'Let\'s Start',
                buttonRadius: 5,
                colour: ColorRefer.kRedColor,
                height: 40,
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, PARQScreen.ID, (route) => false);
                }),
          ],
        ),
      )),
    );
  }
}
