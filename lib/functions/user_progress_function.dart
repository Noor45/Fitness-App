
import 'package:t_fit/utils/constants.dart';

class UserProgressFunction{
  static getDayProgress(){
    Constants.dayProgressValue = 0;
    //for meal only
    if((Constants.planDetail.meal == 1 && Constants.planDetail.workout == 0) == true){
      List takeMeal = [];
      Constants.userMealData.forEach((element) {
        if(element.week == Constants.userMealPlanData.currentWeek && element.day == Constants.userMealPlanData.currentDay)
          element.mealData.forEach((element) {
            takeMeal.add(element);
          });
      });
      if(Constants.todayMealDetail.mealsInEachDay == 1){
        if(takeMeal[0]['mark'] == true) Constants.dayProgressValue = 0;
      }
      if(Constants.todayMealDetail.mealsInEachDay == 2){
        if(takeMeal[0]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 50.0;
        if(takeMeal[1]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 50.0;
      }
      if(Constants.todayMealDetail.mealsInEachDay == 3){
        if(takeMeal[0]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 33.0;
        if(takeMeal[1]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 33.0;
        if(takeMeal[2]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 34.0;
      }
      if(Constants.todayMealDetail.mealsInEachDay == 4){
        if(takeMeal[0]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 25.0;
        if(takeMeal[1]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 25.0;
        if(takeMeal[2]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 25.0;
        if(takeMeal[3]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 25.0;
      }
      if(Constants.todayMealDetail.mealsInEachDay == 5){
        if(takeMeal[0]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 20.0;
        if(takeMeal[1]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 20.0;
        if(takeMeal[2]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 20.0;
        if(takeMeal[3]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 20.0;
        if(takeMeal[4]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 20.0;
      }
      if(Constants.todayMealDetail.mealsInEachDay == 6){
        if(takeMeal[0]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 16.6;
        if(takeMeal[1]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 16.6;
        if(takeMeal[2]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 16.6;
        if(takeMeal[3]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 16.6;
        if(takeMeal[4]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 16.6;
        if(takeMeal[5]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 17;
      }
    }
    //for workout only
    if((Constants.planDetail.meal == 0 && Constants.planDetail.workout == 1) == true){
      bool restDay = false;
      Constants.userWorkoutsList.forEach((element) {
        if(element.week == Constants.userWorkoutPlanData.currentWeek && element.day == Constants.userWorkoutPlanData.currentDay)
          if(element.caloriesBurn == 0 && element.workouts == []) restDay = true;
      });
      Constants.userWorkoutData.forEach((element) {
        if(element.week == Constants.userWorkoutPlanData.currentWeek && element.day == Constants.userWorkoutPlanData.currentDay)
          if(element.workout == true) {
            if(restDay == true){
              Constants.dayProgressValue = 100;
            }else{
              Constants.dayProgressValue = 0.0;
            }
          }
      });
    }
    //for workout and meal both
    if((Constants.planDetail.meal == 1 && Constants.planDetail.workout == 1) == true){
      // if both plans end
      if(DateTime.now().isAfter(Constants.mealPlanDetail.endDate.toDate().add(Duration(days: 1))) && DateTime.now().isAfter(Constants.workoutPlanDetail.endDate.toDate().add(Duration(days: 1)))){
        Constants.dayProgressValue = Constants.dayProgressValue + 100;
      }
      // if workout plan end but meal plan is in progress
      else if(DateTime.now().isAfter(Constants.workoutPlanDetail.endDate.toDate().add(Duration(days: 1))) && !DateTime.now().isAfter(Constants.mealPlanDetail.endDate.toDate().add(Duration(days: 1))) == false){
        Constants.dayProgressValue = Constants.dayProgressValue + 0;
        List takeMeal = [];
        Constants.userMealData.forEach((element) {
          if(element.week == Constants.userMealPlanData.currentWeek && element.day == Constants.userMealPlanData.currentDay)
            element.mealData.forEach((element) {
              takeMeal.add(element);
            });
        });
        if(Constants.todayMealDetail.mealsInEachDay == 1){
          if(takeMeal[0]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 0;
        }
        if(Constants.todayMealDetail.mealsInEachDay == 2){
          if(takeMeal[0]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 50.0;
          if(takeMeal[1]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 50.0;
        }
        if(Constants.todayMealDetail.mealsInEachDay == 3){
          if(takeMeal[0]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 33.0;
          if(takeMeal[1]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 33.0;
          if(takeMeal[2]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 34.0;
        }
        if(Constants.todayMealDetail.mealsInEachDay == 4){
          if(takeMeal[0]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 25.0;
          if(takeMeal[1]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 25.0;
          if(takeMeal[2]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 25.0;
          if(takeMeal[3]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 25.0;
        }
        if(Constants.todayMealDetail.mealsInEachDay == 5){
          if(takeMeal[0]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 20.0;
          if(takeMeal[1]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 20.0;
          if(takeMeal[2]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 20.0;
          if(takeMeal[3]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 20.0;
          if(takeMeal[4]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 20.0;
        }
        if(Constants.todayMealDetail.mealsInEachDay == 6){
          if(takeMeal[0]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 16.6;
          if(takeMeal[1]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 16.6;
          if(takeMeal[2]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 16.6;
          if(takeMeal[3]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 16.6;
          if(takeMeal[4]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 16.6;
          if(takeMeal[5]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 17;
        }
      }
      // if meal plan end but workout plan is in progress
      else if(DateTime.now().isAfter(Constants.mealPlanDetail.endDate.toDate().add(Duration(days: 1))) && DateTime.now().isAfter(Constants.workoutPlanDetail.endDate.toDate().add(Duration(days: 1))) == false){
        Constants.dayProgressValue = Constants.dayProgressValue + 0;
        Constants.userWorkoutsList.forEach((element) {
          if(element.week == Constants.userWorkoutPlanData.currentWeek && element.day == Constants.userWorkoutPlanData.currentDay)
            if(element.caloriesBurn == 0 && element.workouts == []) Constants.dayProgressValue = 0.0;
        });
        Constants.userWorkoutData.forEach((element) {
          if(element.week == Constants.userWorkoutPlanData.currentWeek && element.day == Constants.userWorkoutPlanData.currentDay)
            if(element.workout == true) {
              Constants.dayProgressValue = 0.0;
            }
        });
      }
      // if both plan is in progress
      else{
        Constants.dayProgressValue = Constants.dayProgressValue + 0;
        bool restDay = false;
        Constants.userWorkoutsList.forEach((element) {
          if(element.week == Constants.userWorkoutPlanData.currentWeek && element.day == Constants.userWorkoutPlanData.currentDay){
            if(element.caloriesBurn == 0 && element.workouts.isEmpty){
              restDay = true;
              Constants.dayProgressValue = 100.0;
            }
          }
        });
        Constants.userWorkoutData.forEach((element) {
          if(element.week == Constants.userWorkoutPlanData.currentWeek && element.day == Constants.userWorkoutPlanData.currentDay)
            if(element.workout == true) {
              Constants.dayProgressValue = Constants.dayProgressValue + 50;
            }
        });
        List takeMeal = [];
        Constants.userMealData.forEach((element) {
          if(element.week == Constants.userMealPlanData.currentWeek && element.day == Constants.userMealPlanData.currentDay)
            element.mealData.forEach((element) {
              takeMeal.add(element);
            });
        });
        if(Constants.todayMealDetail.mealsInEachDay == 1){
          if(restDay == true){
            if(takeMeal[0]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 0;
          }else{
            if(takeMeal[0]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 50;
          }
        }
        if(Constants.todayMealDetail.mealsInEachDay == 2){
          if(restDay == true){
            if(takeMeal[0]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 50.0;
            if(takeMeal[1]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 50.0;
          }else{
            if(takeMeal[0]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 25.0;
            if(takeMeal[1]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 25.0;
          }
        }
        if(Constants.todayMealDetail.mealsInEachDay == 3){
          if(restDay == true){
            if(takeMeal[0]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 33.0;
            if(takeMeal[1]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 33.0;
            if(takeMeal[2]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 34.0;
          }else{
            if(takeMeal[0]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 16.5;
            if(takeMeal[1]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 16.5;
            if(takeMeal[2]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 17;
          }
        }
        if(Constants.todayMealDetail.mealsInEachDay == 4){
          if(restDay == true){
            if(takeMeal[0]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 25.0;
            if(takeMeal[1]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 25.0;
            if(takeMeal[2]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 25.0;
            if(takeMeal[3]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 25.0;
          }else{
            if(takeMeal[0]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 12.5;
            if(takeMeal[1]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 12.5;
            if(takeMeal[2]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 12.5;
            if(takeMeal[3]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 12.5;
          }
        }
        if(Constants.todayMealDetail.mealsInEachDay == 5){
          if(restDay == true){
            if(takeMeal[0]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 20.0;
            if(takeMeal[1]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 20.0;
            if(takeMeal[2]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 20.0;
            if(takeMeal[3]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 20.0;
            if(takeMeal[4]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 20.0;
          }else{
            if(takeMeal[0]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 10.0;
            if(takeMeal[1]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 10.0;
            if(takeMeal[2]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 10.0;
            if(takeMeal[3]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 10.0;
            if(takeMeal[4]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 10.0;
          }
        }
        if(Constants.todayMealDetail.mealsInEachDay == 6){
          if(restDay == true){
            if(takeMeal[0]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 16.6;
            if(takeMeal[1]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 16.6;
            if(takeMeal[2]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 16.6;
            if(takeMeal[3]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 16.6;
            if(takeMeal[4]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 16.6;
            if(takeMeal[5]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 17;
          }else{
            if(takeMeal[0]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 8.3;
            if(takeMeal[1]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 8.3;
            if(takeMeal[2]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 8.3;
            if(takeMeal[3]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 8.3;
            if(takeMeal[4]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 8.3;
            if(takeMeal[5]['mark'] == true) Constants.dayProgressValue = Constants.dayProgressValue + 8.3;
          }
        }
      }
    }
  }
}