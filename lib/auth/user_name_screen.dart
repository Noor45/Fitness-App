import 'package:auto_size_text/auto_size_text.dart';
import '../auth/select_age_screen.dart';
import '../controllers/auth_controller.dart';
import '../utils/colors.dart';
import '../utils/fonts.dart';
import '../widgets/input_field.dart';
import '../widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../services/theme_model.dart';

class UserNameScreen extends StatefulWidget {
  static const String ID = "/user_name_screen";
  @override
  _UserNameScreenState createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  String name;
  int slideIndex = 0;
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
    controller.text = AuthController.currentUser.name;
    name = AuthController.currentUser.name;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
          child: Form(
            key: formKey,
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    'Your Name?',
                    style: TextStyle(
                        fontSize: 25,
                        color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white,
                        fontFamily: FontRefer.OpenSans,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 20),
                  InputField(
                    controller: controller,
                    textInputType: TextInputType.name,
                    label: 'Enter your full name',
                    validator: (String name) {
                      if (name.isEmpty) return "name is required!";
                      if (name == '') return "name is required!";
                    },
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                  SizedBox(height: 30),
                  ButtonWithIcon(
                      title: 'Next',
                      buttonRadius: 5,
                      colour: name == null
                          ? ColorRefer.kRedColor.withOpacity(0.5)
                          : ColorRefer.kRedColor,
                      height: 40,
                      onPressed: name == null
                          ? name
                          :() {
                        FocusScope.of(context).unfocus();
                        if (!formKey.currentState.validate()) return;
                        formKey.currentState.save();
                        AuthController.currentUser.name = name;
                        AuthController().updateUserFields();
                        Navigator.pushNamed(context, SelectAge.ID);
                      }),
                  SizedBox(height: 30),
                  Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < 6; i++)
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
