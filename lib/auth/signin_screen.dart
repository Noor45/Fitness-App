import 'dart:io';
import 'signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../controllers/auth_controller.dart';
import 'forget_password_screen.dart';
import '../cards/signin_screen_card.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/fonts.dart';
import '../widgets/input_field.dart';
import '../widgets/round_button.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class SignInScreen extends StatefulWidget {
  static String signInScreenID = "/sign_in_screen";
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      progressIndicator: CircularProgressIndicator(color: ColorRefer.kRedColor),
      child: Scaffold(
        backgroundColor: theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          systemOverlayStyle:
              theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
          title: Text('Login'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                  Center(
                    child: AutoSizeText(
                      'T-Fit',
                      style: TextStyle(fontSize: 40.0, fontFamily: FontRefer.OpenSans),
                    ),
                  ),
                  SizedBox(height: 40),
                  InputField(
                    textInputType: TextInputType.emailAddress,
                    label: 'Email',
                    validator: kEmailValidator,
                    onChanged: (value) => _email = value,
                  ),
                  SizedBox(height: 15),
                  PasswordField(
                    label: 'Password',
                    textInputType: TextInputType.text,
                    obscureText: true,
                    validator: (String password) {
                      if (password.isEmpty) return "Password is required!";
                    },
                    onChanged: (value) => _password = value,
                  ),
                  SizedBox(height: 30),
                  //************************** Login with Credentials **************************
                  RoundedButton(
                      title: 'Login',
                      buttonRadius: 5,
                      colour: ColorRefer.kRedColor,
                      height: 48,
                      onPressed: () async {
                        if (!formKey.currentState.validate()) return;
                        formKey.currentState.save();
                        setState(() {
                          _isLoading = true;
                        });
                        await AuthController().loginWithCredentials(context, _email.toString().trim(), _password.toString().trim());
                        setState(() {
                          _isLoading = false;
                        });
                      }
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, ForgetPasswordScreen.ID),
                      child: AutoSizeText(
                        'Forgot Password?',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: FontRefer.OpenSans,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: Text(
                      "or login with",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: FontRefer.OpenSans,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //************************** Login with Facebook **************************
                      SocialMediaIcons(
                          color: Colors.black,
                          icon: 'assets/icons/facebook.svg',
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            await AuthController().loginWithFacebookLogin(context);
                            setState(() {
                              _isLoading = false;
                            });
                          }
                      ),
                      SizedBox(width: 15),
                      //************************** Login with Google **************************
                      SocialMediaIcons(
                          color: Colors.black,
                          icon: 'assets/icons/google.svg',
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            await AuthController().loginWithGoogle(context).onError((error, stackTrace) {
                              setState(() {
                                _isLoading = false;
                              });
                            });
                            setState(() {
                              _isLoading = false;
                            });
                          }
                      ),
                      //************************** Login with Apple **************************
                      Visibility(
                        visible: Platform.isIOS ? true : false,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: SocialMediaIcons(
                              color: Colors.black,
                              icon: 'assets/icons/apple.svg',
                              onPressed: () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                await AuthController().signInWithApple(context).onError((error, stackTrace) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                });
                                setState(() {
                                  _isLoading = false;
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: FontRefer.OpenSans,
                          color: Colors.grey,
                        ),
                      ),
                      //************************** Sign Up **************************
                      InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) => SignUpScreen(),
                                transitionDuration: Duration(seconds: 0),
                              ),
                            );
                          },
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: FontRefer.OpenSans,
                                color: ColorRefer.kRedColor,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
