import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../cards/dashboard_cards.dart';
import '../../screens/calculators/bmi_calculator_screen.dart';
import '../../screens/calculators/fat_calculator_screen.dart';
import '../../screens/calculators/macro_calculator_screen.dart';
import '../../utils/colors.dart';
import '../../utils/style.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class CalculatorMainScreen extends StatefulWidget {
  static const String ID = 'calculator_main_screen';
  @override
  _CalculatorMainScreenState createState() => _CalculatorMainScreenState();
}

class _CalculatorMainScreenState extends State<CalculatorMainScreen> {
  int index = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
        backgroundColor:  theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
        appBar: AppBar(
          elevation: theme.lightTheme == true ? 3 : 0,
          iconTheme: IconThemeData(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
          systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
          centerTitle: true,
          title: Text(
            'Calculators',
            style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 14),
          )
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  SizedBox(height: 5),
                  PlanCard(
                    title: 'BMI',
                    subtitle: 'Calculate your body mass index',
                    image: 'assets/images/bmi.png',
                    onPressed: () {
                      Navigator.pushNamed(context, BMICalculatorScreen.ID);
                    },
                  ),
                  PlanCard(
                    title: 'MACRO',
                    subtitle: 'Calculate macronutrients needs for you',
                    image: 'assets/images/macro.png',
                    onPressed: () {
                      Navigator.pushNamed(context, MacroCalculatorScreen.ID);
                    },
                  ),
                  PlanCard(
                    title: 'FAT',
                    subtitle: 'Calculate your body fat percentage',
                    image: 'assets/images/fat_body.png',
                    onPressed: () {
                      Navigator.pushNamed(context, FatCalculatorScreen.ID);
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
