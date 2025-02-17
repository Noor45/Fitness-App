import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class Graph{
  static List<BarChartGroupData> showOneTimesMealData(List calories, List meals, BuildContext context) {
    final ThemeData theme = Theme.of(context);
    int day = Constants.userMealPlanData.currentDay;
    return [
      BarChartGroupData(
        x: 0,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day >= 1 ? meals.length >= 1 ? calories[0].toDouble() : 0 : 0,
              colors: [Colors.transparent],
              rodStackItems: meals.length >= 1 ? [
                BarChartRodStackItem(
                    0,
                    ((calories[0])*1).toDouble(),
                    meals[0]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
              ] : [],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y:day >= 2 ? meals.length >= 2 ? calories[1].toDouble() : 0 : 0,
              colors: [Colors.transparent],
              rodStackItems: meals.length >= 2 ? [
                BarChartRodStackItem(
                    0,
                    ((calories[1])*1).toDouble(),
                    meals[1]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
              ] : [],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day >= 3 ? meals.length >= 3 ? calories[2].toDouble() : 0 : 0,
              colors: [Colors.transparent],
              rodStackItems: meals.length >= 3 ? [
                BarChartRodStackItem(
                    0,
                    ((calories[2])*1).toDouble(),
                    meals[2]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
              ] : [],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day >= 4 ? meals.length >= 4 ? calories[3].toDouble() : 0 : 0,
              colors: [Colors.transparent],
              rodStackItems: meals.length >= 4 ?  [
                BarChartRodStackItem(
                    0,
                    ((calories[3])*1).toDouble(),
                    meals[3]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
              ] : [],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day >= 5 ? meals.length >= 5 ? calories[4].toDouble() : 0 : 0,
              colors: [Colors.transparent],
              rodStackItems: meals.length >= 5 ?  [
                BarChartRodStackItem(
                    0,
                    ((calories[4])*1).toDouble(),
                    meals[4]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
              ] : [],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 5,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day >= 6 ? meals.length >= 6 ? calories[5].toDouble() : 0 : 0,
              colors: [Colors.transparent],
              rodStackItems: meals.length >= 6 ?  [
                BarChartRodStackItem(
                    0,
                    ((calories[5])*1).toDouble(),
                    meals[5]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
              ] : [],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 6,
        barsSpace: 4,
        barRods:  [
          BarChartRodData(
              y: day == 7 ? meals.length >= 7 ? calories[6].toDouble() : 0 : 0,
              colors: [Colors.transparent],
              rodStackItems: meals.length >= 7 ?  [
                BarChartRodStackItem(
                    0,
                    ((calories[6])*1).toDouble(),
                    meals[6]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
              ] : [],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
    ];
  }

  static List<BarChartGroupData> showTwoTimesMealData(List calories, List meals, BuildContext context) {
    final ThemeData theme = Theme.of(context);
    int day = Constants.userMealPlanData.currentDay;
    return [
      BarChartGroupData(
        x: 0,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day >= 1 ? meals.length >= 1 ? calories[0].toDouble() : 0 : 0,
              colors: [Colors.transparent],
              rodStackItems: meals.length >= 1 ? [
                BarChartRodStackItem(
                    0,
                    ((calories[0]/2)*1).toDouble(),
                    meals[0]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    ((calories[0]/2)*1).toDouble(),
                    ((calories[0]/2)*2).toDouble(),
                    meals[0]['meal_two'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
              ] : [],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y:day >= 2 ? meals.length >= 2 ? calories[1].toDouble() : 0 : 0,
              colors: [Colors.transparent],
              rodStackItems: meals.length >= 2 ? [
                BarChartRodStackItem(
                    0,
                    ((calories[1]/2)*1).toDouble(),
                    meals[1]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    ((calories[1]/2)*1).toDouble(),
                    ((calories[1]/2)*2).toDouble(),
                    meals[1]['meal_two'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
              ] : [],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day >= 3 ? meals.length >= 3 ? calories[2].toDouble() : 0 : 0,
              colors: [Colors.transparent],
              rodStackItems: meals.length >= 3 ? [
                BarChartRodStackItem(
                    0,
                    ((calories[2]/2)*1).toDouble(),
                    meals[2]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    ((calories[2]/2)*1).toDouble(),
                    ((calories[2]/2)*2).toDouble(),
                    meals[2]['meal_two'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
              ] : [],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day >= 4 ? meals.length >= 4 ? calories[3].toDouble() : 0 : 0,
              colors: [Colors.transparent],
              rodStackItems: meals.length >= 4 ?  [
                BarChartRodStackItem(
                    0,
                    ((calories[3]/2)*1).toDouble(),
                    meals[3]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    ((calories[3]/2)*1).toDouble(),
                    ((calories[3]/2)*2).toDouble(),
                    meals[3]['meal_two'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
              ] : [],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day >= 5 ? meals.length >= 5 ? calories[4].toDouble() : 0 : 0,
              colors: [Colors.transparent],
              rodStackItems: meals.length >= 5 ?  [
                BarChartRodStackItem(
                    0,
                    ((calories[4]/2)*1).toDouble(),
                    meals[4]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    ((calories[4]/2)*1).toDouble(),
                    ((calories[4]/2)*2).toDouble(),
                    meals[4]['meal_two'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
              ] : [],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 5,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day >= 6 ? meals.length >= 6 ? calories[5].toDouble() : 0 : 0,
              colors: [Colors.transparent],
              rodStackItems: meals.length >= 6 ?  [
                BarChartRodStackItem(
                    0,
                    ((calories[5]/2)*1).toDouble(),
                    meals[5]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    ((calories[5]/2)*1).toDouble(),
                    ((calories[5]/2)*2).toDouble(),
                    meals[5]['meal_two'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
              ] : [],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 6,
        barsSpace: 4,
        barRods:  [
          BarChartRodData(
              y: day == 7 ? meals.length >= 7 ? calories[6].toDouble() : 0 : 0,
              colors: [Colors.transparent],
              rodStackItems: meals.length >= 7 ?  [
                BarChartRodStackItem(
                    0,
                    ((calories[6]/2)*1).toDouble(),
                    meals[6]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    ((calories[6]/2)*1).toDouble(),
                    ((calories[6]/2)*2).toDouble(),
                    meals[6]['meal_two'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
              ] : [],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
    ];
  }

  static List<BarChartGroupData> showThreeTimesMealData(List calories, List meals, BuildContext context) {
    final ThemeData theme = Theme.of(context);
    int day = Constants.userMealPlanData.currentDay;
    return [
      BarChartGroupData(
        x: 0,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day >= 1 ? meals.length >= 1 ? calories[0].toDouble() : 0 : 0,
              colors: [Colors.transparent],
              rodStackItems: meals.length >= 1 ? [
                BarChartRodStackItem(
                    0,
                    ((calories[0]/3)*1).toDouble(),
                    meals[0]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    ((calories[0]/3)*1).toDouble(),
                    ((calories[0]/3)*2).toDouble(),
                     meals[0]['meal_two'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
                BarChartRodStackItem(
                    ((calories[0]/3)*2).toDouble(),
                    ((calories[0]/3)*3).toDouble(),
                    meals[0]['meal_three'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kThirdBlueColor),
              ] : [],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y:day >= 2 ? meals.length >= 2 ? calories[1].toDouble() : 0 : 0,
              colors: [Colors.transparent],
              rodStackItems: meals.length >= 2 ? [
                BarChartRodStackItem(
                    0,
                    ((calories[1]/3)*1).toDouble(),
                    meals[1]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    ((calories[1]/3)*1).toDouble(),
                    ((calories[1]/3)*2).toDouble(),
                    meals[1]['meal_two'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
                BarChartRodStackItem(
                    ((calories[1]/3)*2).toDouble(),
                    ((calories[1]/3)*3).toDouble(),
                    meals[1]['meal_three'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kThirdBlueColor),
              ] : [],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day >= 3 ? meals.length >= 3 ? calories[2].toDouble() : 0 : 0,
              colors: [Colors.transparent],
              rodStackItems: meals.length >= 3 ? [
                BarChartRodStackItem(
                    0,
                    ((calories[2]/3)*1).toDouble(),
                     meals[2]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    ((calories[2]/3)*1).toDouble(),
                    ((calories[2]/3)*2).toDouble(),
                    meals[2]['meal_two'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
                BarChartRodStackItem(
                    ((calories[2]/3)*2).toDouble(),
                    ((calories[2]/3)*3).toDouble(),
                    meals[2]['meal_three'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kThirdBlueColor
                  ),
              ] : [],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day >= 4 ? meals.length >= 4 ? calories[3].toDouble() : 0 : 0,
              colors: [Colors.transparent],
              rodStackItems: meals.length >= 4 ?  [
                BarChartRodStackItem(
                    0,
                    ((calories[3]/3)*1).toDouble(),
                    meals[3]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    ((calories[3]/3)*1).toDouble(),
                    ((calories[3]/3)*2).toDouble(),
                    meals[3]['meal_two'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
                BarChartRodStackItem(
                    ((calories[3]/3)*2).toDouble(),
                    ((calories[3]/3)*3).toDouble(),
                    meals[3]['meal_three'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kThirdBlueColor),
              ] : [],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day >= 5 ? meals.length >= 5 ? calories[4].toDouble() : 0 : 0,
              colors: [Colors.transparent],
              rodStackItems: meals.length >= 5 ?  [
                BarChartRodStackItem(
                    0,
                    ((calories[4]/3)*1).toDouble(),
                    meals[4]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    ((calories[4]/3)*1).toDouble(),
                    ((calories[4]/3)*2).toDouble(),
                    meals[4]['meal_two'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
                BarChartRodStackItem(
                    ((calories[4]/3)*2).toDouble(),
                    ((calories[4]/3)*3).toDouble(),
                    meals[4]['meal_three'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kThirdBlueColor),
              ] : [],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 5,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day >= 6 ? meals.length >= 6 ? calories[5].toDouble() : 0 : 0,
              colors: [Colors.transparent],
              rodStackItems: meals.length >= 6 ?  [
                BarChartRodStackItem(
                    0,
                    ((calories[5]/3)*1).toDouble(),
                    meals[5]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    ((calories[5]/3)*1).toDouble(),
                    ((calories[5]/3)*2).toDouble(),
                    meals[5]['meal_two'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
                BarChartRodStackItem(
                    ((calories[5]/3)*2).toDouble(),
                    ((calories[5]/3)*3).toDouble(),
                    meals[5]['meal_three'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kThirdBlueColor),
              ] : [],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 6,
        barsSpace: 4,
        barRods:  [
          BarChartRodData(
              y: day == 7 ? meals.length >= 7 ? calories[6].toDouble() : 0 : 0,
              colors: [Colors.transparent],
              rodStackItems: meals.length >= 7 ?  [
                BarChartRodStackItem(
                    0,
                    ((calories[6]/3)*1).toDouble(),
                    meals[6]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    ((calories[6]/3)*1).toDouble(),
                    ((calories[6]/3)*2).toDouble(),
                    meals[6]['meal_two'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
                BarChartRodStackItem(
                    ((calories[6]/3)*2).toDouble(),
                    ((calories[6]/3)*3).toDouble(),
                    meals[6]['meal_three'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kThirdBlueColor),
              ] : [],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
    ];
  }

  static List<BarChartGroupData> showFourTimesMealData(List calories, List meals, BuildContext context) {
    final ThemeData theme = Theme.of(context);
    int day = Constants.userMealPlanData.currentDay;
    return [
      BarChartGroupData(
        x: 0,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day >= 1 ? calories[0].toDouble() : 0,
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(
                    0,
                    ((calories[0]/4)*1).toDouble(),
                     meals[0]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    ((calories[0]/4)*1).toDouble(),
                    ((calories[0]/4)*2).toDouble(),
                    meals[0]['meal_two'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
                BarChartRodStackItem(
                    ((calories[0]/4)*2).toDouble(),
                    ((calories[0]/4)*3).toDouble(),
                    meals[0]['meal_three'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kThirdBlueColor),
                BarChartRodStackItem(
                    ((calories[0]/4)*3).toDouble(),
                    ((calories[0]/4)*4).toDouble(),
                    meals[0]['meal_four'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kForthBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day >= 2 ? calories[1].toDouble() : 0,
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(
                    0,
                    ((calories[1]/4)*1).toDouble(),
                    meals[1]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    ((calories[1]/4)*1).toDouble(),
                    ((calories[1]/4)*2).toDouble(),
                    meals[1]['meal_two'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
                BarChartRodStackItem(
                    ((calories[1]/4)*2).toDouble(),
                    ((calories[1]/4)*3).toDouble(),
                    meals[1]['meal_three'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kThirdBlueColor),
                BarChartRodStackItem(
                    ((calories[1]/4)*3).toDouble(),
                    ((calories[1]/4)*4).toDouble(),
                    meals[1]['meal_four'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kForthBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day >= 3 ? calories[2].toDouble() : 0,
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(
                    0,
                    ((calories[2]/4)*1).toDouble(),
                    meals[2]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    ((calories[2]/4)*1).toDouble(),
                    ((calories[2]/4)*2).toDouble(),
                    meals[2]['meal_two'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
                BarChartRodStackItem(
                    ((calories[2]/4)*2).toDouble(),
                    ((calories[2]/4)*3).toDouble(),
                    meals[2]['meal_three'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kThirdBlueColor),
                BarChartRodStackItem(
                    ((calories[2]/4)*3).toDouble(),
                    ((calories[2]/4)*4).toDouble(),
                    meals[2]['meal_four'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kForthBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day >= 4 ? calories[3].toDouble() : 0,
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(
                    0,
                    ((calories[3]/4)*1).toDouble(),
                    meals[3]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    ((calories[3]/4)*1).toDouble(),
                    ((calories[3]/4)*2).toDouble(),
                    meals[3]['meal_two'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
                BarChartRodStackItem(
                    ((calories[3]/4)*2).toDouble(),
                    ((calories[3]/4)*3).toDouble(),
                    meals[3]['meal_three'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kThirdBlueColor),
                BarChartRodStackItem(
                    ((calories[3]/4)*3).toDouble(),
                    ((calories[3]/4)*4).toDouble(),
                    meals[3]['meal_four'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kForthBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day >= 5 ? calories[4].toDouble() : 0,
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(
                    0,
                    ((calories[4]/4)*1).toDouble(),
                    meals[4]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    ((calories[4]/4)*1).toDouble(),
                    ((calories[4]/4)*2).toDouble(),
                    meals[4]['meal_two'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
                BarChartRodStackItem(
                    ((calories[4]/4)*2).toDouble(),
                    ((calories[4]/4)*3).toDouble(),
                    meals[4]['meal_three'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kThirdBlueColor),
                BarChartRodStackItem(
                    ((calories[4]/4)*3).toDouble(),
                    ((calories[4]/4)*4).toDouble(),
                    meals[4]['meal_four'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kForthBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 5,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day >= 6 ? calories[5].toDouble() : 0,
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(
                    0,
                    ((calories[5]/4)*1).toDouble(),
                    meals[5]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    ((calories[5]/4)*1).toDouble(),
                    ((calories[5]/4)*2).toDouble(),
                    meals[5]['meal_two'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
                BarChartRodStackItem(
                    ((calories[5]/4)*2).toDouble(),
                    ((calories[5]/4)*3).toDouble(),
                    meals[5]['meal_three'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kThirdBlueColor),
                BarChartRodStackItem(
                    ((calories[5]/4)*3).toDouble(),
                    ((calories[5]/4)*4).toDouble(),
                    meals[5]['meal_four'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kForthBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 6,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day == 7 ? calories[6].toDouble() : 0,
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(
                    0,
                    ((calories[6]/4)*1).toDouble(),
                    meals[6]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    ((calories[6]/4)*1).toDouble(),
                    ((calories[6]/4)*2).toDouble(),
                    meals[6]['meal_two'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
                BarChartRodStackItem(
                    ((calories[6]/4)*2).toDouble(),
                    ((calories[6]/4)*3).toDouble(),
                    meals[6]['meal_three'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kThirdBlueColor),
                BarChartRodStackItem(
                    ((calories[6]/4)*3).toDouble(),
                    ((calories[6]/4)*4).toDouble(),
                    meals[6]['meal_four'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kForthBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
    ];
  }

  static List<BarChartGroupData> showFiveTimesMealData(List calories, List meals, BuildContext context) {
    final ThemeData theme = Theme.of(context);
    int day = Constants.userMealPlanData.currentDay;
    return [
      BarChartGroupData(
        x: 0,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day >= 1 ? calories[0].toDouble() : 0,
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(
                    0,
                    ((calories[0]/5)*1),
                    meals[0]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    ((calories[0]/5)*1).toDouble(),
                    ((calories[0]/5)*2).toDouble(),
                    meals[0]['meal_two'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
                BarChartRodStackItem(
                    ((calories[0]/5)*2).toDouble(),
                    ((calories[0]/5)*3).toDouble(),
                    meals[0]['meal_three'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kThirdBlueColor),
                BarChartRodStackItem(
                    ((calories[0]/5)*3).toDouble(),
                    ((calories[0]/5)*4).toDouble(),
                    meals[0]['meal_four'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kForthBlueColor),
                BarChartRodStackItem(
                    ((calories[0]/5)*4).toDouble(),
                    ((calories[0]/5)*5).toDouble(),
                    meals[0]['meal_five'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFifthBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day >= 2 ? calories[1].toDouble() : 0,
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(
                    0,
                    ((calories[1]/5)*1).toDouble(),
                    meals[1]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    ((calories[1]/5)*1).toDouble(),
                    ((calories[1]/5)*2).toDouble(),
                    meals[1]['meal_two'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
                BarChartRodStackItem(
                    ((calories[1]/5)*2).toDouble(),
                    ((calories[1]/5)*3).toDouble(),
                    meals[1]['meal_three'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kThirdBlueColor),
                BarChartRodStackItem(
                    ((calories[1]/5)*3).toDouble(),
                    ((calories[1]/5)*4).toDouble(),
                    meals[1]['meal_four'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kForthBlueColor),
                BarChartRodStackItem(
                    ((calories[1]/5)*4).toDouble(),
                    ((calories[1]/5)*5).toDouble(),
                    meals[1]['meal_five'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFifthBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day >= 3 ? calories[2].toDouble() : 0,
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(
                    0,
                    ((calories[2]/5)*1).toDouble(),
                    meals[2]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    ((calories[2]/5)*1).toDouble(),
                    ((calories[2]/5)*2).toDouble(),
                    meals[2]['meal_two'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
                BarChartRodStackItem(
                    ((calories[2]/5)*2).toDouble(),
                    ((calories[2]/5)*3).toDouble(),
                    meals[2]['meal_three'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kThirdBlueColor),
                BarChartRodStackItem(
                    ((calories[2]/5)*3).toDouble(),
                    ((calories[2]/5)*4).toDouble(),
                     meals[2]['meal_four'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kForthBlueColor),
                BarChartRodStackItem(
                    ((calories[2]/5)*4).toDouble(),
                    ((calories[2]/5)*5).toDouble(),
                    meals[2]['meal_five'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFifthBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day >= 4 ? calories[3].toDouble() : 0,
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(
                    0,
                    ((calories[3]/5)*1).toDouble(),
                    meals[3]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    ((calories[3]/5)*1).toDouble(),
                    ((calories[3]/5)*2).toDouble(),
                    meals[3]['meal_two'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
                BarChartRodStackItem(
                    ((calories[3]/5)*2).toDouble(),
                    ((calories[3]/5)*3).toDouble(),
                    meals[3]['meal_three'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kThirdBlueColor),
                BarChartRodStackItem(
                    ((calories[3]/5)*3).toDouble(),
                    ((calories[3]/5)*4).toDouble(),
                    meals[3]['meal_four'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kForthBlueColor),
                BarChartRodStackItem(
                    ((calories[3]/5)*4).toDouble(),
                    ((calories[3]/5)*5).toDouble(),
                    meals[3]['meal_five'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFifthBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day >= 5 ? calories[4].toDouble() : 0,
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(
                    0,
                    ((calories[4]/5)*1).toDouble(),
                    meals[4]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    ((calories[4]/5)*1).toDouble(),
                    ((calories[4]/5)*2).toDouble(),
                    meals[4]['meal_two'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
                BarChartRodStackItem(
                    ((calories[4]/5)*2).toDouble(),
                    ((calories[4]/5)*3).toDouble(),
                    meals[4]['meal_three'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kThirdBlueColor),
                BarChartRodStackItem(
                    ((calories[4]/5)*3).toDouble(),
                    ((calories[4]/5)*4).toDouble(),
                    meals[4]['meal_four'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kForthBlueColor),
                BarChartRodStackItem(
                    ((calories[4]/5)*4).toDouble(),
                    ((calories[4]/5)*5).toDouble(),
                    meals[4]['meal_five'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFifthBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 5,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day >= 6 ? calories[5].toDouble() : 0,
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(
                    0,
                    ((calories[5]/5)*1).toDouble(),
                    meals[5]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    ((calories[5]/5)*1).toDouble(),
                    ((calories[5]/5)*2).toDouble(),
                    meals[5]['meal_two'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
                BarChartRodStackItem(
                    ((calories[5]/5)*2).toDouble(),
                    ((calories[5]/5)*3).toDouble(),
                    meals[5]['meal_three'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kThirdBlueColor),
                BarChartRodStackItem(
                    ((calories[5]/5)*3).toDouble(),
                    ((calories[5]/5)*4).toDouble(),
                    meals[5]['meal_four'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kForthBlueColor),
                BarChartRodStackItem(
                    ((calories[5]/5)*4).toDouble(),
                    ((calories[5]/5)*5).toDouble(),
                    meals[5]['meal_five'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFifthBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 6,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day == 7 ? calories[6].toDouble() : 0,
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(
                    0,
                    ((calories[6]/5)*1).toDouble(),
                    meals[6]['meal_one'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    ((calories[6]/5)*1).toDouble(),
                    ((calories[6]/5)*2).toDouble(),
                    meals[6]['meal_two'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
                BarChartRodStackItem(
                    ((calories[6]/5)*2).toDouble(),
                    ((calories[6]/5)*3).toDouble(),
                    meals[6]['meal_three'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kThirdBlueColor),
                BarChartRodStackItem(
                    ((calories[6]/5)*3).toDouble(),
                    ((calories[6]/5)*4).toDouble(),
                    meals[6]['meal_four'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kForthBlueColor),
                BarChartRodStackItem(
                    ((calories[6]/5)*4).toDouble(),
                    ((calories[6]/5)*5).toDouble(),
                    meals[6]['meal_five'] == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFifthBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
    ];
  }

  static List<BarChartGroupData> showSixTimesMealData(List userMealPortion, List calories, BuildContext context) {
    var emptyValue= {false, 0};
    final ThemeData theme = Theme.of(context);
    int day = Constants.userMealPlanData.currentDay;
    return [
      BarChartGroupData(
        x: 0,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: calories[0].toDouble(),
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(
                    0,
                    userMealPortion[0]['meal_one'] != emptyValue && userMealPortion[0]['meal_one'] != null ? userMealPortion[0]['meal_one'].last.toDouble() : 0,
                    userMealPortion[0]['meal_one'] == emptyValue || userMealPortion[0]['meal_one'] == null ? ColorRefer.kBackgroundColor : userMealPortion[0]['meal_one'].first == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    userMealPortion[0]['meal_one'] != emptyValue && userMealPortion[0]['meal_one'] != null ? userMealPortion[0]['meal_one'].last.toDouble() : 0,
                    ((userMealPortion[0]['meal_one'] != emptyValue &&userMealPortion[0]['meal_one'] !=  null ? userMealPortion[0]['meal_one'].last : 0) + ( userMealPortion[0]['meal_two'] != null ? userMealPortion[0]['meal_two'].last : 0)).toDouble(),
                    userMealPortion[0]['meal_two'] == emptyValue || userMealPortion[0]['meal_two'] == null ? ColorRefer.kBackgroundColor : userMealPortion[0]['meal_two'].first == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
                BarChartRodStackItem(
                    ((userMealPortion[0]['meal_one'] != emptyValue && userMealPortion[0]['meal_one'] != null ? userMealPortion[0]['meal_one'].last : 0) + (userMealPortion[0]['meal_two'] != emptyValue && userMealPortion[0]['meal_two'] != null ? userMealPortion[0]['meal_two'].last : 0)).toDouble(),
                    ((userMealPortion[0]['meal_one'] != emptyValue && userMealPortion[0]['meal_one'] != null ? userMealPortion[0]['meal_one'].last : 0) + (userMealPortion[0]['meal_two'] != emptyValue && userMealPortion[0]['meal_two'] != null ? userMealPortion[0]['meal_two'].last : 0) + (userMealPortion[0]['meal_three'] != emptyValue && userMealPortion[0]['meal_three'] != null ? userMealPortion[0]['meal_three'].last : 0)).toDouble(),
                    userMealPortion[0]['meal_three'] == emptyValue || userMealPortion[0]['meal_three'] == null ? ColorRefer.kBackgroundColor : userMealPortion[0]['meal_three'].first == false ? theme.brightness == Brightness.light ? Colors.white :
                    ColorRefer.kBackgroundColor : ColorRefer.kThirdBlueColor),
                BarChartRodStackItem(
                    ((userMealPortion[0]['meal_one'] != emptyValue && userMealPortion[0]['meal_one'] != null ? userMealPortion[0]['meal_one'].last : 0) + (userMealPortion[0]['meal_two'] != emptyValue && userMealPortion[0]['meal_two'] != null ? userMealPortion[0]['meal_two'].last : 0) + (userMealPortion[0]['meal_three'] != emptyValue && userMealPortion[0]['meal_three'] != null ? userMealPortion[0]['meal_three'].last : 0)).toDouble(),
                    ((userMealPortion[0]['meal_one'] != emptyValue && userMealPortion[0]['meal_one'] != null ? userMealPortion[0]['meal_one'].last : 0) + (userMealPortion[0]['meal_two'] != emptyValue && userMealPortion[0]['meal_two'] != null ? userMealPortion[0]['meal_two'].last : 0) + (userMealPortion[0]['meal_three'] != emptyValue && userMealPortion[0]['meal_three'] != null ? userMealPortion[0]['meal_three'].last : 0) + (userMealPortion[0]['meal_four'] != emptyValue && userMealPortion[0]['meal_four'] != null ? userMealPortion[0]['meal_four'].last : 0)).toDouble(),
                    userMealPortion[0]['meal_four'] == emptyValue || userMealPortion[0]['meal_four'] == null ? ColorRefer.kBackgroundColor : userMealPortion[0]['meal_four'].first == false ?
                    theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kForthBlueColor),
                BarChartRodStackItem(
                    ((userMealPortion[0]['meal_one'] != emptyValue && userMealPortion[0]['meal_one'] != null ? userMealPortion[0]['meal_one'].last : 0) + (userMealPortion[0]['meal_two'] != emptyValue && userMealPortion[0]['meal_two'] != null ? userMealPortion[0]['meal_two'].last : 0) + (userMealPortion[0]['meal_three'] != emptyValue && userMealPortion[0]['meal_three'] != null ? userMealPortion[0]['meal_three'].last : 0) + (userMealPortion[0]['meal_four'] != emptyValue && userMealPortion[0]['meal_four'] != null ? userMealPortion[0]['meal_four'].last : 0)).toDouble(),
                    ((userMealPortion[0]['meal_one'] != emptyValue && userMealPortion[0]['meal_one'] != null ? userMealPortion[0]['meal_one'].last : 0) + (userMealPortion[0]['meal_two'] != emptyValue && userMealPortion[0]['meal_two'] != null ? userMealPortion[0]['meal_two'].last : 0) + (userMealPortion[0]['meal_three'] != emptyValue && userMealPortion[0]['meal_three'] != null ? userMealPortion[0]['meal_three'].last : 0) + (userMealPortion[0]['meal_four'] != emptyValue && userMealPortion[0]['meal_four'] != null ? userMealPortion[0]['meal_four'].last : 0) + (userMealPortion[0]['meal_five'] != emptyValue && userMealPortion[0]['meal_five'] != null ? userMealPortion[0]['meal_five'].last : 0)).toDouble(),
                    userMealPortion[0]['meal_five'] == emptyValue || userMealPortion[0]['meal_five'] == null ? ColorRefer.kBackgroundColor : userMealPortion[0]['meal_five'].first == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFifthBlueColor),
                BarChartRodStackItem(
                    ((userMealPortion[0]['meal_one'] != emptyValue && userMealPortion[0]['meal_one'] != null ? userMealPortion[0]['meal_one'].last : 0) + (userMealPortion[0]['meal_two'] != emptyValue && userMealPortion[0]['meal_two'] != null ? userMealPortion[0]['meal_two'].last : 0) + (userMealPortion[0]['meal_three'] != emptyValue && userMealPortion[0]['meal_three'] != null ? userMealPortion[0]['meal_three'].last : 0) + (userMealPortion[0]['meal_four'] != emptyValue && userMealPortion[0]['meal_four'] != null ? userMealPortion[0]['meal_four'].last : 0) + (userMealPortion[0]['meal_five'] != emptyValue && userMealPortion[0]['meal_five'] != null ? userMealPortion[0]['meal_five'].last : 0)).toDouble(),
                    ((userMealPortion[0]['meal_one'] != emptyValue && userMealPortion[0]['meal_one'] != null ? userMealPortion[0]['meal_one'].last : 0) + (userMealPortion[0]['meal_two'] != emptyValue && userMealPortion[0]['meal_two'] != null ? userMealPortion[0]['meal_two'].last : 0) + (userMealPortion[0]['meal_three'] != emptyValue && userMealPortion[0]['meal_three'] != null ? userMealPortion[0]['meal_three'].last : 0) + (userMealPortion[0]['meal_four'] != emptyValue && userMealPortion[0]['meal_four'] != null ? userMealPortion[0]['meal_four'].last : 0) + (userMealPortion[0]['meal_five'] != emptyValue && userMealPortion[0]['meal_five'] != null ? userMealPortion[0]['meal_five'].last : 0) + (userMealPortion[0]['meal_six'] != emptyValue && userMealPortion[0]['meal_six'] != null ? userMealPortion[0]['meal_six'].last : 0)).toDouble(),
                    userMealPortion[0]['meal_six'] == emptyValue || userMealPortion[0]['meal_six'] == null ? ColorRefer.kBackgroundColor : userMealPortion[0]['meal_six'].first == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSixthBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: day >= 2 ? calories[1].toDouble() : 0,
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(
                    0,
                    userMealPortion[1]['meal_one'].last.toDouble() != emptyValue && userMealPortion[1]['meal_one'] != null ? userMealPortion[1]['meal_one'].last.toDouble() : 0,
                    userMealPortion[1]['meal_one'].first == emptyValue || userMealPortion[1]['meal_one'] == null ? ColorRefer.kBackgroundColor : userMealPortion[1]['meal_one'].first == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    userMealPortion[1]['meal_one'] != emptyValue && userMealPortion[1]['meal_one'] != null ? userMealPortion[1]['meal_one'].last.toDouble() : 0,
                    ((userMealPortion[1]['meal_one'] != emptyValue && userMealPortion[1]['meal_one'] != null ? userMealPortion[1]['meal_one'].last : 0) + (userMealPortion[1]['meal_two'] != emptyValue && userMealPortion[1]['meal_two'] != null ? userMealPortion[1]['meal_two'].last : 0)).toDouble(),
                    userMealPortion[1]['meal_two'] == emptyValue || userMealPortion[1]['meal_two'] == null ? ColorRefer.kBackgroundColor : userMealPortion[1]['meal_two'].first == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
                BarChartRodStackItem(
                    ((userMealPortion[1]['meal_one'] != emptyValue && userMealPortion[1]['meal_one'] != null ? userMealPortion[1]['meal_one'].last : 0) + (userMealPortion[1]['meal_two'] != emptyValue && userMealPortion[1]['meal_two'] != null ? userMealPortion[1]['meal_two'].last : 0)).toDouble(),
                    ((userMealPortion[1]['meal_one'] != emptyValue && userMealPortion[1]['meal_one'] != null ? userMealPortion[1]['meal_one'].last : 0) + (userMealPortion[1]['meal_two'] != emptyValue && userMealPortion[1]['meal_two'] != null ? userMealPortion[1]['meal_two'].last : 0) + (userMealPortion[1]['meal_three'] != emptyValue && userMealPortion[1]['meal_three'] != null ? userMealPortion[1]['meal_three'].last : 0)).toDouble(),
                    userMealPortion[1]['meal_three'] == emptyValue || userMealPortion[1]['meal_three'] == null ? ColorRefer.kBackgroundColor : userMealPortion[1]['meal_three'].first == false ? theme.brightness == Brightness.light ? Colors.white :
                    ColorRefer.kBackgroundColor : ColorRefer.kThirdBlueColor),
                BarChartRodStackItem(
                    ((userMealPortion[1]['meal_one'] != emptyValue && userMealPortion[1]['meal_one'] != null ? userMealPortion[1]['meal_one'].last : 0) + (userMealPortion[1]['meal_two'] != emptyValue && userMealPortion[1]['meal_two'] != null ? userMealPortion[1]['meal_two'].last : 0) + (userMealPortion[1]['meal_three'] != emptyValue && userMealPortion[1]['meal_three'] != null ? userMealPortion[1]['meal_three'].last : 0)).toDouble(),
                    ((userMealPortion[1]['meal_one'] != emptyValue && userMealPortion[1]['meal_one'] !=  null ? userMealPortion[1]['meal_one'].last : 0) + (userMealPortion[1]['meal_two'] != emptyValue && userMealPortion[1]['meal_two'] != null ? userMealPortion[1]['meal_two'].last : 0) + (userMealPortion[1]['meal_three'] != emptyValue && userMealPortion[1]['meal_three'] != null ? userMealPortion[1]['meal_three'].last : 0) + (userMealPortion[1]['meal_four'] != emptyValue && userMealPortion[1]['meal_four'] != null && userMealPortion[1]['meal_four'] != null ? userMealPortion[1]['meal_four'].last : 0)).toDouble(),
                    userMealPortion[1]['meal_four'] == emptyValue || userMealPortion[1]['meal_four'] == null ? ColorRefer.kBackgroundColor : userMealPortion[1]['meal_four'].first == false ?
                    theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kForthBlueColor),
                BarChartRodStackItem(
                    ((userMealPortion[1]['meal_one'] != emptyValue && userMealPortion[0]['meal_one'] != null ? userMealPortion[1]['meal_one'].last : 0) + (userMealPortion[1]['meal_two'] != emptyValue && userMealPortion[1]['meal_two'] != null ? userMealPortion[1]['meal_two'].last : 0) + (userMealPortion[1]['meal_three'] != emptyValue && userMealPortion[1]['meal_three'] != null ? userMealPortion[1]['meal_three'].last : 0) + (userMealPortion[1]['meal_four'] != emptyValue && userMealPortion[1]['meal_four'] != null && userMealPortion[1]['meal_four'] != null ? userMealPortion[1]['meal_four'].last : 0)).toDouble(),
                    ((userMealPortion[1]['meal_one'] != emptyValue && userMealPortion[1]['meal_one'] != null ? userMealPortion[1]['meal_one'].last : 0) + (userMealPortion[1]['meal_two'] != emptyValue && userMealPortion[1]['meal_two'] != null ? userMealPortion[1]['meal_two'].last : 0) + (userMealPortion[1]['meal_three'] != emptyValue && userMealPortion[1]['meal_three'] != null ? userMealPortion[1]['meal_three'].last : 0) + (userMealPortion[1]['meal_four'] != emptyValue && userMealPortion[1]['meal_four'] != null && userMealPortion[1]['meal_four'] != null ? userMealPortion[1]['meal_four'].last : 0) + (userMealPortion[1]['meal_five'] != emptyValue && userMealPortion[1]['meal_five'] != null ? userMealPortion[1]['meal_five'].last : 0)).toDouble(),
                    userMealPortion[1]['meal_five'] == emptyValue || userMealPortion[1]['meal_five'] == null ? ColorRefer.kBackgroundColor : userMealPortion[1]['meal_five'].first == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFifthBlueColor),
                BarChartRodStackItem(
                    ((userMealPortion[1]['meal_one'] != emptyValue && userMealPortion[1]['meal_one'] != null ? userMealPortion[1]['meal_one'].last : 0) + (userMealPortion[1]['meal_two'] != emptyValue && userMealPortion[1]['meal_two'] != null ? userMealPortion[1]['meal_two'].last : 0) + (userMealPortion[1]['meal_three'] != emptyValue && userMealPortion[1]['meal_three'] != null ? userMealPortion[1]['meal_three'].last : 0) + (userMealPortion[1]['meal_four'] != emptyValue && userMealPortion[1]['meal_four'] != null && userMealPortion[1]['meal_four'] != null ? userMealPortion[1]['meal_four'].last : 0) + (userMealPortion[1]['meal_five'] != emptyValue && userMealPortion[1]['meal_five'] != null ? userMealPortion[1]['meal_five'].last : 0)).toDouble(),
                    ((userMealPortion[1]['meal_one'] != emptyValue && userMealPortion[1]['meal_one'] != null ? userMealPortion[1]['meal_one'].last : 0) + (userMealPortion[1]['meal_two'] != emptyValue && userMealPortion[1]['meal_two'] != null ? userMealPortion[1]['meal_two'].last : 0) + (userMealPortion[1]['meal_three'] != emptyValue && userMealPortion[1]['meal_three'] != null ? userMealPortion[1]['meal_three'].last : 0) + (userMealPortion[1]['meal_four'] != emptyValue && userMealPortion[1]['meal_four'] != null && userMealPortion[1]['meal_four'] != null ? userMealPortion[1]['meal_four'].last : 0) + (userMealPortion[1]['meal_five'] != emptyValue && userMealPortion[1]['meal_five'] != null ? userMealPortion[1]['meal_five'].last : 0) + (userMealPortion[1]['meal_six'] != emptyValue && userMealPortion[1]['meal_six'] != null ? userMealPortion[1]['meal_six'].last : 0)).toDouble(),
                    userMealPortion[1]['meal_six'] == emptyValue || userMealPortion[1]['meal_six'] == null ? ColorRefer.kBackgroundColor : userMealPortion[1]['meal_six'].first == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSixthBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: calories[2].toDouble(),
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(
                    0,
                    (userMealPortion[2]['meal_one'] != emptyValue && userMealPortion[2]['meal_one'] != null ? userMealPortion[2]['meal_one'].last.toDouble() : 0),
                    userMealPortion[2]['meal_one'] == emptyValue && userMealPortion[2]['meal_one'] == null ? ColorRefer.kBackgroundColor : userMealPortion[2]['meal_one'].first == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    (userMealPortion[2]['meal_one'] != emptyValue && userMealPortion[2]['meal_one'] != null ? userMealPortion[2]['meal_one'].last.toDouble() : 0),
                    ((userMealPortion[2]['meal_one'] != emptyValue && userMealPortion[2]['meal_one'] != null ? userMealPortion[2]['meal_one'].last : 0 ) + (userMealPortion[2]['meal_two'] != emptyValue && userMealPortion[2]['meal_two'] != null ? userMealPortion[2]['meal_two'].last : 0)).toDouble(),
                    userMealPortion[2]['meal_two'] == emptyValue || userMealPortion[2]['meal_two'] == null ? ColorRefer.kBackgroundColor : userMealPortion[2]['meal_two'].first == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
                BarChartRodStackItem(
                    ((userMealPortion[2]['meal_one'] != emptyValue && userMealPortion[2]['meal_one'] != null ? userMealPortion[2]['meal_one'].last : 0) + (userMealPortion[2]['meal_two'] != emptyValue && userMealPortion[2]['meal_two'] != null ? userMealPortion[2]['meal_two'].last : 0)).toDouble(),
                    ((userMealPortion[2]['meal_one'] != emptyValue && userMealPortion[2]['meal_one'] != null ? userMealPortion[2]['meal_one'].last : 0) + (userMealPortion[2]['meal_two'] != emptyValue && userMealPortion[2]['meal_two'] != null ? userMealPortion[2]['meal_two'].last : 0) + (userMealPortion[2]['meal_three'] != emptyValue && userMealPortion[2]['meal_three'] != null ? userMealPortion[2]['meal_three'].last : 0)).toDouble(),
                    userMealPortion[2]['meal_three'] == emptyValue || userMealPortion[2]['meal_three'] == null ? ColorRefer.kBackgroundColor : userMealPortion[2]['meal_three'].first == false ? theme.brightness == Brightness.light ? Colors.white :
                    ColorRefer.kBackgroundColor : ColorRefer.kThirdBlueColor),
                BarChartRodStackItem(
                    ((userMealPortion[2]['meal_one'] != emptyValue && userMealPortion[2]['meal_one'] != null ? userMealPortion[2]['meal_one'].last : 0) + (userMealPortion[2]['meal_two'] != emptyValue && userMealPortion[2]['meal_two'] != null ? userMealPortion[2]['meal_two'].last : 0) + (userMealPortion[2]['meal_three'] != emptyValue && userMealPortion[2]['meal_three'] != null ? userMealPortion[2]['meal_three'].last : 0)).toDouble(),
                    ((userMealPortion[2]['meal_one'] != emptyValue && userMealPortion[2]['meal_one'] != null ? userMealPortion[2]['meal_one'].last : 0) + (userMealPortion[2]['meal_two'] != emptyValue && userMealPortion[2]['meal_two'] != null ? userMealPortion[2]['meal_two'].last : 0) + (userMealPortion[2]['meal_three'] != emptyValue && userMealPortion[2]['meal_three'] != null ? userMealPortion[2]['meal_three'].last : 0) + (userMealPortion[2]['meal_four'] != emptyValue && userMealPortion[2]['meal_four'] != null ? userMealPortion[2]['meal_four'].last : 0)).toDouble(),
                    userMealPortion[2]['meal_four'] == emptyValue || userMealPortion[2]['meal_four'] == null ? ColorRefer.kBackgroundColor : userMealPortion[2]['meal_four'].first == false ?
                    theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kForthBlueColor),
                BarChartRodStackItem(
                    ((userMealPortion[2]['meal_one'] != emptyValue && userMealPortion[2]['meal_one'] != null ? userMealPortion[2]['meal_one'].last : 0) + (userMealPortion[2]['meal_two'] != emptyValue && userMealPortion[2]['meal_two'] != null ? userMealPortion[2]['meal_two'].last : 0) + (userMealPortion[2]['meal_three'] != emptyValue && userMealPortion[2]['meal_three'] != null ? userMealPortion[2]['meal_three'].last : 0) + (userMealPortion[2]['meal_four'] != emptyValue && userMealPortion[2]['meal_four'] != null ? userMealPortion[2]['meal_four'].last : 0)).toDouble(),
                    ((userMealPortion[2]['meal_one'] != emptyValue && userMealPortion[2]['meal_one'] != null ? userMealPortion[2]['meal_one'].last : 0) + (userMealPortion[2]['meal_two'] != emptyValue && userMealPortion[2]['meal_two'] != null ? userMealPortion[2]['meal_two'].last : 0) + (userMealPortion[2]['meal_three'] != emptyValue && userMealPortion[2]['meal_three'] != null ? userMealPortion[2]['meal_three'].last : 0) + (userMealPortion[2]['meal_four'] != emptyValue && userMealPortion[2]['meal_four'] != null ? userMealPortion[2]['meal_four'].last : 0) + (userMealPortion[2]['meal_five'] != emptyValue && userMealPortion[2]['meal_five'] != null ? userMealPortion[2]['meal_five'].last : 0)).toDouble(),
                    userMealPortion[2]['meal_five'] == emptyValue || userMealPortion[2]['meal_five'] == null ? ColorRefer.kBackgroundColor : userMealPortion[2]['meal_five'].first == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFifthBlueColor),
                BarChartRodStackItem(
                    ((userMealPortion[2]['meal_one'] != emptyValue && userMealPortion[2]['meal_one'] != null ? userMealPortion[2]['meal_one'].last : 0) + (userMealPortion[2]['meal_two'] != emptyValue && userMealPortion[2]['meal_two'] != null ? userMealPortion[2]['meal_two'].last : 0) + (userMealPortion[2]['meal_three'] != emptyValue && userMealPortion[2]['meal_three'] != null ? userMealPortion[2]['meal_three'].last : 0) + (userMealPortion[2]['meal_four'] != emptyValue && userMealPortion[2]['meal_four'] != null ? userMealPortion[2]['meal_four'].last : 0) + (userMealPortion[2]['meal_five'] != emptyValue && userMealPortion[2]['meal_five'] != null ? userMealPortion[2]['meal_five'].last : 0)).toDouble(),
                    ((userMealPortion[2]['meal_one'] != emptyValue && userMealPortion[2]['meal_one'] != null ? userMealPortion[2]['meal_one'].last : 0) + (userMealPortion[2]['meal_two'] != emptyValue && userMealPortion[2]['meal_two'] != null ? userMealPortion[2]['meal_two'].last : 0) + (userMealPortion[2]['meal_three'] != emptyValue && userMealPortion[2]['meal_three'] != null ? userMealPortion[2]['meal_three'].last : 0) + (userMealPortion[2]['meal_four'] != emptyValue && userMealPortion[2]['meal_four'] != null ? userMealPortion[2]['meal_four'].last : 0) + (userMealPortion[2]['meal_five'] != emptyValue && userMealPortion[2]['meal_five'] != null ? userMealPortion[2]['meal_five'].last : 0) + (userMealPortion[2]['meal_six'] != emptyValue && userMealPortion[2]['meal_six'] != null ? userMealPortion[2]['meal_six'].last : 0)).toDouble(),
                    userMealPortion[2]['meal_six'] == emptyValue || userMealPortion[2]['meal_six'] == null ? ColorRefer.kBackgroundColor : userMealPortion[2]['meal_six'].first == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSixthBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: calories[3].toDouble(),
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(
                    0,
                    (userMealPortion[3]['meal_one'] != emptyValue && userMealPortion[3]['meal_one'] != null ? userMealPortion[3]['meal_one'].last.toDouble() : 0),
                    userMealPortion[3]['meal_one'] == emptyValue || userMealPortion[3]['meal_one'] == null ? ColorRefer.kBackgroundColor : userMealPortion[3]['meal_one'].first == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    userMealPortion[3]['meal_one'] != emptyValue && userMealPortion[3]['meal_one'] != null ? userMealPortion[3]['meal_one'].last.toDouble() : 0,
                    ((userMealPortion[3]['meal_one'] != emptyValue && userMealPortion[3]['meal_one'] != null ? userMealPortion[3]['meal_one'].last : 0) + (userMealPortion[3]['meal_two'] != emptyValue && userMealPortion[3]['meal_two'] != null ? userMealPortion[3]['meal_two'].last : 0)).toDouble(),
                    userMealPortion[3]['meal_two'] == emptyValue || userMealPortion[3]['meal_two'] == null ? ColorRefer.kBackgroundColor : userMealPortion[3]['meal_two'].first == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
                BarChartRodStackItem(
                    ((userMealPortion[3]['meal_one'] != emptyValue && userMealPortion[3]['meal_one'] != null ? userMealPortion[3]['meal_one'].last : 0) + (userMealPortion[3]['meal_two'] != emptyValue && userMealPortion[3]['meal_two'] != null ? userMealPortion[3]['meal_two'].last : 0)).toDouble(),
                    ((userMealPortion[3]['meal_one'] != emptyValue && userMealPortion[3]['meal_one'] != null ? userMealPortion[3]['meal_one'].last : 0) + (userMealPortion[3]['meal_two'] != emptyValue && userMealPortion[3]['meal_two'] != null ? userMealPortion[3]['meal_two'].last : 0) + (userMealPortion[3]['meal_three'] != emptyValue && userMealPortion[3]['meal_three'] != null ? userMealPortion[3]['meal_three'].last : 0)).toDouble(),
                    userMealPortion[3]['meal_three'] == emptyValue || userMealPortion[3]['meal_three'] == null ? ColorRefer.kBackgroundColor : userMealPortion[3]['meal_three'].first == false ? theme.brightness == Brightness.light ? Colors.white :
                    ColorRefer.kBackgroundColor : ColorRefer.kThirdBlueColor),
                BarChartRodStackItem(
                    ((userMealPortion[3]['meal_one'] != emptyValue && userMealPortion[3]['meal_one'] != null ? userMealPortion[3]['meal_one'].last : 0) + (userMealPortion[3]['meal_two'] != emptyValue && userMealPortion[3]['meal_two'] != null ? userMealPortion[3]['meal_two'].last : 0) + (userMealPortion[3]['meal_three'] != emptyValue && userMealPortion[3]['meal_three'] != null ? userMealPortion[3]['meal_three'].last : 0)).toDouble(),
                    ((userMealPortion[3]['meal_one'] != emptyValue && userMealPortion[3]['meal_one'] != null ? userMealPortion[3]['meal_one'].last : 0) + (userMealPortion[3]['meal_two'] != emptyValue && userMealPortion[3]['meal_two'] != null ? userMealPortion[3]['meal_two'].last : 0) + (userMealPortion[3]['meal_three'] != emptyValue && userMealPortion[3]['meal_three'] != null ? userMealPortion[3]['meal_three'].last : 0) + (userMealPortion[3]['meal_four'] != emptyValue && userMealPortion[3]['meal_four'] != null ? userMealPortion[3]['meal_four'].last : 0)).toDouble(),
                    userMealPortion[3]['meal_four'] == emptyValue || userMealPortion[3]['meal_four'] == null ? ColorRefer.kBackgroundColor : userMealPortion[3]['meal_four'].first == false ?
                    theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kForthBlueColor),
                BarChartRodStackItem(
                    ((userMealPortion[3]['meal_one'] != emptyValue && userMealPortion[3]['meal_one'] != null ? userMealPortion[3]['meal_one'].last : 0) + (userMealPortion[3]['meal_two'] != emptyValue && userMealPortion[3]['meal_two'] != null ? userMealPortion[3]['meal_two'].last : 0) + (userMealPortion[3]['meal_three'] != emptyValue && userMealPortion[3]['meal_three'] != null ? userMealPortion[3]['meal_three'].last : 0) + (userMealPortion[3]['meal_four'] != emptyValue && userMealPortion[3]['meal_four'] != null ? userMealPortion[3]['meal_four'].last : 0)).toDouble(),
                    ((userMealPortion[3]['meal_one'] != emptyValue && userMealPortion[3]['meal_one'] != null ? userMealPortion[3]['meal_one'].last : 0) + (userMealPortion[3]['meal_two'] != emptyValue && userMealPortion[3]['meal_two'] != null ? userMealPortion[3]['meal_two'].last : 0 )+ (userMealPortion[3]['meal_three'] != emptyValue && userMealPortion[3]['meal_three'] != null ? userMealPortion[3]['meal_three'].last : 0) + (userMealPortion[3]['meal_four'] != emptyValue && userMealPortion[3]['meal_four'] != null ? userMealPortion[3]['meal_four'].last : 0) + (userMealPortion[3]['meal_five'] != emptyValue && userMealPortion[3]['meal_five'] != null ? userMealPortion[3]['meal_five'].last : 0)).toDouble(),
                    userMealPortion[3]['meal_five'] == emptyValue || userMealPortion[3]['meal_five'] == null ? ColorRefer.kBackgroundColor : userMealPortion[3]['meal_five'].first == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFifthBlueColor),
                BarChartRodStackItem(
                    ((userMealPortion[3]['meal_one'] != emptyValue && userMealPortion[3]['meal_one'] != null ? userMealPortion[3]['meal_one'].last : 0) + (userMealPortion[3]['meal_two'] != emptyValue && userMealPortion[3]['meal_two'] != null ? userMealPortion[3]['meal_two'].last : 0) + (userMealPortion[3]['meal_three'] != emptyValue && userMealPortion[3]['meal_three'] != null ? userMealPortion[3]['meal_three'].last : 0) + (userMealPortion[3]['meal_four'] != emptyValue && userMealPortion[3]['meal_four'] != null ? userMealPortion[3]['meal_four'].last : 0) + (userMealPortion[3]['meal_five'] != emptyValue && userMealPortion[3]['meal_five'] != null ? userMealPortion[3]['meal_five'].last : 0)).toDouble(),
                    ((userMealPortion[3]['meal_one'] != emptyValue && userMealPortion[3]['meal_one'] != null ? userMealPortion[3]['meal_one'].last : 0) + (userMealPortion[3]['meal_two'] != emptyValue && userMealPortion[3]['meal_two'] != null ? userMealPortion[3]['meal_two'].last : 0) + (userMealPortion[3]['meal_three'] != emptyValue && userMealPortion[3]['meal_three'] != null ? userMealPortion[3]['meal_three'].last : 0) + (userMealPortion[3]['meal_four'] != emptyValue && userMealPortion[3]['meal_four'] != null ? userMealPortion[3]['meal_four'].last : 0) + (userMealPortion[3]['meal_five'] != emptyValue && userMealPortion[3]['meal_five'] != null ? userMealPortion[3]['meal_five'].last : 0) + (userMealPortion[3]['meal_six'] != emptyValue && userMealPortion[3]['meal_six'] != null ? userMealPortion[3]['meal_six'].last : 0)).toDouble(),
                    userMealPortion[3]['meal_six'] == emptyValue || userMealPortion[3]['meal_six'] == null ? ColorRefer.kBackgroundColor : userMealPortion[3]['meal_six'].first == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSixthBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: calories[4].toDouble(),
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(
                    0,
                    (userMealPortion[4]['meal_one'] != emptyValue && userMealPortion[4]['meal_one'] != null ? userMealPortion[4]['meal_one'].last.toDouble() : 0),
                    userMealPortion[4]['meal_one'] == emptyValue || userMealPortion[4]['meal_one'] == null ? ColorRefer.kBackgroundColor : userMealPortion[4]['meal_one'].first == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    userMealPortion[4]['meal_one'] != emptyValue && userMealPortion[4]['meal_one'] != null ? userMealPortion[4]['meal_one'].last.toDouble() : 0,
                    ((userMealPortion[4]['meal_one'] != emptyValue && userMealPortion[4]['meal_one'] != null ? userMealPortion[4]['meal_one'].last : 0) + (userMealPortion[4]['meal_two'] != emptyValue && userMealPortion[4]['meal_two'] != null ? userMealPortion[4]['meal_two'].last : 0)).toDouble(),
                    userMealPortion[4]['meal_two'] == emptyValue || userMealPortion[4]['meal_two'] == null ? ColorRefer.kBackgroundColor : userMealPortion[4]['meal_two'].first == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
                BarChartRodStackItem(
                    ((userMealPortion[4]['meal_one'] != emptyValue && userMealPortion[4]['meal_one'] != null ? userMealPortion[4]['meal_one'].last : 0) + (userMealPortion[4]['meal_two'] != emptyValue && userMealPortion[4]['meal_two'] != null ? userMealPortion[4]['meal_two'].last : 0)).toDouble(),
                    ((userMealPortion[4]['meal_one'] != emptyValue && userMealPortion[4]['meal_one'] != null ? userMealPortion[4]['meal_one'].last : 0) + (userMealPortion[4]['meal_two'] != emptyValue && userMealPortion[4]['meal_two'] != null ? userMealPortion[4]['meal_two'].last : 0) + (userMealPortion[4]['meal_three'] != emptyValue && userMealPortion[4]['meal_three'] != null ? userMealPortion[4]['meal_three'].last : 0)).toDouble(),
                    userMealPortion[4]['meal_three'] == emptyValue || userMealPortion[4]['meal_three'] == null ? ColorRefer.kBackgroundColor : userMealPortion[4]['meal_three'].first == false ? theme.brightness == Brightness.light ? Colors.white :
                    ColorRefer.kBackgroundColor : ColorRefer.kThirdBlueColor),
                BarChartRodStackItem(
                    ((userMealPortion[4]['meal_one'] != emptyValue && userMealPortion[4]['meal_one'] != null ? userMealPortion[4]['meal_one'].last : 0) + (userMealPortion[4]['meal_two'] != emptyValue && userMealPortion[4]['meal_two'] != null ? userMealPortion[4]['meal_two'].last : 0) + (userMealPortion[4]['meal_three'] != emptyValue && userMealPortion[4]['meal_three'] != null ? userMealPortion[4]['meal_three'].last : 0)).toDouble(),
                    ((userMealPortion[4]['meal_one'] != emptyValue && userMealPortion[4]['meal_one'] != null ? userMealPortion[4]['meal_one'].last : 0) + (userMealPortion[4]['meal_two'] != emptyValue && userMealPortion[4]['meal_two'] != null ? userMealPortion[4]['meal_two'].last : 0) + (userMealPortion[4]['meal_three'] != emptyValue && userMealPortion[4]['meal_three'] != null ? userMealPortion[4]['meal_three'].last : 0) + (userMealPortion[4]['meal_four'] != emptyValue && userMealPortion[4]['meal_four'] != null ? userMealPortion[4]['meal_four'].last : 0)).toDouble(),
                    userMealPortion[4]['meal_four'] == emptyValue || userMealPortion[4]['meal_four'] == null ? ColorRefer.kBackgroundColor : userMealPortion[4]['meal_four'].first == false ?
                    theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kForthBlueColor),
                BarChartRodStackItem(
                    ((userMealPortion[4]['meal_one'] != emptyValue && userMealPortion[4]['meal_one'] != null ? userMealPortion[4]['meal_one'].last : 0) + (userMealPortion[4]['meal_two'] != emptyValue && userMealPortion[4]['meal_two'] != null ? userMealPortion[4]['meal_two'].last : 0) + (userMealPortion[4]['meal_three'] != emptyValue && userMealPortion[4]['meal_three'] != null ? userMealPortion[4]['meal_three'].last : 0) + (userMealPortion[4]['meal_four'] != emptyValue && userMealPortion[4]['meal_four'] != null ? userMealPortion[4]['meal_four'].last : 0)).toDouble(),
                    ((userMealPortion[4]['meal_one'] != emptyValue && userMealPortion[4]['meal_one'] != null ? userMealPortion[4]['meal_one'].last : 0) + (userMealPortion[4]['meal_two'] != emptyValue && userMealPortion[4]['meal_two'] != null ? userMealPortion[4]['meal_two'].last : 0) + (userMealPortion[4]['meal_three'] != emptyValue && userMealPortion[4]['meal_three'] != null ? userMealPortion[4]['meal_three'].last : 0) + (userMealPortion[4]['meal_four'] != emptyValue && userMealPortion[4]['meal_four'] != null ? userMealPortion[4]['meal_four'].last : 0) + (userMealPortion[4]['meal_five'] != emptyValue && userMealPortion[4]['meal_five'] != null ? userMealPortion[4]['meal_five'].last : 0)).toDouble(),
                    userMealPortion[4]['meal_five'] == emptyValue || userMealPortion[4]['meal_five'] == null ? ColorRefer.kBackgroundColor : userMealPortion[4]['meal_five'].first == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFifthBlueColor),
                BarChartRodStackItem(
                    ((userMealPortion[4]['meal_one'] != emptyValue && userMealPortion[4]['meal_one'] != null ? userMealPortion[4]['meal_one'].last : 0) + (userMealPortion[4]['meal_two'] != emptyValue && userMealPortion[4]['meal_two'] != null ? userMealPortion[4]['meal_two'].last : 0) + (userMealPortion[4]['meal_three'] != emptyValue && userMealPortion[4]['meal_three'] != null ? userMealPortion[4]['meal_three'].last : 0) + (userMealPortion[4]['meal_four'] != emptyValue && userMealPortion[4]['meal_four'] != null ? userMealPortion[4]['meal_four'].last : 0) + (userMealPortion[4]['meal_five'] != emptyValue && userMealPortion[4]['meal_five'] != null ? userMealPortion[4]['meal_five'].last : 0)).toDouble(),
                    ((userMealPortion[4]['meal_one'] != emptyValue && userMealPortion[4]['meal_one'] != null ? userMealPortion[4]['meal_one'].last : 0) + (userMealPortion[4]['meal_two'] != emptyValue && userMealPortion[4]['meal_two'] != null ? userMealPortion[4]['meal_two'].last : 0) + (userMealPortion[4]['meal_three'] != emptyValue && userMealPortion[4]['meal_three'] != null ? userMealPortion[4]['meal_three'].last : 0) + (userMealPortion[4]['meal_four'] != emptyValue && userMealPortion[4]['meal_four'] != null ? userMealPortion[4]['meal_four'].last : 0) + (userMealPortion[4]['meal_five'] != emptyValue && userMealPortion[4]['meal_five'] != null ? userMealPortion[4]['meal_five'].last : 0) + (userMealPortion[4]['meal_six'] != emptyValue && userMealPortion[4]['meal_six'] != null ? userMealPortion[4]['meal_six'].last : 0)).toDouble(),
                    userMealPortion[4]['meal_six'] == emptyValue || userMealPortion[4]['meal_six'] == null ? ColorRefer.kBackgroundColor : userMealPortion[4]['meal_six'].first == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSixthBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 5,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: calories[5].toDouble(),
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(
                    0,
                    (userMealPortion[5]['meal_one'] != emptyValue && userMealPortion[5]['meal_one'] != null ? userMealPortion[5]['meal_one'].last.toDouble() : 0),
                    userMealPortion[5]['meal_one'] == emptyValue || userMealPortion[5]['meal_one'] == null ? ColorRefer.kBackgroundColor : userMealPortion[5]['meal_one'].first == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    (userMealPortion[5]['meal_one'] != emptyValue && userMealPortion[5]['meal_one'] != null ? userMealPortion[5]['meal_one'].last.toDouble() : 0),
                    ((userMealPortion[5]['meal_one'] != emptyValue && userMealPortion[5]['meal_one'] != null ? userMealPortion[5]['meal_one'].last : 0) + (userMealPortion[5]['meal_two'] != emptyValue && userMealPortion[5]['meal_two'] != null ? userMealPortion[5]['meal_two'].last : 0)).toDouble(),
                    userMealPortion[5]['meal_two'] == emptyValue || userMealPortion[5]['meal_two'] == null ? ColorRefer.kBackgroundColor : userMealPortion[5]['meal_two'].first == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
                BarChartRodStackItem(
                    ((userMealPortion[5]['meal_one'] != emptyValue && userMealPortion[5]['meal_one'] != null ? userMealPortion[5]['meal_one'].last : 0) + (userMealPortion[5]['meal_two'] != emptyValue && userMealPortion[5]['meal_two'] != null ? userMealPortion[5]['meal_two'].last : 0)).toDouble(),
                    ((userMealPortion[5]['meal_one'] != emptyValue && userMealPortion[5]['meal_one'] != null ? userMealPortion[5]['meal_one'].last : 0) + (userMealPortion[5]['meal_two'] != emptyValue && userMealPortion[5]['meal_two'] != null ? userMealPortion[5]['meal_two'].last : 0) + (userMealPortion[5]['meal_three'] != emptyValue && userMealPortion[5]['meal_three'] != null ? userMealPortion[5]['meal_three'].last : 0)).toDouble(),
                    userMealPortion[5]['meal_three'] == emptyValue || userMealPortion[5]['meal_three'] == null ? ColorRefer.kBackgroundColor : userMealPortion[5]['meal_three'].first == false ? theme.brightness == Brightness.light ? Colors.white :
                    ColorRefer.kBackgroundColor : ColorRefer.kThirdBlueColor),
                BarChartRodStackItem(
                    ((userMealPortion[5]['meal_one'] != emptyValue && userMealPortion[5]['meal_one'] != null ? userMealPortion[5]['meal_one'].last : 0) + (userMealPortion[5]['meal_two'] != emptyValue && userMealPortion[5]['meal_two'] != null ? userMealPortion[5]['meal_two'].last : 0) + (userMealPortion[5]['meal_three'] != emptyValue && userMealPortion[5]['meal_three'] != null ? userMealPortion[5]['meal_three'].last : 0)).toDouble(),
                    ((userMealPortion[5]['meal_one'] != emptyValue && userMealPortion[5]['meal_one'] != null ? userMealPortion[5]['meal_one'].last : 0) + (userMealPortion[5]['meal_two'] != emptyValue && userMealPortion[5]['meal_two'] != null ? userMealPortion[5]['meal_two'].last : 0) + (userMealPortion[5]['meal_three'] != emptyValue && userMealPortion[5]['meal_three'] != null ? userMealPortion[5]['meal_three'].last : 0) + (userMealPortion[5]['meal_four'] != emptyValue && userMealPortion[5]['meal_four'] != null &&  userMealPortion[5]['meal_four'] != null && userMealPortion[5]['meal_four'] != null && userMealPortion[5]['meal_four'] != null && userMealPortion[5]['meal_four'] != null && userMealPortion[5]['meal_four'] != null && userMealPortion[5]['meal_four'] != null ? userMealPortion[5]['meal_four'].last : 0)).toDouble(),
                    userMealPortion[5]['meal_four'] == emptyValue || userMealPortion[5]['meal_four'] == null ? ColorRefer.kBackgroundColor : userMealPortion[5]['meal_four'].first == false ?
                    theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kForthBlueColor),
                BarChartRodStackItem(
                    ((userMealPortion[5]['meal_one'] != emptyValue && userMealPortion[5]['meal_one'] != null ? userMealPortion[5]['meal_one'].last : 0) + (userMealPortion[5]['meal_two'] != emptyValue && userMealPortion[5]['meal_two'] != null ? userMealPortion[5]['meal_two'].last : 0) + (userMealPortion[5]['meal_three'] != emptyValue && userMealPortion[5]['meal_three'] != null ? userMealPortion[5]['meal_three'].last : 0) + (userMealPortion[5]['meal_four'] != emptyValue  && userMealPortion[5]['meal_four'] != null ? userMealPortion[5]['meal_four'].last : 0)).toDouble(),
                    ((userMealPortion[5]['meal_one'] != emptyValue && userMealPortion[5]['meal_one'] != null ? userMealPortion[5]['meal_one'].last : 0) + (userMealPortion[5]['meal_two'] != emptyValue && userMealPortion[5]['meal_two'] != null ? userMealPortion[5]['meal_two'].last : 0) + (userMealPortion[5]['meal_three'] != emptyValue && userMealPortion[5]['meal_three'] != null ? userMealPortion[5]['meal_three'].last : 0) + (userMealPortion[5]['meal_four'] != emptyValue  && userMealPortion[5]['meal_four'] != null ? userMealPortion[5]['meal_four'].last : 0) + (userMealPortion[5]['meal_five'] != emptyValue && userMealPortion[5]['meal_five'] != null ? userMealPortion[5]['meal_five'].last : 0)).toDouble(),
                    userMealPortion[5]['meal_five'] == emptyValue || userMealPortion[5]['meal_five'] == null ? ColorRefer.kBackgroundColor : userMealPortion[5]['meal_five'].first == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFifthBlueColor),
                BarChartRodStackItem(
                    ((userMealPortion[5]['meal_one'] != emptyValue && userMealPortion[5]['meal_one'] != null ? userMealPortion[5]['meal_one'].last : 0) + (userMealPortion[5]['meal_two'] != emptyValue && userMealPortion[5]['meal_two'] != null ? userMealPortion[5]['meal_two'].last : 0) + (userMealPortion[5]['meal_three'] != emptyValue && userMealPortion[5]['meal_three'] != null ? userMealPortion[5]['meal_three'].last : 0) + (userMealPortion[5]['meal_four'] != emptyValue  && userMealPortion[5]['meal_four'] != null ? userMealPortion[5]['meal_four'].last : 0) + (userMealPortion[5]['meal_five'] != emptyValue && userMealPortion[5]['meal_five'] != null ? userMealPortion[5]['meal_five'].last : 0)).toDouble(),
                    ((userMealPortion[5]['meal_one'] != emptyValue && userMealPortion[5]['meal_one'] != null ? userMealPortion[5]['meal_one'].last : 0) + (userMealPortion[5]['meal_two'] != emptyValue && userMealPortion[5]['meal_two'] != null ? userMealPortion[5]['meal_two'].last : 0) + (userMealPortion[5]['meal_three'] != emptyValue && userMealPortion[5]['meal_three'] != null ? userMealPortion[5]['meal_three'].last : 0) + (userMealPortion[5]['meal_four'] != emptyValue  && userMealPortion[5]['meal_four'] != null ? userMealPortion[5]['meal_four'].last : 0) + (userMealPortion[5]['meal_five'] != emptyValue && userMealPortion[5]['meal_five'] != null ? userMealPortion[5]['meal_five'].last : 0) + (userMealPortion[5]['meal_six'] != emptyValue && userMealPortion[5]['meal_six'] != null ? userMealPortion[5]['meal_six'].last : 0)).toDouble(),
                    userMealPortion[5]['meal_six'] == emptyValue ||  userMealPortion[5]['meal_six'] == null ? ColorRefer.kBackgroundColor : userMealPortion[5]['meal_six'].first == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSixthBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 6,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: calories[6].toDouble(),
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(
                    0,
                    userMealPortion[6]['meal_one'] != emptyValue && userMealPortion[6]['meal_one'] != null ? userMealPortion[6]['meal_one'].last.toDouble() : 0,
                    userMealPortion[6]['meal_one'] == emptyValue || userMealPortion[6]['meal_one'] == null ? ColorRefer.kBackgroundColor : userMealPortion[6]['meal_one'].first == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFirstBlueColor),
                BarChartRodStackItem(
                    userMealPortion[6]['meal_one'] != emptyValue && userMealPortion[6]['meal_one'] != null ? userMealPortion[6]['meal_one'].last.toDouble() : 0,
                    ((userMealPortion[6]['meal_one'] != emptyValue && userMealPortion[6]['meal_one'] != null ? userMealPortion[6]['meal_one'].last : 0) + (userMealPortion[6]['meal_two'] != emptyValue && userMealPortion[6]['meal_two'] != null ? userMealPortion[6]['meal_two'].last : 0)).toDouble(),
                    userMealPortion[6]['meal_two'] == emptyValue || userMealPortion[6]['meal_two'] == null ? ColorRefer.kBackgroundColor : userMealPortion[6]['meal_two'].first == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSecondBlueColor),
                BarChartRodStackItem(
                    ((userMealPortion[6]['meal_one'] != emptyValue && userMealPortion[6]['meal_one'] != null ? userMealPortion[6]['meal_one'].last : 0) + (userMealPortion[6]['meal_two'] != emptyValue && userMealPortion[6]['meal_two'] != null ? userMealPortion[6]['meal_two'].last : 0)).toDouble(),
                    ((userMealPortion[6]['meal_one'] != emptyValue && userMealPortion[6]['meal_one'] != null ? userMealPortion[6]['meal_one'].last : 0) + (userMealPortion[6]['meal_two'] != emptyValue && userMealPortion[6]['meal_two'] != null ? userMealPortion[6]['meal_two'].last : 0) + (userMealPortion[6]['meal_three'] != emptyValue && userMealPortion[6]['meal_three'] != null && userMealPortion[6]['meal_three'] != null ? userMealPortion[6]['meal_three'].last : 0)).toDouble(),
                    userMealPortion[6]['meal_three'] == emptyValue || userMealPortion[6]['meal_three'] == null && userMealPortion[0]['meal_one'] != null ? ColorRefer.kBackgroundColor : userMealPortion[6]['meal_three'].first == false ? theme.brightness == Brightness.light ? Colors.white :
                    ColorRefer.kBackgroundColor : ColorRefer.kThirdBlueColor),
                BarChartRodStackItem(
                    ((userMealPortion[6]['meal_one'] != emptyValue && userMealPortion[6]['meal_one'] != null ? userMealPortion[6]['meal_one'].last : 0) + (userMealPortion[6]['meal_two'] != emptyValue && userMealPortion[6]['meal_two'] != null ? userMealPortion[6]['meal_two'].last : 0 ) + (userMealPortion[6]['meal_three'] != emptyValue && userMealPortion[6]['meal_three'] != null ? userMealPortion[6]['meal_three'].last : 0)).toDouble(),
                    ((userMealPortion[6]['meal_one'] != emptyValue && userMealPortion[6]['meal_one'] != null ? userMealPortion[6]['meal_one'].last : 0) + (userMealPortion[6]['meal_two'] != emptyValue && userMealPortion[6]['meal_two'] != null ? userMealPortion[6]['meal_two'].last : 0) + (userMealPortion[6]['meal_three'] != emptyValue && userMealPortion[6]['meal_three'] != null ? userMealPortion[6]['meal_three'].last : 0) + (userMealPortion[6]['meal_four'] != emptyValue && userMealPortion[6]['meal_four'] != null ? userMealPortion[6]['meal_four'].last : 0)).toDouble(),
                    userMealPortion[6]['meal_four'] == emptyValue || userMealPortion[6]['meal_four'] == null ? ColorRefer.kBackgroundColor : userMealPortion[6]['meal_four'].first == false ?
                    theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kForthBlueColor),
                BarChartRodStackItem(
                    ((userMealPortion[6]['meal_one'] != emptyValue && userMealPortion[6]['meal_one'] != null ? userMealPortion[6]['meal_one'].last : 0) + (userMealPortion[6]['meal_two'] != emptyValue && userMealPortion[6]['meal_two'] != null ? userMealPortion[6]['meal_two'].last : 0) + (userMealPortion[6]['meal_three'] != emptyValue && userMealPortion[6]['meal_three'] != null ? userMealPortion[6]['meal_three'].last : 0) + (userMealPortion[6]['meal_four'] != emptyValue && userMealPortion[6]['meal_four'] != null ? userMealPortion[6]['meal_four'].last : 0)).toDouble(),
                    ((userMealPortion[6]['meal_one'] != emptyValue && userMealPortion[0]['meal_one'] != null ? userMealPortion[6]['meal_one'].last : 0) + (userMealPortion[6]['meal_two'] != emptyValue && userMealPortion[6]['meal_two'] != null ? userMealPortion[6]['meal_two'].last : 0) + (userMealPortion[6]['meal_three'] != emptyValue && userMealPortion[6]['meal_three'] != null ? userMealPortion[6]['meal_three'].last : 0) + (userMealPortion[6]['meal_four'] != emptyValue && userMealPortion[6]['meal_four'] != null ? userMealPortion[6]['meal_four'].last : 0) + (userMealPortion[6]['meal_five'] != emptyValue && userMealPortion[6]['meal_five'] != null ? userMealPortion[6]['meal_five'].last : 0)).toDouble(),
                    userMealPortion[6]['meal_five'] == emptyValue || userMealPortion[6]['meal_five'] == null ? ColorRefer.kBackgroundColor : userMealPortion[6]['meal_five'].first == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kFifthBlueColor),
                BarChartRodStackItem(
                    ((userMealPortion[6]['meal_one'] != emptyValue && userMealPortion[0]['meal_one'] != null ? userMealPortion[6]['meal_one'].last : 0) + (userMealPortion[6]['meal_two'] != emptyValue && userMealPortion[6]['meal_two'] != null ? userMealPortion[6]['meal_two'].last : 0) + (userMealPortion[6]['meal_three'] != emptyValue && userMealPortion[6]['meal_three'] != null ? userMealPortion[6]['meal_three'].last : 0) + (userMealPortion[6]['meal_four'] != emptyValue && userMealPortion[6]['meal_four'] != null ? userMealPortion[6]['meal_four'].last : 0) + (userMealPortion[6]['meal_five'] != emptyValue && userMealPortion[6]['meal_five'] != null ? userMealPortion[6]['meal_five'].last : 0)).toDouble(),
                    ((userMealPortion[6]['meal_one'] != emptyValue && userMealPortion[0]['meal_one'] != null ? userMealPortion[6]['meal_one'].last : 0) + (userMealPortion[6]['meal_two'] != emptyValue && userMealPortion[6]['meal_two'] != null ? userMealPortion[6]['meal_two'].last : 0) + (userMealPortion[6]['meal_three'] != emptyValue && userMealPortion[6]['meal_three'] != null ? userMealPortion[6]['meal_three'].last : 0) + (userMealPortion[6]['meal_four'] != emptyValue && userMealPortion[6]['meal_four'] != null ? userMealPortion[6]['meal_four'].last : 0) + (userMealPortion[6]['meal_five'] != emptyValue && userMealPortion[6]['meal_five'] != null ? userMealPortion[6]['meal_five'].last : 0) + (userMealPortion[6]['meal_six'] != emptyValue && userMealPortion[6]['meal_six'] != null ? userMealPortion[6]['meal_six'].last : 0)).toDouble(),
                    userMealPortion[6]['meal_six'] == emptyValue || userMealPortion[6]['meal_six'] == null ? ColorRefer.kBackgroundColor : userMealPortion[6]['meal_six'].first == false
                        ? theme.brightness == Brightness.light ? Colors.white : ColorRefer.kBackgroundColor
                        : ColorRefer.kSixthBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
    ];
  }

  static List<BarChartGroupData> showMonthlyMealData(List calories, List userCalories) {
    return [
      BarChartGroupData(
        x: 0,
        barsSpace: 10,
        barRods: [
          BarChartRodData(
              y: calories[0].toDouble(),
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(0, userCalories[0].toDouble(), userCalories[0] == 0 ? Colors.transparent : ColorRefer.kSecondBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: 10,
        barRods: [
          BarChartRodData(
              y: calories[1].toDouble(),
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(0, userCalories[1].toDouble(), userCalories[1] == 0 ? Colors.transparent : ColorRefer.kSecondBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barsSpace: 10,
        barRods: [
          BarChartRodData(
              y: calories[2].toDouble(),
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(0, userCalories[2].toDouble(), userCalories[2] == 0 ? Colors.transparent : ColorRefer.kSecondBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barsSpace: 10,
        barRods: [
          BarChartRodData(
              y: calories[3].toDouble(),
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(0, userCalories[3].toDouble(), userCalories[3] == 0 ? Colors.transparent : ColorRefer.kSecondBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))
          ),
        ],
      ),
    ];
  }

  static List<PieChartSectionData> mealPieChart(int caloriesTaken, int totalTaken, BuildContext context) {
    final ThemeData theme = Theme.of(context);
    double burn = ((caloriesTaken / totalTaken) * 100).floorToDouble();
    double value = 100;
    if (burn >= 100) {
      value = 0;
    } else {
      value = value - burn;
      if (value.isNegative) {
        value = 0;
      }
    }
    return List.generate(2, (i) {
      final radius = 15.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: theme.brightness ==  Brightness.light ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
            value: value,
            title: '',
            radius: radius,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.orange,
            value: burn >= 100 ? 50 : burn,
            title: '',
            radius: radius,
          );
        default:
          throw Error();
      }
    });
  }

  static List<BarChartGroupData> workoutBarChart(List weeklyBurnCalories, List workouts) {
    return [
      BarChartGroupData(
        x: 0,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: workouts.length >= 1 ? workouts[0] == true ? (weeklyBurnCalories[0]*1000000000.0) : 0 : 0,
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(
                  0,
                  (weeklyBurnCalories[0]*1000000000.0),
                  ColorRefer.kSecondBlueColor,
                ),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: workouts.length >= 2 ? workouts[1] == true ? (weeklyBurnCalories[1]*1000000000.0) : 0 : 0,
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(
                    0,
                    (weeklyBurnCalories[1]*1000000000.0),
                    ColorRefer.kSecondBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: workouts.length >= 3 ? workouts[2] == true ? (weeklyBurnCalories[2]*1000000000.0) : 0 : 0,
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(
                    0,
                    (weeklyBurnCalories[2]*1000000000.0),
                    ColorRefer.kSecondBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: workouts.length >= 4 ? workouts[3] == true ? (weeklyBurnCalories[3]*1000000000.0) : 0 : 0,
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(
                    0,
                    (weeklyBurnCalories[3]*1000000000.0),
                    ColorRefer.kSecondBlueColor
                ),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: workouts.length >= 5 ? workouts[4] == true ? (weeklyBurnCalories[4]*1000000000.0) : 0 : 0,
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(
                    0,
                    (weeklyBurnCalories[4]*1000000000.0),
                    ColorRefer.kSecondBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 5,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: workouts.length >= 6 ? workouts[5] == true ? (weeklyBurnCalories[5]*1000000000.0) : 0 : 0,
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(
                    0,
                    (weeklyBurnCalories[5]*1000000000.0),
                    ColorRefer.kSecondBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
      BarChartGroupData(
        x: 6,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: workouts.length >=  7 ? workouts[6] == true ? (weeklyBurnCalories[6]*1000000000.0) : 0 : 0,
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(
                    0,
                    (weeklyBurnCalories[6]*1000000000.0),
                    ColorRefer.kSecondBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))),
        ],
      ),
    ];
  }

  static List<BarChartGroupData> monthWorkoutBarChart(List weeklyBurnCalories, List workouts) {
    return [
      BarChartGroupData(
        x: 0,
        barsSpace: 10,
        barRods: [
          BarChartRodData(
              y: weeklyBurnCalories[0].toDouble(),
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(0, workouts[0].toDouble(), workouts[0] == 0 ? Colors.transparent : ColorRefer.kSecondBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: 10,
        barRods: [
          BarChartRodData(
              y: weeklyBurnCalories[1].toDouble(),
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(0, workouts[1].toDouble(), workouts[1] == 0 ? Colors.transparent : ColorRefer.kSecondBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barsSpace: 10,
        barRods: [
          BarChartRodData(
              y: weeklyBurnCalories[2].toDouble(),
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(0, workouts[2].toDouble(), workouts[2] == 0 ? Colors.transparent : ColorRefer.kSecondBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barsSpace: 10,
        barRods: [
          BarChartRodData(
              y: weeklyBurnCalories[3].toDouble(),
              colors: [Colors.transparent],
              rodStackItems: [
                BarChartRodStackItem(0, workouts[3].toDouble(), workouts[3] == 0 ? Colors.transparent : ColorRefer.kSecondBlueColor),
              ],
              width: 40,
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6))
          ),
        ],
      ),
    ];
  }

  static List<PieChartSectionData> workoutPieChart(int caloriesBurn, int totalBurn, BuildContext context) {
    final ThemeData theme = Theme.of(context);
    double burn = caloriesBurn == 0 ? 0 : ((caloriesBurn / totalBurn) * 100).floorToDouble();
    double value = 100;
    if (burn >= 100) {
      value = 0;
    } else {
      value = value - burn;
      if (value.isNegative) {
        value = 0;
      }
    }
    return List.generate(2, (i) {
      final radius = 15.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: theme.brightness ==  Brightness.light ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
            value: value,
            title: '',
            radius: radius,
          );
        case 1:
          return PieChartSectionData(
            color: ColorRefer.kRedColor,
            value: burn >= 100 ? 50 : burn,
            title: '',
            radius: radius,
          );
        default:
          throw Error();
      }
    });
  }

  static List<PieChartSectionData> mainPieChart({int caloriesTaken, int caloriesBurn, BuildContext context}) {
    final ThemeData theme = Theme.of(context);
    double take = caloriesTaken == 0 ? 0 : ((caloriesTaken / Constants.totalMealData) * 100).floorToDouble();
    double burn = caloriesBurn == 0 ? 0 : ((caloriesBurn / Constants.totalWorkoutData) * 100).floorToDouble();
    return List.generate(3, (i) {
      final radius = 15.0;
      switch (i) {
        case 0:
          return  PieChartSectionData(
            color: theme.brightness ==  Brightness.light ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
            value: 100,
            title: '',
            radius: radius,
          ) ;
        case 1:
          return PieChartSectionData(
            color: Colors.orange,
            value: take,
            title: '',
            radius: radius,
          );
        case 2:
          return  PieChartSectionData(
            color: ColorRefer.kRedColor,
            value: burn,
            title: '',
            radius: radius,
          );
        default:
          throw Error();
      }
    });
  }

}