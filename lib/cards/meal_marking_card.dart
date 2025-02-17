import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:t_fit/functions/meal_plan_functions.dart';
import '../cards/diet_plan_card.dart';
import '../controllers/user_plan_controller.dart';
import '../screens/main_screens/main_screen.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../widgets/confirm_box.dart';
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class MealMarking extends StatefulWidget {
  MealMarking({this.mealDistribution});
  final int mealDistribution;
  @override
  _MealMarkingState createState() => _MealMarkingState();
}

class _MealMarkingState extends State<MealMarking> {
  List meal = [];
  int index = 0;
  final _iconSize = 30;
  void _initData() {
    meal = [];
    Constants.userMealData.forEach((element) {
      if((element.week == Constants.userMealPlanData.currentWeek && element.day == Constants.userMealPlanData.currentDay) == true){
        meal = mealDistribution(element.mealData);
      }
    });
    setState(() {
      Constants.mealProgressValue = 0.0;
    });
  }

  @override
  void initState() {
    _initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(builder: (context, constrains) {
            double leftPadding = constrains.maxWidth * Constants.mealProgressValue - _iconSize - 5;
            return Container(
              alignment: Constants.mealProgressValue == 0.99 || Constants.mealProgressValue == 1.0
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                  left: Constants.mealProgressValue == 0.0 || Constants.mealProgressValue == 0.99 || Constants.mealProgressValue == 1.0 ? 0 : leftPadding,
                  bottom: 10),
              margin: EdgeInsets.only(left: 20, right: 20),
              child: SvgPicture.asset(
                'assets/icons/meal.svg',
                color: Colors.orange,
                width: _iconSize.toDouble(),
                height: _iconSize.toDouble(),
              ),
            );
          }),
          LayoutBuilder(builder: (context, constrains) {
            return Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: LinearProgressIndicator(
                    value: Constants.mealProgressValue == 0.0 ? 0 : Constants.mealProgressValue,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                    backgroundColor: theme.lightTheme == true ? ColorRefer.kLightGreyColor : Colors.grey,
                    minHeight: 8),
              ),
            );
          }),
          SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Wrap(
              alignment : WrapAlignment.center,
              direction: Axis.horizontal,
              runSpacing: 10.0,
              spacing: 15.0,
              children: meal.mapIndexed((e, index) {
                String time = Constants.todayMealDetail.meals[index]['time'];
                int calories = calculateCalories(
                    carbs: Constants.todayMealDetail.meals[index]['calories_intake']['carbs'],
                    fats: Constants.todayMealDetail.meals[index]['calories_intake']['fats'],
                    proteins: Constants.todayMealDetail.meals[index]['calories_intake']['protien']);
                bool mealDone = meal[index]['mark'];
                String icon = meal[index]['icon'];
                String title = meal[index]['title'];
                var portion = meal[index]['portion'];
                mealProgressValue(mealDone, widget.mealDistribution);
                return MealCard(
                  icon: icon,
                  title: title,
                  mealInEachDay: Constants.todayMealDetail.mealsInEachDay,
                  color: mealDone == false ? theme.lightTheme == true ?
                  ColorRefer.kLightGreyColor : ColorRefer.kBoxColor : ColorRefer.kRedColor,
                  onPressed: () async {
                      await popupDialog(
                      index: index,
                      calories: calories, time: time,
                      title: title, mealDone: mealDone,
                      portion: portion,
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  popupDialog({int index, int calories, String time, String title, bool mealDone, var portion}) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmBox(
          title: 'Are you done with your',
          subTitle: '$title?',
          firstButtonTitle: mealDone == false ? 'Mark your meal as done' : 'Meal Marked',
          secondButtonTitle: portion  is int ? 'Input your meal calories' : 'View your meal calories',
          firstButtonColor: mealDone == false ? ColorRefer.kRedColor: ColorRefer.kGreenColor,
          secondButtonColor: portion  is int ? ColorRefer.kSecondBlueColor : Colors.orange,
          firstButtonOnPressed: () {
            if(mealDone == false)
              markMeal(
                index: index,
                calories: calories, time: time,
                title: title,
              );
          },
          secondButtonOnPressed: (){
            viewInsight(
              index: index,
              calories: calories, time: time,
              title: title, portion: portion
            );
          },
        );
      },
    );
    setState(() {
      Constants.mealProgressValue = 0;
    });
  }

  markMeal({int index, int calories, String time, String title}) async{
    String nowTime = DateFormat.Hms().format(DateTime.now());
    var format = DateFormat("HH:mm");
    var current = format.parse(nowTime);
    var mealT = format.parse(time);
    if (mealT.compareTo(current) <= 0) {
      Constants.userMealData.forEach((element) {
        if(element.day == Constants.userMealPlanData.currentDay && element.week == Constants.userMealPlanData.currentWeek){
          element.mealData[index] = {'mark': true, 'portion': calories};
          element.caloriesTaken = element.caloriesTaken + calories;
        }
      });
      DietPlanController.saveMealData();
      Navigator.pushNamedAndRemoveUntil(context, MainScreen.MainScreenId, (route) => false);
      Toast.show("Meal Done", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      setState(() {
        Constants.mealProgressValue = 0;
      });
      Navigator.pop(context);
      String tm = DateFormat.jm().format(DateFormat("hh:mm:ss").parse("$time:00"));
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return PopupTimeBox(time: tm, meal: title);
        },
      );
    }
  }
  viewInsight({int index, int calories, String time, String title, bool mealDone, var portion}) async{
    String nowTime = DateFormat.Hms().format(DateTime.now());
    var format = DateFormat("HH:mm");
    var current = format.parse(nowTime);
    var mealT = format.parse(time);
    if (mealT.compareTo(current) <= 0) {
      Navigator.pop(context);
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return portion is int ?
          CaloriesBox(
            index: index,
            meal: meal.length,
            calories: calories,
          ) : TakenCaloriesBox(
            carbs: portion == null ? 0 : portion['carbs'],
            fats: portion == null ? 0 : portion['fats'],
            alcohol: portion == null ? 0 : portion['alcohol'],
            protein: portion == null ? 0 : portion['protein'],
          );
        },
      );
      setState(() {
        Constants.mealProgressValue = 0;
      });
    }else {
      setState(() {
        Constants.mealProgressValue = 0;
      });
      Navigator.pop(context);
      String tm = DateFormat.jm().format(DateFormat("hh:mm:ss").parse("$time:00"));
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return PopupTimeBox(time: tm, meal: title);
        },
      );
    }
  }

}