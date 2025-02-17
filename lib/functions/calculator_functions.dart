import 'package:eval_ex/built_ins.dart';

  //************************** Function to convert kg into pounds **************************
  double kgToLbs({double weight}){
    return (weight * 2.20462);
  }
  //************************** Function to convert pounds into kg **************************
  double lbsToKg({double weight}){
    return (weight * 0.453592);
  }
  //************************** Function to calculate BMI **************************
  dynamic calculateBMI({double weight, double height, String weightUnit, String heightUnit}){
    //convert pounds into kg
    if(weightUnit == 'pound'){
      weight = weight * 0.453592;
      weight.round();
    }
    //convert feet into cm
    if(heightUnit == 'feet'){
      height = height * 30.48;
      height.round();
    }
    height = height/100;
    var heightSquare = height * height;
    double IBM = weight / heightSquare;
    return double.parse(IBM.toStringAsFixed(1));
  }
  //************************** Function to calculate REE value for macro calculator **************************
  dynamic calculateREE({double weight, double height, String weightUnit, String heightUnit, String gender, int age}){
    double ree = 0.0;
    //convert pounds into kg
    if(weightUnit == 'pound'){
      weight = weight * 0.453592;
      weight.round();
    }
    //convert feet into cm
    if(heightUnit == 'feet'){
      height = height * 30.48;
      height.round();
    }
    if(gender == 'Female'){
      ree = 10 * weight + 6.25 * height - 5 * age - 161;
    }
    if(gender == 'Male'){
      ree = ((10 * weight)  + (6.25 * height).ceil() - (5 * age)) + 5;
    }

    return ree.roundToDouble();
  }
  //************************** Function to calculate TDEE value for macro calculator **************************
  dynamic calculateTDEE({double ree, String activity}){
    double tdee = 0.0;
    if(activity == 'Sedentary'){
      tdee = ree * 1.2;
    }
    if(activity == 'Light'){
      tdee = ree * 1.375;
    }
    if(activity == 'Moderate'){
      tdee = ree * 1.55;
    }
    if(activity == 'Extreme'){
      tdee = ree * 1.725;
    }
    return tdee.roundToDouble();
  }
  //************************** Function to calculate MACRO Calories **************************
  calculateMACROCalories(double tdee, String goal){
    double calories = 0.0;
    if(goal == 'Lose Weight'){
      calories = tdee - (tdee * 0.20);
    }
    if(goal == 'Maintain Weight'){
      calories = tdee;
    }
    if(goal == 'Gain Weight'){
      calories = tdee + (tdee * 0.20);
    }
    return calories.roundToDouble();
  }
  //************************** Function Protein to calculate MACRO Calories **************************
  calculateProtein(double totalCalories, String goal, double weight, String weightUnit){
    if(weightUnit == 'kg'){
      weight = weight * 2.20462;
    }
    double proteinGrams = 0.0;
    double proteinCal = 0.0;
    double proteinPercentage = 0.0;

    if(goal == 'Lose Weight'){
      proteinGrams = weight * 0.65;
    }
    if(goal == 'Maintain Weight'){
      proteinGrams = weight * 0.82;
    }
    if(goal == 'Gain Weight'){
      proteinGrams = weight * 1;
    }

    proteinCal = proteinGrams.roundToDouble() * 4;
    proteinPercentage = (proteinCal / totalCalories) * 100;

    return [(proteinGrams.roundToDouble()).toInt(), proteinCal.toInt(), proteinPercentage.toInt()];
  }
  //************************** Function Fats to calculate MACRO Calories **************************
  calculateFat(double totalCalories){
    double fatCal = 0.0;
    double fatGram = 0.0;
    fatCal = (30/100) * totalCalories;
    fatGram = fatCal / 9;
    return [(fatGram).toInt(), fatCal.toInt(), 30.toInt()];
  }
  //************************** Function Carbs to calculate MACRO Calories **************************
  calculateCarbs(int protein, int fat, double totalCalories){
    int value = protein + fat;
    int carbsPercentage = 100 - value;
    double carbsCal = (carbsPercentage / 100) * totalCalories;
    double carbsGram = carbsCal / 4 ;
    return [(carbsGram).toInt(), carbsCal.toInt(), carbsPercentage.toInt()];
  }

  calculateBodyFatMale({double height, double neck, double waist, String heightUnit}){
    if(heightUnit == 'feet'){
      height = height * 30.48;
      height.round();
    }
    double cv = waist - neck;
    double value = 100 * (4.95 / (1.0324 - 0.19077 * log10(cv) + 0.15456 * log10(height)) - 4.5);
    return value;
  }

  calculateBodyFatFemale({double height, double neck, double waist, double hip, String heightUnit}){
    if(heightUnit == 'feet'){
      height = height * 30.48;
      height.round();
    }
    double cv = (waist + hip) - neck;
    double value = 100 * (4.95 / (1.29579 - 0.35004 * log10(cv) + 0.22100 * log10(height)) - 4.5);
    return value;
  }