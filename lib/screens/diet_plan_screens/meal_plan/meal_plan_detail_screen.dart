import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rubber/rubber.dart';
import 'package:t_fit/controllers/user_plan_controller.dart';
import 'package:t_fit/functions/meal_plan_functions.dart';
import 'package:t_fit/screens/main_screens/main_screen.dart';
import 'package:t_fit/widgets/confirm_box.dart';
import 'package:t_fit/widgets/round_button.dart';
import 'package:toast/toast.dart';
import '../../../models/meal_model/meal_plan_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/style.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';
import 'package:intl/intl.dart';

class MealPlanDetailScreen extends StatefulWidget {
  static const String ID = "/meal_plan_detail_screen";
  @override
  _MealPlanDetailScreenState createState() => _MealPlanDetailScreenState();
}

class _MealPlanDetailScreenState extends State<MealPlanDetailScreen> with SingleTickerProviderStateMixin {
  List args = [];
  int takenCalories = 0;
  int totalCarbs = 0;
  int totalProteins = 0;
  int totalFats = 0;
  MealPlanModel mealPlan;
  String day;
  ScrollController _scrollController = ScrollController();
  List mealData = [];
  RubberAnimationController _controller;

  data({int week, int day}){
    mealData = List.filled(mealPlan.meals.length , {'mark': false, 'portion': 0});
    setState(() {
      Constants.userMealData.forEach((element) {
        if(element.week == week && element.day == day){
          takenCalories = element.caloriesTaken;
          int index = 0;
          element.mealData.forEach((e) {
            mealData[index] = e;
            index++;
          });
        }
      });
      Constants.mealDetailList.forEach((element) {
        totalCarbs = totalCarbs + element.caloriesIntake['carbs'];
        totalProteins = totalProteins + element.caloriesIntake['protien'];
        totalFats = totalFats + element.caloriesIntake['fats'];
      });
    });
  }
  @override
  void initState() {
    _controller = RubberAnimationController(
        vsync: this,
        lowerBoundValue: AnimationControllerValue(percentage: 0.2),
        halfBoundValue: AnimationControllerValue(percentage: 0.5),
        duration: Duration(milliseconds: 200)
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    args = ModalRoute.of(context).settings.arguments;
    mealPlan = args[0];
    day = args[1];
    data(day: mealPlan.day, week: args[2]);
    return Scaffold(
        backgroundColor: theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
        appBar: AppBar(
          elevation: theme.lightTheme == true ? 3 : 0,
          systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
          iconTheme: IconThemeData(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
          centerTitle: true,
          title: Text(
            'Day ${mealPlan.day}',
            style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 15),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage("assets/images/meal_photo.png"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(theme.lightTheme == true ? 0.3 : 0.4), BlendMode.darken)
            ),
          ),
          child: RubberBottomSheet(
            scrollController: _scrollController,
            lowerLayer: _getLowerLayer(mealPlan.day, day, mealPlan.meals.length, theme),
            header: Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)
                ),
              ),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CaloriesChart(
                      title: 'Calories',
                      value: mealPlan.totalDayCalories,
                      unit: 'Kcal',
                      show: true,
                      leftSpace: 15,
                    ),
                    CaloriesChart(
                      title: 'Proteins',
                      value: totalProteins,
                      unit: 'Grams',
                      show: true,
                      leftSpace: 15,
                    ),
                    CaloriesChart(
                      title: 'Fats',
                      value: totalFats,
                      unit: 'Grams',
                      show: true,
                      leftSpace: 15,
                    ),
                    CaloriesChart(
                      title: 'Carbs',
                      value: totalCarbs,
                      unit: 'Grams',
                      show: false,
                      leftSpace: 0,
                    ),
                  ],
                ),
              ),
            ),
            headerHeight: 120,
            upperLayer: _getUpperLayer(mealPlan.caloriesLevel),
            animationController: _controller,
          ),
        ),

    );
  }
  Widget _getLowerLayer(int dayNo, String day, int md, DarkThemeProvider theme) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage("assets/images/meal_photo.png"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(theme.lightTheme == true ? 0.3 : 0.4), BlendMode.darken)
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20,top: width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                'Day $dayNo',
                style: StyleRefer.kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 35),
              ),
              AutoSizeText(
                day,
                style: StyleRefer.kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 35),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  SvgPicture.asset('assets/icons/time.svg'),
                  SizedBox(width: 10),
                  AutoSizeText(
                    '$md Meals a day',
                    style: StyleRefer.kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _getUpperLayer(var calories) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            int mealCalories = calculateCalories(
                carbs: Constants.mealDetailList[index].caloriesIntake['carbs'],
                fats: Constants.mealDetailList[index].caloriesIntake['fats'],
                proteins: Constants.mealDetailList[index].caloriesIntake['protien']);
            return Container(
              padding: EdgeInsets.fromLTRB(15, 25, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Meal ${index+1}',
                        style: StyleRefer.kTextStyle.copyWith(color: Colors.black, fontSize: 16),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(12, 5, 12, 5),
                        decoration: BoxDecoration(
                            color: mealData[index]['mark'] == true ? Color(0xff99B61D) : Color(0xffDF533E),
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        child: Text(mealData[index]['mark'] == true ? 'Done' : 'Pending', style: TextStyle(color: Colors.white, fontSize: 11)),
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    Constants.mealDetailList[index].des,
                    style: StyleRefer.kTextStyle.copyWith(color: Colors.black87, fontSize: 14),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            insetPadding: EdgeInsets.only(top: 30, left: 0, right: 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight:  Radius.circular(10))
                                    ),
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        AutoSizeText('Preview', style: TextStyle(fontSize: 15, color: Colors.black),),
                                        InkWell(
                                          onTap: (){
                                            Navigator.pop(context);
                                          },
                                          child: Icon(Icons.close, color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight:  Radius.circular(10))
                                    ),
                                    padding: EdgeInsets.only(bottom: 30),
                                    child: FadeInImage.assetNetwork(
                                        height: MediaQuery.of(context).size.width,
                                        placeholder: 'assets/images/placeholder.jpg',
                                        image: Constants.mealDetailList[index].image, fit: BoxFit.fill),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/placeholder.jpg',
                    image: Constants.mealDetailList[index].image),
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CaloriesChart(
                          title: 'Calories',
                          value: mealCalories,
                          unit: 'Kcal',
                          show: false,
                          leftSpace: 10,
                        ),
                        CaloriesChart(
                          title: 'Proteins',
                          value: Constants.mealDetailList[index].caloriesIntake['protien'],
                          unit: 'Grams',
                          show: true,
                          leftSpace: 15,
                        ),
                        CaloriesChart(
                          title: 'Fats',
                          value: Constants.mealDetailList[index].caloriesIntake['fats'],
                          unit: 'Grams',
                          show: true,
                          leftSpace: 15,
                        ),
                        CaloriesChart(
                          title: 'Carbs',
                          value: Constants.mealDetailList[index].caloriesIntake['carbs'],
                          unit: 'Grams',
                          show: false,
                          leftSpace: 0,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  RoundedButton(
                    title: mealData[index]['mark'] == true ? 'View Details' : 'Done with the meal?',
                    buttonRadius: 5,
                    colour: mealData[index]['mark'] == true ? ColorRefer.kSecondBlueColor : ColorRefer.kRedColor ,
                    height: 48,
                    onPressed: () async{
                      if(mealPlan.week == Constants.userMealPlanData.currentWeek && mealPlan.day == Constants.userMealPlanData.currentDay){}
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ConfirmBox(
                            title: 'Are you done with your',
                            subTitle: 'Meal?',
                            firstButtonTitle: mealData[index]['mark'] == true  ? 'Meal Marked' : 'Mark your meal as done',
                            secondButtonTitle: mealData[index]['portion'] is int ? 'Input your meal calories' : 'View your meal calories',
                            firstButtonColor: mealData[index]['mark'] == true ? ColorRefer.kGreenColor :
                            mealPlan.week == Constants.userMealPlanData.currentWeek && mealPlan.day == Constants.userMealPlanData.currentDay ?
                            ColorRefer.kRedColor: ColorRefer.kRedColor.withOpacity(0.4),
                            secondButtonColor: mealData[index]['portion'] is int ? Colors.orange :
                            mealPlan.week == Constants.userMealPlanData.currentWeek && mealPlan.day == Constants.userMealPlanData.currentDay ?
                            ColorRefer.kSecondBlueColor : ColorRefer.kSecondBlueColor.withOpacity(0.4),
                            firstButtonOnPressed: () {
                              if(mealPlan.week == Constants.userMealPlanData.currentWeek && mealPlan.day == Constants.userMealPlanData.currentDay){
                                if(mealData[index]['mark'] == false)
                                  markMeal(
                                    index: index,
                                    calories: mealCalories, time: Constants.mealDetailList[index].time,
                                    title: 'Meal ${index+1}?',
                                  );
                              }
                            },
                            secondButtonOnPressed: (){
                              if(mealPlan.week == Constants.userMealPlanData.currentWeek && mealPlan.day == Constants.userMealPlanData.currentDay){
                                viewInsight(
                                    index: index,
                                    calories: mealCalories, time: Constants.mealDetailList[index].time,
                                    title:  'Meal ${index+1}?', portion: mealData[index]['portion']
                                );
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                  Visibility(
                    visible: mealPlan.meals.length == index+1 ? true : false,
                    child: Container(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      child: Text(
                        'Enjoy : )',
                        style: StyleRefer.kTextStyle.copyWith(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: mealPlan.meals.length),
    );
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
            meal: mealPlan.mealsInEachDay,
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

class CaloriesChart extends StatelessWidget {
  CaloriesChart({this.title, this.value, this.show, this.unit, this.leftSpace});
  final bool show;
  final int value;
  final String title;
  final String unit;
  final double leftSpace;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.only(left: leftSpace, right: 15),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 1, color: show == true ? Colors.black12 : Colors.white),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: StyleRefer.kTextStyle.copyWith(color: Colors.black87, fontSize: 10),
          ),
          SizedBox(height: 3),
          Text(
            value.toString(),
            style: StyleRefer.kTextStyle.copyWith(color: Colors.black, fontSize: 13),
          ),
          SizedBox(height: 3),
          Text(
            unit,
            style: StyleRefer.kTextStyle.copyWith(color: Colors.black87, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

