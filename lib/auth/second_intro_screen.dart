import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../auth/signin_screen.dart';
import '../utils/colors.dart';
import '../utils/strings.dart';
import '../utils/style.dart';
import '../widgets/round_button.dart';

class SecondIntroScreen extends StatefulWidget {
  static String secondScreenId = "/second_intro_screen";
  @override
  _SecondIntroScreenState createState() => _SecondIntroScreenState();
}

class _SecondIntroScreenState extends State<SecondIntroScreen> {
  EdgeInsets paddingValues = EdgeInsets.fromLTRB(20, 0, 20, 0);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        body: Container(
          width: width,
          height: height,
          padding: paddingValues,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(StringRefer.artwork1),
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
              )),
          child: Container(
            width: width,
            height: width/1.2,
            margin: EdgeInsets.only(bottom: 40),
            padding: EdgeInsets.fromLTRB(12, 25, 12, 25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(35)),
            ),
            child: Column(
              children: [
                AutoSizeText(
                    StringRefer.kIntroTitle2,
                    textAlign: TextAlign.center,
                    style: StyleRefer.kTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.black, height: 1.5)
                ),
                SizedBox(height: 10),
                AutoSizeText(
                    StringRefer.kIntroSubtitle2,
                    textAlign: TextAlign.center,
                    style: StyleRefer.kTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w700, color: ColorRefer.kLightGreyColor)
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(left: 50, right: 50),
                  child: RoundedButton(
                      title: 'Done',
                      buttonRadius: 30,
                      colour: ColorRefer.kRedColor,
                      height: 50,
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, SignInScreen.signInScreenID, (route) => false);
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
