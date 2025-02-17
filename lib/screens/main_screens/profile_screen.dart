import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_fit/auth/hire_expert_screen.dart';
import 'package:t_fit/auth/select_goals_screen.dart';
import 'package:t_fit/localization/language/languages.dart';
import 'package:t_fit/screens/history_screens/history_main_screen.dart';
import 'package:t_fit/screens/notification_screens/notification_setting_screen.dart';
import 'package:t_fit/shared_preferences/shared_preferences.dart';
import '../../auth/signin_screen.dart';
import '../../auth/user_name_screen.dart';
import '../../cards/setting_screen_cards.dart';
import '../../controllers/auth_controller.dart';
import '../../functions/global_functions.dart';
import '../../screens/calculators/calculator_main_screen.dart';
import '../../screens/par_q_screens/par_q_screen.dart';
import '../../services/firebase_analytics.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/fonts.dart';
import '../../widgets/dialogs.dart';
import '../../widgets/ImagePicker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  File image;
  bool _isLoading = false;
  final picker = ImagePicker();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      progressIndicator: CircularProgressIndicator(color: ColorRefer.kRedColor),
      child: Container(
        width: width,
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return Container(
                          color: Color(0xFF737373),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).canvasColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                            ),
                            child: CameraGalleryBottomSheet(
                              cameraClick: () => pickImage(ImageSource.camera),
                              galleryClick: () => pickImage(ImageSource.gallery),
                            ),
                          ),
                        );
                      });
                },
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: image != null
                          ? Image.file(
                        image,
                        width: 95,
                        height: 95,
                        fit: BoxFit.cover,
                      )
                          : AuthController.currentUser.profileImageUrl != null
                          ? FadeInImage.assetNetwork(
                        placeholder: 'assets/images/user.png',
                        image: AuthController.currentUser.profileImageUrl,
                        width: 95,
                        height: 95,
                        fit: BoxFit.cover,
                      )
                          : SvgPicture.asset(
                        'assets/icons/person.svg',
                        width: 95,
                        height: 95,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 65, top: 60),
                      child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        elevation: 3,
                        child: Container(
                          alignment: Alignment.center,
                          width: 30,
                          height: 30,
                          child: SvgPicture.asset(
                            'assets/icons/cameraFill.svg',
                            width: 16,
                            height: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              AutoSizeText(
                AuthController.currentUser.name,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: FontRefer.OpenSans,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 30),
              SettingTabs(
                title: 'Update Profile',
                // title: Languages.of(context).labelWelcome,
                onTap: () async {
                  setState(() {
                    Constants.update = true;
                  });
                  await Navigator.pushNamed(context, UserNameScreen.ID);
                  setState(() {});
                },
              ),
              SizedBox(height: 10),
              SettingTabs(
                title: 'PAR-Q & You',
                onTap: () async {
                  await Navigator.pushNamed(context, PARQScreen.ID);
                  setState(() {});
                },
              ),
              // SizedBox(height: 10),
              // SettingTabs(
              //   title: 'Select Goal',
              //   onTap: () async {
              //     await Navigator.pushNamed(context, SelectGoalsScreen.ID);
              //     setState(() {});
              //   },
              // ),
              SizedBox(height: 10),
              SettingTabs(
                title: 'Hire Expert',
                onTap: () async {
                  setState(() {
                    Constants.update = true;
                  });
                  await Navigator.pushNamed(context, HireExpertScreen.ID);
                  setState(() {});
                },
              ),
              SizedBox(height: 10),
              SettingTabs(
                title: 'BMI, MICROS, and Fat Calculator ',
                onTap: () {
                  Navigator.pushNamed(context, CalculatorMainScreen.ID);
                },
              ),
              SizedBox(height: 10),
              SettingTabs(
                title: 'History',
                onTap: () {
                  Navigator.pushNamed(context, PlanHistoryScreen.ID);
                },
              ),
              SizedBox(height: 10),
              SettingTabs(
                title: 'Language',
                onTap: () {
                  showDialog(
                    context: context,
                    useSafeArea: false,
                    builder: (BuildContext context) {
                      return LanguageCard();
                    },
                  );
                },
              ),
              SizedBox(height: 10),
              SettingTabs(
                title: 'Notification Preference',
                onTap: () {
                  Navigator.pushNamed(context, NotificationSettingScreen.ID);
                },
              ),
              SizedBox(height: 10),
              SettingTabs(
                title: 'Logout',
                onTap: () async{
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  AppDialog().showOSDialog(context, "Logout", "Are you sure you want to logout now?", "Logout", () {
                    clearData();
                    _auth.signOut();
                    googleSignIn.disconnect();
                    FirebaseAnalyticsService.logEvent("Logout");
                    Navigator.pushNamedAndRemoveUntil(
                        context, SignInScreen.signInScreenID, (route) => false);
                  }, secondButtonText: "Cancel", secondCallback: () {});
                },
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  void pickImage(ImageSource imageSource) async {
    XFile galleryImage = await picker.pickImage(source: imageSource, imageQuality: 40);
    setState(() {
      image = File(galleryImage.path);
    });
    setState(() {
      _isLoading = true;
    });
    await AuthController().updateUserImages(image);
    setState(() {
      _isLoading = false;
    });
  }
}
