import '../database/local_storage_function.dart';
import '../shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';
import 'package:intl/intl.dart';

final dbHelper = DatabaseHelper.instance;

int calculateCalories({int carbs, int proteins, int fats, int alcohol = 0}){
  return ((carbs*4)+(proteins*4)+(fats*9)+(alcohol*7));
}
List mealDistribution(List mealData){
  int md = 0;
  Constants.userMealList.forEach((element) {
    if(element.week == Constants.userMealPlanData.currentWeek && element.day == Constants.userMealPlanData.currentDay){
      md = element.meals.length;
    }
  });
  List meal = [];
  if(md == 1){
    meal = [
      {
        'icon': 'assets/icons/dinner.svg',
        'title': 'Meal',
        'mark': mealData[0]['mark'],
        'portion': mealData[0]['portion'],
      },
    ];
  }
  if(md == 2){
    meal = [
      {
        'icon': 'assets/icons/lunch.svg',
        'title': 'Meal One',
        'mark': mealData[0]['mark'],
        'portion': mealData[0]['portion'],
      },
      {
        'icon': 'assets/icons/dinner.svg',
        'title': 'Meal Two',
        'mark': mealData[1]['mark'],
        'portion': mealData[1]['portion'],
      },
    ];
  }
  if(md == 3){
    meal = [
      {
        'icon': 'assets/icons/breakfast.svg',
        'title': 'Meal One',
        'mark': mealData[0]['mark'],
        'portion': mealData[0]['portion'],
      },
      {
        'icon': 'assets/icons/lunch.svg',
        'title': 'Meal Two',
        'mark': mealData[1]['mark'],
        'portion': mealData[1]['portion'],
      },
      {
        'icon': 'assets/icons/dinner.svg',
        'title': 'Meal Three',
        'mark': mealData[2]['mark'],
        'portion': mealData[2]['portion'],
      },
    ];
  }
  if(md == 4){
    meal = [
      {
        'icon': 'assets/icons/breakfast.svg',
        'title': 'Meal One',
        'mark': mealData[0]['mark'],
        'portion': mealData[0]['portion'],
      },
      {
        'icon': 'assets/icons/lunch.svg',
        'title': 'Meal Two',
        'mark': mealData[1]['mark'],
        'portion': mealData[1]['portion'],
      },
      {
        'icon': 'assets/icons/lunch.svg',
        'title': 'Meal Three',
        'mark': mealData[2]['mark'],
        'portion': mealData[2]['portion'],
      },
      {
        'icon': 'assets/icons/dinner.svg',
        'title': 'Meal Four',
        'mark': mealData[3]['mark'],
        'portion': mealData[3]['portion'],
      },
    ];
  }
  if(md == 5){
    meal = [
      {
        'icon': 'assets/icons/breakfast.svg',
        'title': 'Meal One',
        'mark': mealData[0]['mark'],
        'portion': mealData[0]['portion'],
      },
      {
        'icon': 'assets/icons/lunch.svg',
        'title': 'Meal Two',
        'mark': mealData[1]['mark'],
        'portion': mealData[1]['portion'],
      },
      {
        'icon': 'assets/icons/lunch.svg',
        'title': 'Meal Three',
        'mark': mealData[2]['mark'],
        'portion': mealData[2]['portion'],
      },
      {
        'icon': 'assets/icons/lunch.svg',
        'title': 'Meal Four',
        'mark': mealData[3]['mark'],
        'portion': mealData[3]['portion'],
      },
      {
        'icon': 'assets/icons/dinner.svg',
        'title': 'Meal Five',
        'mark': mealData[4]['mark'],
        'portion': mealData[4]['portion'],
      },
    ];
  }
  if(md == 6){
    meal = [
      {
        'icon': 'assets/icons/breakfast.svg',
        'title': 'Meal One',
        'mark': mealData[0]['mark'],
        'portion': mealData[0]['portion'],
      },
      {
        'icon': 'assets/icons/lunch.svg',
        'title': 'Meal Two',
        'mark': mealData[1]['mark'],
        'portion': mealData[1]['portion'],
      },
      {
        'icon': 'assets/icons/lunch.svg',
        'title': 'Meal Three',
        'mark': mealData[2]['mark'],
        'portion': mealData[2]['portion'],
      },
      {
        'icon': 'assets/icons/lunch.svg',
        'title': 'Meal Four',
        'mark': mealData[3]['mark'],
        'portion': mealData[3]['portion'],
      },
      {
        'icon': 'assets/icons/lunch.svg',
        'title': 'Meal Five',
        'mark': mealData[4]['mark'],
        'portion': mealData[4]['portion'],
      },
      {
        'icon': 'assets/icons/dinner.svg',
        'title': 'Meal Six',
        'mark': mealData[5]['mark'],
        'portion': mealData[5]['portion'],
      },
    ];
  }
  return meal;
}

mealProgressValue(bool mealDone, int md){
  if(mealDone == true){
    if(md == 1){
      Constants.mealProgressValue = Constants.mealProgressValue + 1;
      if(Constants.mealProgressValue > 1){
        Constants.mealProgressValue = 1.0;
      }
    }
    if(md == 2){
      Constants.mealProgressValue = Constants.mealProgressValue + 0.5;
      if(Constants.mealProgressValue > 1){
        Constants.mealProgressValue = 1.0;
      }
    }
    if(md == 3){
      Constants.mealProgressValue = Constants.mealProgressValue + 0.33;
      if(Constants.mealProgressValue > 1){
        Constants.mealProgressValue = 1.0;
      }
    }
    if(md == 4){
      Constants.mealProgressValue = Constants.mealProgressValue + 0.25;
      if(Constants.mealProgressValue > 1){
        Constants.mealProgressValue = 1.0;
      }
    }
    if(md == 5){
      Constants.mealProgressValue = Constants.mealProgressValue + 0.2;
      if(Constants.mealProgressValue > 1){
        Constants.mealProgressValue = 1.0;
      }
    }
    if(md == 6){
      Constants.mealProgressValue = Constants.mealProgressValue + 0.167;
      if(Constants.mealProgressValue > 1){
        Constants.mealProgressValue = 1.0;
      }
    }
  }
}

changeMeal(DateTime start, DateTime end) {
  var formatter = new DateFormat('dd MMMM yyyy');
  DateTime today = DateTime.now();
  var backDate = LocalPreferences.preferences.getString(LocalPreferences.mealTime);
  var todayDate = formatter.format(today);

  if(backDate.compareTo(todayDate) <= 0){

  }
}

getUserMealPlanDetail(int week){
  if(Constants.userMealPlanData != null){
    Constants.mealProgressValue = 0.0;
    Constants.totalMealData = 0;
    Constants.totalUserMealData = 0;
    if(Constants.planDetail.meal == 1){
      Constants.userMealList.forEach((element) {
        if(element.week == week){
          Constants.totalMealData = Constants.totalMealData + element.totalDayCalories;
        }
      });
      Constants.userMealData.forEach((element) {
        if(element.week == week){
          Constants.totalUserMealData = Constants.totalUserMealData + element.caloriesTaken;
        }
      });
    }
  }
}