import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:t_fit/auth/signin_screen.dart';
import 'package:t_fit/utils/strings.dart';
import 'package:t_fit/utils/style.dart';
import 'package:t_fit/widgets/dialogs.dart';
import 'package:toast/toast.dart';
import '../controllers/auth_controller.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/fonts.dart';
import '../widgets/round_button.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';
import 'package:flutter/material.dart';

class HireExpertScreen extends StatefulWidget {
  static const String ID = "/hire_expert_screen";
  @override
  _HireExpertScreenState createState() => _HireExpertScreenState();
}

class _HireExpertScreenState extends State<HireExpertScreen> {
  bool _hireTrainer = false;
  bool _hireChef = false;
  GoogleSignIn googleSignIn = GoogleSignIn();
  TextEditingController controller = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    if(Constants.update == true){
      _hireChef = AuthController.currentUser.hire['chef'];
      _hireTrainer = AuthController.currentUser.hire['trainer'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor: theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      ),
      body: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                  child: AutoSizeText(
                    'Hire a T-Fit Expert',
                    style: TextStyle(
                        fontSize: 20,
                        color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white,
                        fontFamily: FontRefer.OpenSans,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: AutoSizeText(
                    StringRefer.kHireExpertString,
                    style: TextStyle(
                        fontSize: 14,
                        color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white,
                        height: 1.3,
                        fontFamily: FontRefer.OpenSans,
                   ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      child: Theme(
                        data: ThemeData(
                            unselectedWidgetColor: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                            selectedRowColor: ColorRefer.kRedColor
                        ),
                        child: Checkbox(
                          value: _hireTrainer,
                          activeColor: ColorRefer.kRedColor,
                          onChanged: (bool value) {
                            setState(() {
                              _hireTrainer = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Text(
                        'Hire a Personal Fitness Trainer',
                        style: StyleRefer.kCheckBoxTextStyle
                            .copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white, fontSize: 15)
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      child: Theme(
                        data: ThemeData(
                            unselectedWidgetColor: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                            selectedRowColor: ColorRefer.kRedColor
                        ),
                        child: Checkbox(
                          value: _hireChef,
                          activeColor: ColorRefer.kRedColor,
                          onChanged: (bool value) {
                            setState(() {
                              _hireChef = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Text(
                      'Hire a Chef/Nutritionists',
                      style: StyleRefer.kCheckBoxTextStyle
                          .copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white, fontSize: 15)
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: ButtonWithIcon(
                      title: 'Hire Now',
                      buttonRadius: 5,
                      colour: Constants.update == true ? ColorRefer.kRedColor : _hireChef == true || _hireTrainer == true  ? ColorRefer.kRedColor : ColorRefer.kRedColor.withOpacity(0.4) ,
                      height: 40,
                      onPressed: () async {
                        if(Constants.update == true){
                          AuthController.currentUser.hire['chef'] = _hireChef;
                          AuthController.currentUser.hire['trainer'] = _hireTrainer;
                          AuthController().updateUserFields();
                          Toast.show("Updated", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                          Navigator.pop(context);
                        }else{
                          if(_hireChef == true || _hireTrainer == true ){
                            AuthController.currentUser.hire['chef'] = _hireChef;
                            AuthController.currentUser.hire['trainer'] = _hireTrainer;
                            AuthController().updateUserFields();
                            googleSignIn.disconnect();
                            auth.signOut();
                            await AppDialog().showOSDialog(context, StringRefer.Approval, StringRefer.googleAccountNotApprove,
                                StringRefer.Ok, () {
                                  Navigator.pushNamedAndRemoveUntil(context, SignInScreen.signInScreenID, (route) => false);
                            });
                          }
                        }
                      }),
                ),
                SizedBox(height: 15),
                Center(
                  child: Visibility(
                    visible: Constants.update == true ? false: true,
                    child: InkWell(
                      onTap: () async {
                        if (Constants.update == true) {
                          Navigator.pop(context);
                        }else{
                          googleSignIn.disconnect();
                          auth.signOut();
                          await AppDialog().showOSDialog(context, StringRefer.Approval, StringRefer.googleAccountNotApprove,
                              StringRefer.Ok, () {
                                Navigator.pushNamedAndRemoveUntil(context, SignInScreen.signInScreenID, (route) => false);
                          });
                        }
                      },
                      child: Text(
                          'Skip for now',
                          style: StyleRefer.kCheckBoxTextStyle
                          .copyWith(color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 12, decoration: TextDecoration.underline)
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          )),
    );
  }
}
