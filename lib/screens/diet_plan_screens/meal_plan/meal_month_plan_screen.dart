import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../../../cards/custom_cards.dart';
import '../../../screens/diet_plan_screens/meal_plan/meal_week_plan_screen.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/style.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class MealMonthPlanScreen extends StatefulWidget {
  static const String ID = "/meal_month_plan_screen";
  @override
  _MealMonthPlanScreenState createState() => _MealMonthPlanScreenState();
}

class _MealMonthPlanScreenState extends State<MealMonthPlanScreen> {
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor: theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
      appBar: AppBar(
        elevation: theme.lightTheme == true ? 3 : 0,
        iconTheme: IconThemeData(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
        systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
        centerTitle: true,
        title: Text(
          '${Constants.mealPlanDetail.planName}',
          style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 15),
        ),
      ),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: _isLoading,
          progressIndicator: CircularProgressIndicator(
            color: ColorRefer.kRedColor,
          ),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ImageCard(
                    image: 'assets/images/meal.png',
                    title: '${Constants.mealPlanDetail.duration * 7} Days ${Constants.mealPlanDetail.planName}',
                    subtitle: '${Constants.mealPlanDetail.duration} ${Constants.mealPlanDetail.duration == 1 ? 'Week' :'Weeks'}, ${Constants.mealPlanDetail.duration * 7} Days',
                  ),
                  SizedBox(height: 15),
                  Container(
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: Constants.mealPlanDetail.duration,
                        itemBuilder: (BuildContext context, int index) {
                          return  WeekCards(
                            title: 'WEEK ${index+1}',
                            subtitle: '7 Days Meal Plan',
                            icon: 'assets/icons/meal.svg',
                            onPressed: () async{
                                Constants.userWeeklyMealList = [];
                                Constants.userMealList.forEach((element) {
                                  if(element.week == index+1){
                                    Constants.userWeeklyMealList.add(element);
                                  }
                                });
                                Navigator.pushNamed(context, MealWeekPlanScreen.ID, arguments: index+1);
                            },
                          );
                        }
                      ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


