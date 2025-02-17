import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t_fit/models/user_model/user_plan_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/style.dart';
import 'meal_history_screen.dart';
import 'workout_history_screen.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class UserPlanDetailScreen extends StatefulWidget {
  static const String ID = "/user_detail_screen";
  @override
  _UserPlanDetailScreenState createState() => _UserPlanDetailScreenState();
}

class _UserPlanDetailScreenState extends State<UserPlanDetailScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    List args = ModalRoute.of(context).settings.arguments;
    PlanModel planDetail = args[0];
    int type = args[1];
    return Scaffold(
        backgroundColor: theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
        appBar: AppBar(
          elevation: theme.lightTheme == true ? 3 : 0,
          iconTheme: IconThemeData(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
          systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
          centerTitle: true,
          title: Text(
            planDetail.planName,
            style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 15),
          ),
        ),
        body: type == 0 ? WorkoutHistory(planDetail: planDetail) : MealHistory(planDetail: planDetail)
    );
  }
}








