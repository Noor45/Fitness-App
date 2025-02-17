import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../cards/dashboard_cards.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/style.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';
import '../../../screens/diet_plan_screens/workout_plan/workout_month_plan_screen.dart';


class WorkoutPlanScreen extends StatefulWidget {
  @override
  _WorkoutPlanScreenState createState() => _WorkoutPlanScreenState();
}

class _WorkoutPlanScreenState extends State<WorkoutPlanScreen> {
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            'Workout Plans',
            style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
          ), systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: Container(
          child:  Constants.planWorkoutAssign == false ? EmptyDashboard() : SingleChildScrollView(
            child: Column(
              children: [
                PlanCard(
                  title: '28 Days Challenge',
                  subtitle: '4 Weeks Workout Plan',
                  image: 'assets/images/workout.png',
                  onPressed: (){
                    Navigator.pushNamed(context, WorkoutMonthPlanScreen.ID);
                  },
                ),
              ],
            ),
          ),
        ),
    );
  }
}

