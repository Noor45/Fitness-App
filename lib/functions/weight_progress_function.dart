

import 'package:flutter/material.dart';

class WeightProgress{

  static List weightProgressFunction(int goal, double currentWeight, double oldWeight){
    currentWeight = currentWeight == null ?  0.0 : currentWeight;
    oldWeight = oldWeight == null ?  0.0 : oldWeight;
    List result = [];
    if(goal == 1){
      double difference = currentWeight - oldWeight;
      if(currentWeight == 0.0) result = [difference.abs().toStringAsFixed(1), Colors.yellow, ''];
      else if(difference.isNegative) result = [difference.abs().toStringAsFixed(1), Colors.green, '-'];
      else if (difference == 0.0) result = [difference.abs().toStringAsFixed(1), Colors.yellow, ''];
      else result = [difference.abs().toStringAsFixed(1), Colors.red, '+'];
    }
    if(goal == 2){
      double difference = currentWeight - oldWeight;
      if(currentWeight == 0.0) result = [difference.abs().toStringAsFixed(1), Colors.yellow, ''];
      else if(difference.isNegative) result = [difference.abs().toStringAsFixed(1), Colors.red, '-'];
      else if (difference == 0.0) result = [difference.abs().toStringAsFixed(1), Colors.yellow, ''];
      else result = [difference.abs().toStringAsFixed(1), Colors.green, '+'];
    }
    if(goal == 3){
        double difference = currentWeight - oldWeight;
       if(currentWeight == 0.0) result = [difference.abs().toStringAsFixed(1), Colors.yellow, ''];
       else if(difference.isNegative) result = [difference.abs().toStringAsFixed(1), Colors.blue, '-'];
       else if (difference == 0.0) result = [difference.abs().toStringAsFixed(1), Colors.yellow, ''];
       else result = [difference.abs().toStringAsFixed(1), Colors.purple, '+'];
    }
    if(goal == 4){
      double difference = currentWeight - oldWeight;
      if(currentWeight == 0.0) result = [difference.abs().toStringAsFixed(1), Colors.yellow, ''];
      else if(difference.isNegative) result = [difference.abs().toStringAsFixed(1), Colors.red, '-'];
      else if (difference == 0) result = [difference.abs().toStringAsFixed(1), Colors.yellow, ''];
      else result = [difference.abs().toStringAsFixed(1), Colors.green, '+'];
    }
    if(goal == 5){
      double difference = currentWeight - oldWeight;
      if(currentWeight == 0.0) result = [difference.abs().toStringAsFixed(1), Colors.yellow, ''];
      else if(difference.isNegative) result = [difference.abs().toStringAsFixed(1), Colors.green, '-'];
      else if (difference == 0) result = [difference.abs().toStringAsFixed(1), Colors.yellow, ''];
      else result = [difference.abs().toStringAsFixed(1), Colors.red, '+'];
    }
    if(goal == 6){
      double difference = currentWeight - oldWeight;
      if(currentWeight == 0.0) result = [difference.abs().toStringAsFixed(1), Colors.yellow, ''];
      else if(difference.isNegative) result = [difference.abs().toStringAsFixed(1), Colors.green, '-'];
      else if (difference == 0) result = [difference.abs().toStringAsFixed(1), Colors.yellow, ''];
      else result = [difference.abs().toStringAsFixed(1), Colors.red, '+'];
    }
    if(goal == 7){
      double difference = currentWeight - oldWeight;
      if(currentWeight == 0.0) result = [difference.abs().toStringAsFixed(1), Colors.yellow, ''];
      else if(difference.isNegative) result = [difference.abs().toStringAsFixed(1), Colors.green, '-'];
      else if (difference == 0) result = [difference.abs().toStringAsFixed(1), Colors.yellow, ''];
      else result = [difference.abs().toStringAsFixed(1), Colors.red, '+'];
    }
    if(goal == 8){
      double difference = currentWeight - oldWeight;
      if(currentWeight == 0.0) result = [difference.abs().toStringAsFixed(1), Colors.yellow, ''];
      else if(difference.isNegative) result = [difference.abs().toStringAsFixed(1), Colors.blue, '-'];
      else if (difference == 0) result = [difference.abs().toStringAsFixed(1), Colors.yellow, ''];
      else result = [difference.abs().toStringAsFixed(1), Colors.purple, '+'];
    }
    if(goal == 9){
      double difference = currentWeight - oldWeight;
      if(currentWeight == 0.0) result = [difference.abs().toStringAsFixed(1), Colors.yellow, ''];
      else if(difference.isNegative) result = [difference.abs().toStringAsFixed(1), Colors.blue, '-'];
      else if (difference == 0) result = [difference.abs().toStringAsFixed(1), Colors.yellow, ''];
      else result = [difference.abs().toStringAsFixed(1), Colors.purple, '+'];
    }
    if(goal == 10){
      double difference = currentWeight - oldWeight;
      if(currentWeight == 0.0) result = [difference.abs().toStringAsFixed(1), Colors.yellow, ''];
      else if(difference.isNegative) result = [difference.abs().toStringAsFixed(1), Colors.blue, '-'];
      else if (difference == 0) result = [difference.abs().toStringAsFixed(1), Colors.yellow, ''];
      else result = [difference.abs().toStringAsFixed(1), Colors.purple, '+'];
    }
    if(goal == 11){
      double difference = currentWeight - oldWeight;
      if(currentWeight == 0.0) result = [difference.abs().toStringAsFixed(1), Colors.yellow, ''];
      else if(difference.isNegative) result = [difference.abs().toStringAsFixed(1), Colors.blue, '-'];
      else if (difference == 0) result = [difference.abs().toStringAsFixed(1), Colors.yellow, ''];
      else result = [difference.abs().toStringAsFixed(1), Colors.purple, '+'];
    }

    return result;
  }

  static List weightProgressForMonthFunction(int goal, double diff){
    List result = [];
    if(goal == 1){
      if(diff == 0.0) result = [diff.abs().toStringAsFixed(1), Colors.yellow, ''];
      else if(diff.isNegative) result = [diff.abs().toStringAsFixed(1), Colors.green, '-'];
      else if (diff == 0.0) result = [diff.abs().toStringAsFixed(1), Colors.yellow, ''];
      else result = [diff.abs().toStringAsFixed(1), Colors.red, '+'];
    }
    if(goal == 2){
      if(diff == 0.0) result = [diff.abs().toStringAsFixed(1), Colors.yellow, ''];
      else if(diff.isNegative) result = [diff.abs().toStringAsFixed(1), Colors.red, '-'];
      else if (diff == 0.0) result = [diff.abs().toStringAsFixed(1), Colors.yellow, ''];
      else result = [diff.abs().toStringAsFixed(1), Colors.green, '+'];
    }
    if(goal == 3){
      if(diff == 0.0) result = [diff.abs().toStringAsFixed(1), Colors.yellow, ''];
      else if(diff.isNegative) result = [diff.abs().toStringAsFixed(1), Colors.blue, '-'];
      else if (diff == 0.0) result = [diff.abs().toStringAsFixed(1), Colors.yellow, ''];
      else result = [diff.abs().toStringAsFixed(1), Colors.purple, '+'];
    }
    if(goal == 4){
      if(diff == 0.0) result = [diff.abs().toStringAsFixed(1), Colors.yellow, ''];
      else if(diff.isNegative) result = [diff.abs().toStringAsFixed(1), Colors.red, '-'];
      else if (diff == 0) result = [diff.abs().toStringAsFixed(1), Colors.yellow, ''];
      else result = [diff.abs().toStringAsFixed(1), Colors.green, '+'];
    }
    if(goal == 5){
      if(diff == 0.0) result = [diff.abs().toStringAsFixed(1), Colors.yellow, ''];
      else if(diff.isNegative) result = [diff.abs().toStringAsFixed(1), Colors.green, '-'];
      else if (diff == 0) result = [diff.abs().toStringAsFixed(1), Colors.yellow, ''];
      else result = [diff.abs().toStringAsFixed(1), Colors.red, '+'];
    }
    if(goal == 6){
      if(diff == 0.0) result = [diff.abs().toStringAsFixed(1), Colors.yellow, ''];
      else if(diff.isNegative) result = [diff.abs().toStringAsFixed(1), Colors.green, '-'];
      else if (diff == 0) result = [diff.abs().toStringAsFixed(1), Colors.yellow, ''];
      else result = [diff.abs().toStringAsFixed(1), Colors.red, '+'];
    }
    if(goal == 7){
      if(diff == 0.0) result = [diff.abs().toStringAsFixed(1), Colors.yellow, ''];
      else if(diff.isNegative) result = [diff.abs().toStringAsFixed(1), Colors.green, '-'];
      else if (diff == 0) result = [diff.abs().toStringAsFixed(1), Colors.yellow, ''];
      else result = [diff.abs().toStringAsFixed(1), Colors.red, '+'];
    }
    if(goal == 8){
      if(diff == 0.0) result = [diff.abs().toStringAsFixed(1), Colors.yellow, ''];
      else if(diff.isNegative) result = [diff.abs().toStringAsFixed(1), Colors.blue, '-'];
      else if (diff == 0) result = [diff.abs().toStringAsFixed(1), Colors.yellow, ''];
      else result = [diff.abs().toStringAsFixed(1), Colors.purple, '+'];
    }
    if(goal == 9){
      if(diff == 0.0) result = [diff.abs().toStringAsFixed(1), Colors.yellow, ''];
      else if(diff.isNegative) result = [diff.abs().toStringAsFixed(1), Colors.blue, '-'];
      else if (diff == 0) result = [diff.abs().toStringAsFixed(1), Colors.yellow, ''];
      else result = [diff.abs().toStringAsFixed(1), Colors.purple, '+'];
    }
    if(goal == 10){
      if(diff == 0.0) result = [diff.abs().toStringAsFixed(1), Colors.yellow, ''];
      else if(diff.isNegative) result = [diff.abs().toStringAsFixed(1), Colors.blue, '-'];
      else if (diff == 0) result = [diff.abs().toStringAsFixed(1), Colors.yellow, ''];
      else result = [diff.abs().toStringAsFixed(1), Colors.purple, '+'];
    }
    if(goal == 11){
      if(diff == 0.0) result = [diff.abs().toStringAsFixed(1), Colors.yellow, ''];
      else if(diff.isNegative) result = [diff.abs().toStringAsFixed(1), Colors.blue, '-'];
      else if (diff == 0) result = [diff.abs().toStringAsFixed(1), Colors.yellow, ''];
      else result = [diff.abs().toStringAsFixed(1), Colors.purple, '+'];
    }

    return result;
  }
}