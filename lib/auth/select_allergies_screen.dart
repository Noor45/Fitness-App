import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
import '../auth/select_goals_screen.dart';
import '../controllers/auth_controller.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/fonts.dart';
import '../widgets/input_field.dart';
import '../widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/theme_model.dart';

class SelectAllergies extends StatefulWidget {
  static const String ID = "/select_allergies_screen";
  @override
  _SelectAllergiesState createState() => _SelectAllergiesState();
}

class _SelectAllergiesState extends State<SelectAllergies> {
  String allergies = '';
  int slideIndex = Constants.update  == true ?  5 : 4;
  int v = Constants.update  == true ?  6 : 5;
  TextEditingController controller = TextEditingController();
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
      controller.text = AuthController.currentUser.allergies;
      allergies = AuthController.currentUser.allergies;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor: theme.lightTheme == true ? Colors.white :  ColorRefer.kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      ),
      body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: Constants.update == true ? false : true,
                  child: Container(
                    padding:EdgeInsets.only(bottom: 8),
                    child: AutoSizeText(
                      'Step 4 of 4',
                      style: TextStyle(
                        color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                        fontSize: 15,
                        fontFamily: FontRefer.OpenSans,
                      ),
                    ),
                  ),
                ),
                AutoSizeText(
                  'Allergies?',
                  style: TextStyle(
                      fontSize: 25,
                      color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white,
                      fontFamily: FontRefer.OpenSans,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 20),
                AutoSizeText(
                  'Specifically food allergies, and any other allergies that may affect your fitness experience i.e high fever',
                  style: TextStyle(
                      fontSize: 14,
                      color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white,
                      fontFamily: FontRefer.OpenSans,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 20),
                InputField(
                  controller: controller,
                  textInputType: TextInputType.text,
                  label: 'Enter here',
                  validator: (String allergies) {
                    if (allergies.isEmpty) return "Field is required";
                    if (allergies == '') return "Field is required";
                  },
                  onChanged: (value) {
                    setState(() {
                      allergies = value;
                    });
                  },
                ),
                SizedBox(height: 30),
                ButtonWithIcon(
                    title: Constants.update == true ? 'Update' : 'Next',
                    buttonRadius: 5,
                    colour: ColorRefer.kRedColor,
                    height: 40,
                    onPressed: () {
                      AuthController.currentUser.allergies = allergies;
                      AuthController().updateUserFields();
                      if (Constants.update == true)
                        {
                          Navigator.pop(context);Navigator.pop(context);Navigator.pop(context);Navigator.pop(context);Navigator.pop(context);Navigator.pop(context);
                          Toast.show("Updated", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                        }
                      else
                      Navigator.pushNamed(
                          context, SelectGoalsScreen.ID);
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
