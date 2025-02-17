import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t_fit/cards/dashboard_cards.dart';
import 'package:t_fit/screens/history_screens/plans_list_screen.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/style.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class PlanHistoryScreen extends StatefulWidget {
  static const String ID = "/plan_history_screen";
  @override
  _PlanHistoryScreenState createState() => _PlanHistoryScreenState();
}

class _PlanHistoryScreenState extends State<PlanHistoryScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor: theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
      appBar: AppBar(
        elevation: theme.lightTheme == true ? 3 : 0,
        iconTheme: IconThemeData(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
        systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
        centerTitle: true,
        title: Text(
          'Plan History',
          style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 15),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Constants.planMealAssign == false && Constants.planWorkoutAssign == false && Constants.planSupplementAssign == false
              ?  EmptyDashboard(
              title: 'Hold Tight!',
              subTitle: 'Your customized meal and workout plan will be soon available.')
              : SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Visibility(
                    visible: Constants.planWorkoutAssign == false ? false : true,
                    child: PlanCard(
                      title: 'Workout Plan Data',
                      subtitle:  'User Data For Workout Plan',
                      image: 'assets/images/workout.png',
                      onPressed: () async{
                        Navigator.pushNamed(context, PlanListScreen.ID, arguments: 0);
                      },
                    ),
                  ),
                  Visibility(
                    visible: Constants.mealPlanDetail == null ? false : Constants.planMealAssign == false ? false : true,
                    child: PlanCard(
                      title: 'Meal Plan Data',
                      subtitle:  'User Data For Meal Plan',
                      image: 'assets/images/meal.png',
                      onPressed: () {
                        Navigator.pushNamed(context, PlanListScreen.ID, arguments: 2);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


