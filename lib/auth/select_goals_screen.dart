import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../cards/custom_cards.dart';
import '../controllers/auth_controller.dart';
import '../auth/hire_expert_screen.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/fonts.dart';
import '../services/theme_model.dart';
import '../widgets/round_button.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SelectGoalsScreen extends StatefulWidget {
  static String ID = "/select_goals_screen";
  @override
  _SelectGoalsScreenState createState() => _SelectGoalsScreenState();
}

class _SelectGoalsScreenState extends State<SelectGoalsScreen> {
  int goal = 0;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    if (Constants.update == true) {
      setState(() {
        goal = AuthController.currentUser.selectedGoal;
      });
    }
    super.initState();
  }

  navigate(int value) {
    AuthController.currentUser.selectedGoal = value;
    AuthController().updateUserFields();
    if (Constants.update == true) {
      Navigator.pop(context);
    } else {
      AuthController.currentUser.bfp = 0;
      AuthController.currentUser.neck = 0;
      AuthController.currentUser.hips = 0;
      AuthController.currentUser.waist = 0;
      AuthController.currentUser.bfp = 0.0;
      AuthController.currentUser.neck = null;
      AuthController.currentUser.hips = null;
      AuthController.currentUser.waist = null;
      AuthController.currentUser.instructors = ['ihzsHTUyCgUVUpy6lN8bMXjuap02'];
      AuthController.currentUser.macroNutrients = {};
      Navigator.pushNamed(context, HireExpertScreen.ID);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor: theme.lightTheme == true ? Colors.white :  ColorRefer.kBackgroundColor,
      appBar: AppBar(
        elevation: theme.lightTheme == true ? 0 : 3,
        systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      ),
      body: SafeArea(
          child: Scrollbar(
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      'What are your goals?',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: FontRefer.OpenSans,
                          color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 10),
                    AutoSizeText(
                      'Select your goals',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: FontRefer.OpenSans,
                          color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GoalCard(
                                icon: 'assets/icons/extreme_fat_loss.svg',
                                title: 'Lose Weight',
                                select: goal == 1 ? true : false,
                                color: goal == 1 ? ColorRefer.kRedColor : theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                                onPressed: () {
                                  setState(() {
                                    goal = 1;
                                  });
                                },
                              ),
                              GoalCard(
                                icon: 'assets/icons/muscles.svg',
                                title: 'Build Muscle',
                                select: goal == 2 ? true : false,
                                color: goal == 2 ? ColorRefer.kRedColor : theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                                onPressed: () {
                                  setState(() {
                                    goal = 2;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 15),
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GoalCard(
                                icon: 'assets/icons/healthier.svg',
                                title: 'Be Healthier',
                                select: goal == 3 ? true : false,
                                color: goal == 3 ? ColorRefer.kRedColor : theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                                onPressed: () {
                                  setState(() {
                                    goal = 3;
                                  });
                                },
                              ),
                              GoalCard(
                                icon: 'assets/icons/increase_strength.svg',
                                title: 'Increase Strength & Power',
                                select: goal == 4 ? true : false,
                                color: goal == 4 ? ColorRefer.kRedColor : theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                                onPressed: () {
                                  setState(() {
                                    goal = 4;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 15),
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GoalCard(
                                icon: 'assets/icons/fire.svg',
                                title: 'Extreme Fat Loss',
                                select: goal == 5 ? true : false,
                                color: goal == 5 ? ColorRefer.kRedColor : theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                                onPressed: () {
                                  setState(() {
                                    goal = 5;
                                  });
                                },
                              ),
                              GoalCard(
                                icon: 'assets/icons/shape_tone.svg',
                                title: 'Shape, Tone and Refine',
                                select: goal == 6 ? true : false,
                                color: goal == 6 ? ColorRefer.kRedColor : theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                                onPressed: () {
                                  setState(() {
                                    goal = 6;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 15),
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GoalCard(
                                icon: 'assets/icons/competition_prep.svg',
                                title: 'Competition Prep',
                                select: goal == 7 ? true : false,
                                color: goal == 7 ? ColorRefer.kRedColor : theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                                onPressed: () {
                                  setState(() {
                                    goal = 7;
                                  });
                                },
                              ),
                              GoalCard(
                                icon: 'assets/icons/increase_testosterone.svg',
                                title: 'Increase Testosterone',
                                select: goal == 8 ? true : false,
                                color: goal == 8 ? ColorRefer.kRedColor : theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                                onPressed: () {
                                  setState(() {
                                    goal = 8;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 15),
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GoalCard(
                                icon: 'assets/icons/optimise_hormone.svg',
                                title: 'Optimise Hormone function',
                                select: goal == 9 ? true : false,
                                color: goal == 9 ? ColorRefer.kRedColor : theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                                onPressed: () {
                                  setState(() {
                                    goal = 9;
                                  });
                                },
                              ),
                              GoalCard(
                                icon: 'assets/icons/improve_mobility.svg',
                                title: 'Improve Mobility & Flexibility',
                                select: goal == 10 ? true : false,
                                color: goal == 10 ? ColorRefer.kRedColor : theme.lightTheme == true ? ColorRefer.kLightGreyColor :  ColorRefer.kBoxColor,
                                onPressed: () {
                                  setState(() {
                                    goal = 10;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 15),
                        GoalCard(
                          icon: 'assets/icons/rehabilitation_recovery.svg',
                          title: 'Rehabilitation & Recovery',
                          select: goal == 11 ? true : false,
                          color: goal == 11 ? ColorRefer.kRedColor : theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                          onPressed: () {
                            setState(() {
                              goal = 11;
                            });
                          },
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 15, top: 20),
                          child: ButtonWithIcon(
                              title: 'Done',
                              buttonRadius: 5,
                              colour: goal == 0 ? ColorRefer.kRedColor.withOpacity(0.5) : ColorRefer.kRedColor,
                              height: 40,
                              onPressed: goal == 0
                                  ? null
                                  : () {
                                navigate(goal);
                              }),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
