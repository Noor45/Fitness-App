import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:t_fit/controllers/user_plan_controller.dart';
import 'package:t_fit/screens/main_screens/main_screen.dart';
import 'package:t_fit/utils/constants.dart';
import 'package:t_fit/utils/fonts.dart';
import 'package:t_fit/widgets/input_field.dart';
import 'package:toast/toast.dart';
import '../utils/colors.dart';
import '../utils/style.dart';
import '../widgets/round_button.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class PopupTimeBox extends StatefulWidget {
  PopupTimeBox({this.time, this.meal});
  final String time;
  final String meal;
  @override
  _PopupTimeBoxState createState() => _PopupTimeBoxState();
}

class _PopupTimeBoxState extends State<PopupTimeBox> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.only(left: 20, right: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height/2.3,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
                padding: EdgeInsets.only(top:10, right:10, bottom: 15),
                alignment: Alignment.centerRight,
                child: Icon(CupertinoIcons.clear_thick_circled, color: Colors.grey.withOpacity(0.4), size: 27,)),
          ),

          Flexible(
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: RichText(
                softWrap: true,
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'Be Patience!  ',
                        style:  TextStyle(fontSize: 17, color: ColorRefer.kPinkColor, fontWeight: FontWeight.bold, fontFamily: FontRefer.SansSerif, height: 1.5)
                    ),
                    TextSpan(
                        text: 'Your ${widget.meal} time is ',
                        style:  TextStyle(fontSize: 16, color: ColorRefer.kPinkColor, fontFamily: FontRefer.SansSerif, height: 1.5)
                    ),
                  ],
                ),
              ),
            ),
          ),
          Text(
           '${widget.time}',
            style: TextStyle(
                color: ColorRefer.kRedColor,
                fontSize: 15,
                fontWeight: FontWeight.w900,
                fontFamily: FontRefer.SansSerif, height: 1.5
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 15),
              child: Image.asset('assets/images/artwork_3.png')
          ),
        ],
      ),
    );
  }
}


class ConfirmBox extends StatefulWidget {
  ConfirmBox({this.title, this.firstButtonOnPressed, this.firstButtonColor,
    this.secondButtonOnPressed, this.subTitle, this.firstButtonTitle,
    this.secondButtonTitle, this.secondButtonColor, this.calories = 0, this.type = 0, this.complete = false});
  final String title;
  final String subTitle;
  final int calories;
  final bool complete;
  final String firstButtonTitle;
  final Color firstButtonColor;
  final Function firstButtonOnPressed;
  final String secondButtonTitle;
  final Color secondButtonColor;
  final Function secondButtonOnPressed;
  final int type;
  @override
  _ConfirmBoxState createState() => _ConfirmBoxState();
}

class _ConfirmBoxState extends State<ConfirmBox> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.only(left: 20, right: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
          ]),
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 25),
              Visibility(
                visible: widget.complete,
                child: Container(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text('You burn ${widget.calories} cal', textAlign: TextAlign.center, style: StyleRefer.kTextStyle.copyWith(color: ColorRefer.kSecondBlueColor, fontSize: 14.0, fontWeight: FontWeight.bold))
                ),
              ),
              Text(widget.title, textAlign: TextAlign.center, style: StyleRefer.kTextStyle.copyWith(color: ColorRefer.kPinkColor, fontSize: 14.0, fontWeight: FontWeight.w400)),
              SizedBox(height: 2),
              Text(widget.subTitle, style: StyleRefer.kTextStyle.copyWith(color: ColorRefer.kPinkColor, fontSize: 13.0, fontWeight: FontWeight.bold)),
              Container(
                  padding: EdgeInsets.only(top: 25, bottom: 30),
                  child: Image.asset('assets/images/artwork_3.png')
              ),
              RoundedButton(
                  title: widget.firstButtonTitle,
                  buttonRadius: 5,
                  colour: widget.firstButtonColor,
                  height: 48,
                  onPressed: widget.firstButtonOnPressed,
              ),
              Visibility(
                visible: widget.type == 1 ? false : true,
                child: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: RoundedButton(
                      title: widget.secondButtonTitle,
                      buttonRadius: 5,
                      colour: widget.secondButtonColor,
                      height: 48,
                      onPressed: widget.secondButtonOnPressed,
                  ),
                ),
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressDialogBox extends StatefulWidget {

  @override
  _ProgressDialogBoxState createState() => _ProgressDialogBoxState();
}

class _ProgressDialogBoxState extends State<ProgressDialogBox> with TickerProviderStateMixin {
  AnimationController animationController;
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.only(left: 20, right: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
          ]
      ),
      child: Container(
        margin: EdgeInsets.only(left: 20, bottom: 15, top: 15, right: 30),
        child: Row(
          children: [
            SpinKitDualRing(
              color: Colors.blue,
              controller: animationController,
            ),
            SizedBox(width: 30),
            Text(
              'Uploading File...',
              style: TextStyle(
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}



class CaloriesBox extends StatefulWidget {
  CaloriesBox({ this.index, this.calories, this.meal});
  final int index;
  final int calories;
  final int meal;
  @override
  _CaloriesBoxState createState() => _CaloriesBoxState();
}

class _CaloriesBoxState extends State<CaloriesBox> {
  final formKey = GlobalKey<FormState>();
  String protein = '0';
  String carbs =  '0';
  String fats = '0';
  String alcohol = '0';

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.only(left: 20, right: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
          ]),
      child: Container(
        padding: EdgeInsets.only(left: 12, right: 12, top: 15),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('Tell us how you divided your meal',
                    textAlign: TextAlign.center,
                    style: StyleRefer.kTextStyle.copyWith(color: ColorRefer.kPinkColor, fontSize: 14.0, fontWeight: FontWeight.w400)
                ),
                SizedBox(height: 2),
                Text('Enter the details below',
                    style: StyleRefer.kTextStyle.copyWith(color: ColorRefer.kPinkColor, fontSize: 13.0, fontWeight: FontWeight.w900)
                ),
                SizedBox(height: 20),
                RoundInputField(
                  textInputType: TextInputType.number,
                  label: 'Total Proteins intake (in gm.)',
                  onChanged: (value) {
                    protein = value;
                  },
                  validator: (String value) {
                    if (value.isEmpty) return "Enter proteins intake (in gm.)";
                  },
                ),
                SizedBox(height: 10),
                RoundInputField(
                  textInputType: TextInputType.number,
                  label: 'Total Fats intake (in gm.)',
                  onChanged: (value) {
                    fats = value;
                  },
                  validator: (String value) {
                    if (value.isEmpty) return "Enter fats intake (in gm.)";
                  },
                ),
                SizedBox(height: 10),
                RoundInputField(
                  textInputType: TextInputType.number,
                  label: 'Total Carbs intake (in gm.)',
                  onChanged: (value) {
                    carbs = value;
                  },
                  validator: (String value) {
                    if (value.isEmpty) return "Enter carbs intake (in gm.)";
                  },
                ),
                SizedBox(height: 10),
                RoundInputField(
                  textInputType: TextInputType.number,
                  label: 'Alcohol Intake',
                  onChanged: (value) {
                    alcohol = value;
                  },

                ),
                SizedBox(height: 20),
                RoundedButton(
                  title: 'Submit',
                  buttonRadius: 12,
                  colour: ColorRefer.kSecondBlueColor,
                  height: 48,
                  onPressed: (){
                    if (!formKey.currentState.validate()) return;
                    formKey.currentState.save();
                    Constants.userMealData.forEach((element) {
                      if(element.day == Constants.userMealPlanData.currentDay && element.week == Constants.userMealPlanData.currentWeek){
                        if(element.mealData[widget.index]['mark'] == false){
                          element.mealData[widget.index] = {'mark': true, 'portion': {'protein': int.parse(protein), 'fats': int.parse(fats), 'carbs': int.parse(carbs), 'alcohol': int.parse(alcohol)}};
                          String addCalories = (int.parse(protein)*4+int.parse(carbs)*4+int.parse(fats)*9+int.parse(alcohol)*7).toString();
                          int calories = int.parse(addCalories);
                          if(calories > widget.calories) element.extraCalories = calories - widget.calories;
                          element.caloriesTaken = element.caloriesTaken + calories;
                        }else{
                          element.caloriesTaken = element.caloriesTaken - widget.calories;
                          element.mealData[widget.index] = {'mark': true, 'portion': {'protein': int.parse(protein), 'fats': int.parse(fats), 'carbs': int.parse(carbs), 'alcohol': int.parse(alcohol)}};
                          String addCalories = (int.parse(protein)*4+int.parse(carbs)*4+int.parse(fats)*9+int.parse(alcohol)*7).toString();
                          int calories = int.parse(addCalories);
                          if(calories > widget.calories) element.extraCalories = calories - widget.calories;
                          element.caloriesTaken = element.caloriesTaken + calories;
                        }
                        DietPlanController.saveMealData();
                        Navigator.pushNamedAndRemoveUntil(context, MainScreen.MainScreenId, (route) => false);
                        Toast.show("Meal Done", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      }
                    });
                  },
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TakenCaloriesBox extends StatefulWidget {
  TakenCaloriesBox({ this.carbs, this.alcohol, this.protein, this.fats});
  final int protein;
  final int carbs;
  final int fats;
  final int alcohol;
  @override
  _TakenCaloriesBoxState createState() => _TakenCaloriesBoxState();
}

class _TakenCaloriesBoxState extends State<TakenCaloriesBox> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Dialog(
      insetPadding: EdgeInsets.only(left: 20, right: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
          ]),
      child: Container(
        padding: EdgeInsets.only(left: 12, right: 12, top: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('Doing well!',
                  textAlign: TextAlign.center,
                  style: StyleRefer.kTextStyle.copyWith(color: ColorRefer.kPinkColor, fontSize: 14.0, fontWeight: FontWeight.w400)
              ),
              SizedBox(height: 2),
              Text('See what you\'ve added',
                  style: StyleRefer.kTextStyle.copyWith(color: ColorRefer.kPinkColor, fontSize: 13.0, fontWeight: FontWeight.w900)
              ),
              SizedBox(height: 20),
              _label(
                title: 'Total Proteins intake (in gm.)',
                grams: widget.protein == 0 ? '0' : widget.protein.toString(),
              ),
              SizedBox(height: 20),
              _label(
                title: 'Total Fats intake (in gm.)',
                grams: widget.fats == 0 ? '0' : widget.fats.toString(),
              ),
              SizedBox(height: 20),
              _label(
                title: 'Total Carbs intake (in gm.)',
                grams: widget.carbs == 0 ? '0' : widget.carbs.toString(),
              ),
              SizedBox(height: 20),
              _label(
                title: 'Alcohol Intake',
                grams: widget.alcohol == 0 ? '0' : widget.alcohol.toString(),
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label({String title, String grams}){
    final theme = Provider.of<DarkThemeProvider>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: ColorRefer.kDarkColor,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              border: Border(
                top: BorderSide(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, width: 1),
                left: BorderSide(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, width: 1),
                right: BorderSide(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, width: 1),
                bottom: BorderSide(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  grams,
                  style: TextStyle(
                    color: ColorRefer.kDarkColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  'gm',
                  style: TextStyle(
                    color: ColorRefer.kDarkColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
