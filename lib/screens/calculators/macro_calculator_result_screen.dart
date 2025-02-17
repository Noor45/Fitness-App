import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import '../../utils/strings.dart';
import '../../utils/style.dart';
import '../../widgets/custom_tabs.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class MacroCalculatorResultScreen extends StatefulWidget {
  static const String ID = "/macro_calculator_result_screen";
  @override
  _MacroCalculatorResultScreenState createState() => _MacroCalculatorResultScreenState();
}

class _MacroCalculatorResultScreenState extends State<MacroCalculatorResultScreen> {
  int willTabBarCurrentValue = 0;
  int willTabBarValue() => willTabBarCurrentValue;
  List<String> titles = [
    'Protein',
    'Carbs',
    'Fats',
    'Food Energy',
  ];
  void tabBarItemClicked(int index) {
    setState(() {
      willTabBarCurrentValue = index;
    });
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    List macroNutrients = ModalRoute.of(context).settings.arguments;
    List fatData = macroNutrients[1];
    List proteinData = macroNutrients[2];
    List carbsData = macroNutrients[3];
    double kj = (macroNutrients[0]*4.184);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:  theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
      appBar: AppBar(
        elevation: theme.lightTheme == true ? 3 : 0,
        iconTheme: IconThemeData(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
        systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
        centerTitle: true,
        title: Text(
          'Macro Calculator',
          style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 14),
        ),
      ),
      body: SafeArea(
          child: Container(
            width: width,
            height: height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: AutoSizeText(
                        StringRefer.kMacroCalculatorString,
                        style: StyleRefer.kTextStyle.copyWith(
                          fontSize: 14,
                          color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                          fontFamily: FontRefer.OpenSans,)
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: AutoSizeText(
                        'Balanced',
                        style: StyleRefer.kTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ColorRefer.kSecondBlueColor,
                        )
                    ),
                  ),
                  //************************** Tabs **************************
                  Container(
                    decoration: BoxDecoration(
                        color: theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                        border: Border(top: BorderSide(color: Colors.white24), left: BorderSide(color: Colors.white24), right: BorderSide(color: Colors.white24))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTabs(
                          title: 'Proteins',
                          selectionColor: willTabBarCurrentValue == 0 ? ColorRefer.kRedColor : Colors.white,
                          onSelect: (){
                            setState(() {
                              willTabBarCurrentValue = 0;
                            });
                          },
                          barColor: willTabBarCurrentValue == 0 ? ColorRefer.kRedColor : theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          fontSize: 12,
                          backColor: theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                        ),
                        Container(
                          color: Colors.white24,
                          height: 40,
                          width: 1,
                        ),
                        CustomTabs(
                          title: 'Carbs',
                          selectionColor: willTabBarCurrentValue == 1 ? ColorRefer.kRedColor : Colors.white,
                          onSelect: (){
                            setState(() {
                              willTabBarCurrentValue = 1;
                            });
                          },
                          barColor: willTabBarCurrentValue == 1 ? ColorRefer.kRedColor : theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          fontSize: 12,
                          backColor: theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                        ),
                        Container(
                          color: Colors.white24,
                          height: 40,
                          width: 1,
                        ),
                        CustomTabs(
                          title: 'Fats',
                          selectionColor: willTabBarCurrentValue == 2 ? ColorRefer.kRedColor : Colors.white,
                          onSelect: (){
                            setState(() {
                              willTabBarCurrentValue = 2;
                            });
                          },
                          barColor: willTabBarCurrentValue == 2 ? ColorRefer.kRedColor : theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          fontSize: 12,
                          backColor: theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                        ),
                        Container(
                          color: Colors.white24,
                          height: 40,
                          width: 1,
                        ),
                        CustomTabs(
                          title: 'Food Energy',
                          selectionColor: willTabBarCurrentValue == 3 ? ColorRefer.kRedColor : Colors.white,
                          onSelect: (){
                            setState(() {
                              willTabBarCurrentValue = 3;
                            });
                          },
                          barColor: willTabBarCurrentValue == 3 ? ColorRefer.kRedColor : theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          fontSize: 12,
                          backColor: theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  //************************** Protien Values **************************
                  Visibility(
                    visible: willTabBarCurrentValue == 0 ? true : false,
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                              'Proteins (${proteinData[2]})%',
                              style: StyleRefer.kTextStyle.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white,
                              )
                          ),
                          SizedBox(height: 10),
                          AutoSizeText(
                              '${proteinData[0]} grams/day',
                              style: StyleRefer.kTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                              )
                          ),
                          SizedBox(height: 5),
                          AutoSizeText(
                              'Calories: ${proteinData[1]} kcal',
                              style: StyleRefer.kTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                  //************************** Carbs Values **************************
                  Visibility(
                    visible: willTabBarCurrentValue == 1 ? true : false,
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                              'Carbs (${carbsData[2]})%',
                              style: StyleRefer.kTextStyle.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white,
                              )
                          ),
                          SizedBox(height: 10),
                          AutoSizeText(
                              '${carbsData[0]} grams/day',
                              style: StyleRefer.kTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                              )
                          ),
                          SizedBox(height: 5),
                          AutoSizeText(
                              'Calories: ${carbsData[1]} kcal',
                              style: StyleRefer.kTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                  //************************** Fats Values **************************
                  Visibility(
                    visible: willTabBarCurrentValue == 2 ? true : false,
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                              'Fats (${fatData[2]})%',
                              style: StyleRefer.kTextStyle.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white,
                              )
                          ),
                          SizedBox(height: 10),
                          AutoSizeText(
                              '${fatData[0]} grams/day',
                              style: StyleRefer.kTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                              )
                          ),
                          SizedBox(height: 5),
                          AutoSizeText(
                              'Calories: ${fatData[1]} kcal',
                              style: StyleRefer.kTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                  //************************** Food Energy value **************************
                  Visibility(
                    visible: willTabBarCurrentValue == 3 ? true : false,
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                              'Food Energy',
                              style: StyleRefer.kTextStyle.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white,
                              )
                          ),
                          SizedBox(height: 10),
                          AutoSizeText(
                              '${macroNutrients[0]} Calories/day',
                              style: StyleRefer.kTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                              )
                          ),
                          SizedBox(height: 5),
                          AutoSizeText(
                              '${kj.toInt()} kJ/day',
                              style: StyleRefer.kTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}


