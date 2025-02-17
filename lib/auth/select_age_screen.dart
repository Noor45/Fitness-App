import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import '../auth/select_gender.dart';
import '../controllers/auth_controller.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/fonts.dart';
import '../widgets/input_field.dart';
import '../widgets/round_button.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';
import 'package:flutter/material.dart';

class SelectAge extends StatefulWidget {
  static const String ID = "/select_age_screen";
  @override
  _SelectAgeState createState() => _SelectAgeState();
}

class _SelectAgeState extends State<SelectAge> {
  int age;
  int slideIndex = Constants.update  == true ?  1 : 0;
  int v = Constants.update  == true ?  6 : 5;
  final formKey = GlobalKey<FormState>();
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
      controller.text = AuthController.currentUser.age.toString();
      age = AuthController.currentUser.age;
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
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: Constants.update == true ? false : true,
                  child: Container(
                    padding:EdgeInsets.only(bottom: 8),
                    child: AutoSizeText(
                      'Step 1 of 4',
                      style: TextStyle(
                        color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                        fontSize: 15,
                        fontFamily: FontRefer.OpenSans,
                      ),
                    ),
                  ),
                ),
                AutoSizeText(
                  'Your Age?',
                  style: TextStyle(
                      fontSize: 25,
                      color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white,
                      fontFamily: FontRefer.OpenSans,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 20),
                InputField(
                  controller: controller,
                  textInputType: TextInputType.number,
                  maxLength: 2,
                  label: 'Enter your age',
                  validator: (String age) {
                    if (age.isEmpty) return "Age is required!";
                    if (age == '') return "Age is required!";
                    if(int.tryParse(age) < 15 || int.tryParse(age) > 80) return "Age should be 15 to 80";
                  },
                  onChanged: (value) {
                    setState(() {
                      if(value != '')
                        age = int.parse(value);
                    });
                  },
                ),
                SizedBox(height: 30),
                ButtonWithIcon(
                    title: 'Next',
                    buttonRadius: 5,
                    colour: age == null
                        ? ColorRefer.kRedColor.withOpacity(0.5)
                        : ColorRefer.kRedColor,
                    height: 40,
                    onPressed: age == null ? age : () {
                      FocusScope.of(context).unfocus();
                      if (!formKey.currentState.validate()) return;
                      formKey.currentState.save();
                      AuthController.currentUser.age = age;
                      AuthController().updateUserFields();
                      Navigator.pushNamed(context, SelectGender.ID);
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
          ),
      )),
    );
  }
}
