import 'package:flutter/services.dart';
import 'package:t_fit/auth/privacy_policy_screen.dart';
import 'package:t_fit/auth/term_condition_screen.dart';
import '../controllers/auth_controller.dart';
import '../models/user_model/user_model.dart';
import '../widgets/dialogs.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/fonts.dart';
import '../widgets/ImagePicker.dart';
import '../widgets/input_field.dart';
import '../widgets/round_button.dart';
import '../utils/style.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class SignUpScreen extends StatefulWidget {
  static String signUpScreenID = "/sign_up_screen";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  Color borderColor = Colors.transparent;
  bool _checkedValue = false;
  File _image;
  String _name;
  String _email;
  String _password;
  bool _isLoading = false;

  void _pickImage(ImageSource imageSource) async {
    XFile galleryImage =
        await _picker.pickImage(source: imageSource, imageQuality: 40);
    setState(() {
      _image = File(galleryImage.path);
    });
  }

  Future<void> _signup() async {
    if (!formKey.currentState.validate()) return;
    setState(() {
      _isLoading = true;
    });
    formKey.currentState.save();
    AuthController.currentUser = UserModel(email: _email, name: _name);
    bool success = await AuthController()
        .signupWithCredentials(context, _image, _password);
    if (success) {
      AppDialog().showOSDialog(context, "Verification",
          "Verification email has been sent to your email address", "Ok", () {
        AuthController.currentUser = UserModel();
        Navigator.pop(context);
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      progressIndicator: Theme(
        data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(secondary: ColorRefer.kRedColor)),
        child: CircularProgressIndicator(),
      ),
      child: Scaffold(
        backgroundColor: theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(Platform.isIOS
                  ? Icons.arrow_back_ios_sharp
                  : Icons.arrow_back_rounded)),
          title: Text('Sign up'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 60),
                      Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showImageDialogBox();
                              },
                              child: Container(
                                  height: 75,
                                  width: 75,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: borderColor)),
                                  child: _image != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(65),
                                          child: Image.file(
                                            _image,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : SvgPicture.asset(
                                          'assets/icons/person.svg')),
                            ),
                            Positioned(
                                left: 65,
                                top: 25,
                                child: SvgPicture.asset(
                                    'assets/icons/camera.svg'))
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      InputField(
                        textInputType: TextInputType.name,
                        label: 'Name',
                        validator: (String firstName) {
                          if (firstName.isEmpty) return "Name is required";
                          if (firstName.length < 3)
                            return "Minimum three characters required";
                        },
                        onChanged: (value) => _name = value,
                      ),
                      SizedBox(height: 15),
                      InputField(
                        textInputType: TextInputType.emailAddress,
                        label: 'Email',
                        validator: kEmailValidator,
                        onChanged: (String value) =>
                            _email = value.toLowerCase(),
                      ),
                      SizedBox(height: 15),
                      PasswordField(
                        label: 'Password',
                        textInputType: TextInputType.text,
                        obscureText: true,
                        validator: (String password) {
                          if (password.isEmpty) return "Password is required";
                          if (password.length < 6)
                            return "Minimum 6 characters are required";
                        },
                        onChanged: (value) => _password = value,
                      ),
                      SizedBox(height: 15),
                      PasswordField(
                        label: 'Confirm Password',
                        textInputType: TextInputType.text,
                        obscureText: true,
                        validator: (String confirmPassword) {
                          if (confirmPassword.isEmpty ||
                              confirmPassword != _password)
                            return "Password does not match";
                        },
                        onChanged: (value) {},
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 25),
                  child: Row(
                    children: [
                      Container(
                        child: Theme(
                          data: ThemeData(
                              unselectedWidgetColor: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                              selectedRowColor: ColorRefer.kRedColor),
                          child: Checkbox(
                            value: _checkedValue,
                            activeColor: ColorRefer.kRedColor,
                            onChanged: (bool value) {
                              setState(() {
                                _checkedValue = value;
                              });
                            },
                          ),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'I agree to the ',
                                style: StyleRefer.kCheckBoxTextStyle.copyWith(
                                    color: Colors.grey,
                                    fontSize: 13)),
                            TextSpan(
                                text: 'Terms of Services',
                                style: StyleRefer.kCheckBoxTextStyle.copyWith(
                                    color: ColorRefer.kRedColor,
                                    fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, TermConditionScreen.ID);
                                  }),
                            TextSpan(
                                text: ' & ',
                                style: StyleRefer.kCheckBoxTextStyle
                                    .copyWith(color: Colors.grey,)),
                            TextSpan(
                                text: 'Privacy Policy',
                                style: StyleRefer.kCheckBoxTextStyle.copyWith(
                                    color: ColorRefer.kRedColor,
                                    fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, PrivacyPolicyScreen.ID);
                                  }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      //************************** Sign up button **************************
                      ButtonWithIcon(
                          title: 'Sign Up',
                          buttonRadius: 5,
                          colour: _checkedValue
                              ? ColorRefer.kRedColor
                              : ColorRefer.kRedColor.withOpacity(0.5),
                          height: 40,
                          onPressed: _checkedValue ? () => _signup() : null),
                      SizedBox(height: 22),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: FontRefer.OpenSans,
                              color: Colors.grey,
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: FontRefer.OpenSans,
                                    color: ColorRefer.kRedColor,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showImageDialogBox() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              child: CameraGalleryBottomSheet(
                cameraClick: () => _pickImage(ImageSource.camera),
                galleryClick: () => _pickImage(ImageSource.gallery),
              ),
            ),
          );
        });
  }
}
