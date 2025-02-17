import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/workout_model/workout_detail_model.dart';
import '../utils/colors.dart';
import '../utils/style.dart';
import '../widgets/text.dart';
import '../utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';


class CaloriesCard extends StatelessWidget {
  CaloriesCard({this.goal, this.exercise, this.food, this.remaining});
  final String goal;
  final String food;
  final String exercise;
  final String remaining;
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Color(0xff364458),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            'Calories Remaining',
            style: StyleRefer.kTextStyle.copyWith(
                color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                fontWeight: FontWeight.w900,
                fontSize: 15
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  TextCard(
                    text: goal,
                    size: 13,
                    color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                  ),
                  SizedBox(height: 3),
                  TextCard(
                    text: 'Goal',
                    size: 11,
                    color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                  )
                ],
              ),
              Column(
                children: [
                  TextCard(
                    text: food,
                    size: 13,
                    color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                  ),
                  SizedBox(height: 3),
                  TextCard(
                    text: 'Food',
                    size: 11,
                    color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                  )
                ],
              ),
              Column(
                children: [
                  TextCard(
                    text: exercise,
                    size: 13,
                    color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                  ),
                  SizedBox(height: 3),
                  TextCard(
                    text: 'Exercise',
                    size: 11,
                    color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                  )
                ],
              ),
              Column(
                children: [
                  TextCard(
                    text: remaining,
                    size: 13,
                    color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                  ),
                  SizedBox(height: 3),
                  TextCard(
                    text: 'Remaining',
                    size: 11,
                    color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class WeekMealPlanCard extends StatefulWidget {
  WeekMealPlanCard({this.onPressed, this.title, this.carbs, this.fats, this.proteins});
  final String title;
  final String proteins;
  final String fats;
  final String carbs;
  final Function onPressed;
  @override
  _WeekMealPlanCardState createState() => _WeekMealPlanCardState();
}

class _WeekMealPlanCardState extends State<WeekMealPlanCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        width: width,
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(width: 1, color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor :  Colors.white),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset('assets/icons/meal.svg'),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    widget.title,
                    style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(height: 2),
                  AutoSizeText(
                    '${widget.carbs}, ${widget.fats}, ${widget.proteins}',
                    style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeekWorkoutPlanCard extends StatefulWidget {
  WeekWorkoutPlanCard({this.onPressed, this.title, this.name, this.data, this.calBurn, this.done});
  final List<WorkoutDetailModel> data ;
  final String title;
  final String name;
  final int calBurn;
  final bool done;
  final Function onPressed;
  @override
  _WeekWorkoutPlanCardState createState() => _WeekWorkoutPlanCardState();
}

class _WeekWorkoutPlanCardState extends State<WeekWorkoutPlanCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: (){
       widget.onPressed.call();
      },
      child: Container(
        width: width,
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(width: 1, color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : Colors.white),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 5),
                child: SvgPicture.asset('assets/icons/workout.svg')
            ),
            SizedBox(width: 12),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        '${widget.title}',
                        style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Visibility(
                        visible: widget.done,
                        child: Text(
                          'Done',
                          style: StyleRefer.kTextStyle.copyWith(color: ColorRefer.kRedColor, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  AutoSizeText(
                    widget.calBurn == 0 && widget.data.isEmpty == true ? 'Rest' : widget.name.capitalize(),
                    style: StyleRefer.kTextStyle.copyWith(color: widget.calBurn == 0 && widget.data.isEmpty == true ? ColorRefer.kLightGreenColor :
                    theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  SizedBox(height: 2),
                  Visibility(
                    visible: widget.calBurn == 0 && widget.data.isEmpty == true ? false : true,
                    child: RichText(
                      text: TextSpan(children: <InlineSpan>[
                        for (var string in widget.data)
                          TextSpan(text: '${string.name} x ${string.repeat == null ? "" : string.repeat } ${string.repeat == null ? "" : 'x'} ${string.sets} Sets, ',
                              style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 11)),
                      ]),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SupplementPlanCard extends StatefulWidget {
  SupplementPlanCard({this.onPressed, this.title, this.supplement});
  final String title;
  final String supplement;
  final Function onPressed;
  @override
  _SupplementPlanCardState createState() => _SupplementPlanCardState();
}

class _SupplementPlanCardState extends State<SupplementPlanCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        width: width,
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(width: 1, color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor :  Colors.white),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/supplements.svg'),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  widget.title,
                  style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 2),
                AutoSizeText(
                  '${widget.supplement.toUpperCase()}',
                  style: StyleRefer.kTextStyle.copyWith(color: widget.supplement == 'off' ? ColorRefer.kLightGreenColor :
                  theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MealCard extends StatefulWidget {
  MealCard({this.onPressed, this.title, this.icon, this.mealInEachDay, this.color});
  final String icon;
  final String title;
  final Color color;
  final int mealInEachDay;
  final Function onPressed;
  @override
  _MealCardState createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        width: widget.mealInEachDay == 1 ? width / 1.1 : widget.mealInEachDay == 2 ? width/2.3 : width / 3.8,
        height: widget.mealInEachDay == 1 ? height / 10 : height / 7.7,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(widget.icon, height: 30, width: 30, color: Colors.white,),
            SizedBox(height: 10),
            AutoSizeText(widget.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
