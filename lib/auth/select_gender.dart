import 'package:auto_size_text/auto_size_text.dart';
import '../auth/chose_weight_screen.dart';
import '../controllers/auth_controller.dart';
import '../widgets/input_field.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/fonts.dart';
import '../widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class SelectGender extends StatefulWidget {
  static const String ID = "/select_gender_screen";
  @override
  _SelectGenderState createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
  String gender;
  int slideIndex = Constants.update  == true ?  2 : 1;
  int v = Constants.update  == true ?  6 : 5;
  Color femaleBoxColor = ColorRefer.kLightColor;
  Color maleBoxColor = ColorRefer.kLightColor;
  Color otherBoxColor = ColorRefer.kLightColor;
  Widget _buildPageIndicator(bool isCurrentPage, DarkThemeProvider theme) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      height: isCurrentPage ? 8.0 : 8.0,
      width: isCurrentPage ? 8.0 : 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCurrentPage ? theme.lightTheme == true ? ColorRefer.kRedColor : Colors.white : Colors.grey,
      ),
    );
  }

  @override
  void initState() {
    if(Constants.update == true){
      gender = AuthController.currentUser.gender;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: theme.lightTheme == true ? Colors.white :  ColorRefer.kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      ),
      body: SafeArea(
          child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: Constants.update == true ? false : true,
                child: Container(
                  padding: EdgeInsets.only(bottom: 8),
                  child: AutoSizeText(
                    'Step 2 of 4',
                    style: TextStyle(
                      color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                      fontSize: 15,
                      fontFamily: FontRefer.OpenSans,
                    ),
                  ),
                ),
              ),
              AutoSizeText(
                'Gender?',
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: FontRefer.OpenSans,
                    color:theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 15),
              SelectBox(
                  value: gender,
                  label: 'Select Gender',
                  selectionList: ['Male', 'Female'],
                  onChanged: (value){
                    setState(() {
                      gender = value;
                    });
                  },
              ),
              SizedBox(height: 30),
              ButtonWithIcon(
                  title: 'Next',
                  buttonRadius: 5,
                  colour: gender == null
                      ? ColorRefer.kRedColor.withOpacity(0.5)
                      : ColorRefer.kRedColor,
                  height: 40,
                  onPressed: gender == null
                      ? gender
                      : () {
                          AuthController.currentUser.gender = gender;
                          AuthController().updateUserFields();
                          Navigator.pushNamed(context, SelectWeightScreen.ID);
                        }),
              SizedBox(height: 30),
              Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < v; i++)
                      i == slideIndex
                          ? _buildPageIndicator(true, theme)
                          : _buildPageIndicator(false, theme),
                  ],
                ),
              ),
            ],
          ),
      )),
    );
  }
}
