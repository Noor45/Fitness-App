import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../../../cards/custom_cards.dart';
import '../../../cards/diet_plan_card.dart';
import '../../../models/meal_model/meal_calories_model.dart';
import '../../../models/meal_model/meal_model.dart';
import '../../../screens/diet_plan_screens/meal_plan/meal_plan_detail_screen.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/style.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class MealWeekPlanScreen extends StatefulWidget {
  static const String ID = "/meal_week_plan_screen";
  @override
  _MealWeekPlanScreenState createState() => _MealWeekPlanScreenState();
}

class _MealWeekPlanScreenState extends State<MealWeekPlanScreen> {
  bool _isLoading = false;
  MealCaloriesModel mealCalories;
  int protein;
  int fat;
  int carbs;
  List weekDays = [];
  weekList(int week){
    setState(() {
      int i = 0;
      var formatter = new DateFormat('EEEE');
      for( i = (week*7)-7; i<(week*7); i++){
        if(Constants.mealPlanDetail.startDate.toDate().isAfter(Constants.mealPlanDetail.endDate.toDate().add(Duration(days: i)))) return;
        else weekDays.add(formatter.format(Constants.mealPlanDetail.startDate.toDate().add(Duration(days: i))));
      }
    });
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    int week = ModalRoute.of(context).settings.arguments;
    weekList(week);
    return Scaffold(
        backgroundColor: theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
        appBar: AppBar(
          elevation: theme.lightTheme == true ? 3 : 0,
          iconTheme: IconThemeData(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
          systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
          centerTitle: true,
          title: Text(
            'WEEK $week',
            style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 15),
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: _isLoading,
          progressIndicator: Theme(
            data: Theme.of(context).copyWith(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorRefer.kRedColor)),
            child: CircularProgressIndicator(color: ColorRefer.kRedColor,),
          ),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageCard(
                    image: 'assets/images/meal.png',
                    title: '${Constants.mealPlanDetail.duration * 7} Days ${Constants.mealPlanDetail.planName}',
                    subtitle: '${Constants.mealPlanDetail.duration} ${Constants.mealPlanDetail.duration == 1 ? 'Week' :'Weeks'}, ${Constants.mealPlanDetail.duration * 7} Days',
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Special Instructions:',
                          style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(height: 5),
                        Text(
                          Constants.mealPlanDetail.des,
                          style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 12),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Meal Plan Details',
                          style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                  ),

                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: Constants.userWeeklyMealList.length,
                      itemBuilder: (BuildContext context, int index) {
                         mealCalories = MealCaloriesModel.fromMap(Constants.userWeeklyMealList[index].caloriesLevel);
                         protein = mealCalories.protein;
                         carbs = mealCalories.carbs;
                         fat = mealCalories.fats;
                        return index > weekDays.length-1 ? Container() :  Container(
                          margin: EdgeInsets.only(top: 15),
                          child: WeekMealPlanCard(
                            title: 'Day ${index+1} ${weekDays[index]}',
                            carbs: '${carbs == 1 ? 'High' : carbs == 2 ? 'Medium' : 'Low'} Carbs',
                            proteins: '${fat == 1 ? 'High' : fat == 2 ? 'Medium' : 'Low'} Proteins',
                            fats: '${protein == 1 ? 'High' : protein == 2 ? 'Medium' : 'Low'} Fats',
                            onPressed: () async{
                              Constants.mealDetailList.clear();
                              Constants.userWeeklyMealList[index].meals.forEach((element) {
                                MealModel mealPlan = MealModel.fromMap(element);
                                Constants.mealDetailList.add(mealPlan);
                              });
                              Navigator.pushNamed(context, MealPlanDetailScreen.ID, arguments: [Constants.userWeeklyMealList[index], weekDays[index], week]);
                            },
                          ),
                        );
                      }),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
        )
    );
  }
}






