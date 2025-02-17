import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../auth/select_age_screen.dart';
import '../utils/colors.dart';
import '../utils/fonts.dart';
import '../utils/strings.dart';
import '../widgets/round_button.dart';
import 'package:provider/provider.dart';
import '../services/theme_model.dart';

class StartScreen extends StatefulWidget {
  static String ID = "/start_screen";
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
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
          padding: EdgeInsets.only(left: 25, right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                'Get Started',
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: FontRefer.OpenSans,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 5),
              AutoSizeText(
                'with T-Fit',
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: FontRefer.OpenSans,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 10),
              AutoSizeText(
                StringRefer.kStartString,
                style: TextStyle(
                  fontSize: 14.5,
                  height: 1.3,
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
                    Navigator.pushNamed(context, SelectAge.ID);
                  }),
            ],
          ),
      )),
    );
  }
}
