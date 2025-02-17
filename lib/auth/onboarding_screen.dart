import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../auth/second_intro_screen.dart';
import '../utils/colors.dart';
import '../utils/strings.dart';
import '../utils/style.dart';
import '../widgets/round_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  static String firstScreenId = "/first_intro_screen";
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}
class _OnBoardingScreenState extends State<OnBoardingScreen> {
  EdgeInsets paddingValues = EdgeInsets.fromLTRB(20, 0, 20, 30);

  Future<void> _initIntroScreens() async {
    await LocalPreferences.preferences.setBool(LocalPreferences.OnBoardingScreensVisited, true);
    await LocalPreferences.preferences.setBool(LocalPreferences.Notification, true);
  }

  @override
  void initState() {
    _initIntroScreens();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
         statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        body: Container(
          width: width,
          height: height,
          padding: paddingValues,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(StringRefer.artwork2),
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
              )),
          child: Container(
            width: width,
            height: width/1.2,
            margin: EdgeInsets.only(bottom: 40),
            padding: EdgeInsets.fromLTRB(12, 20, 12, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(35)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                    StringRefer.kIntroTitle1,
                    textAlign: TextAlign.center,
                    style: StyleRefer.kTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.black, height: 1.5)
                ),
                SizedBox(height: 10),
                AutoSizeText(
                  StringRefer.kIntroSubtitle,
                    textAlign: TextAlign.center,
                    style: StyleRefer.kTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w700, color: ColorRefer.kLightGreyColor)
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(left: 50, right: 50),
                  child: RoundedButton(
                      title: 'Next',
                      buttonRadius: 30,
                      colour: ColorRefer.kRedColor,
                      height: 50,
                      onPressed: () {
                        Navigator.pushNamed(context, SecondIntroScreen.secondScreenId);
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
