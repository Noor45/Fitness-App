import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/style.dart';
import '../../utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class FatCalculatorResultScreen extends StatefulWidget {
  static const String ID = "/fat_calculator_result_screen";
  @override
  _FatCalculatorResultScreenState createState() => _FatCalculatorResultScreenState();
}

class _FatCalculatorResultScreenState extends State<FatCalculatorResultScreen> {
  double sliderValue = 0;
  List maleFatScaleRange = [0, 2, 5, 6, 13, 14, 17, 18, 25];
  List femaleFatScaleRange = [0, 10, 13, 14, 20, 21, 24, 25, 31];
  List scale = [];
  @override
  void initState() {
    if(AuthController.currentUser.gender == 'Female'){
      scale.addAll(femaleFatScaleRange);
    }else{
      scale.addAll(maleFatScaleRange);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    sliderValue = double.parse(ModalRoute.of(context).settings.arguments);
    if(sliderValue > 33){
      sliderValue = 33;
    }
    final theme = Provider.of<DarkThemeProvider>(context);
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
          'Body Fat Calculator',
          style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 14),
        )
      ),
      body: SafeArea(
          child: Container(
            width: width,
            height: height,
            padding: EdgeInsets.only(top: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: AutoSizeText(
                        'Results: $sliderValue%  (±3.5)',
                        style: StyleRefer.kTextStyle.copyWith(
                          fontSize: 16,
                          color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor
                        )
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: width,
                    child: SliderTheme(
                      data: StyleRefer.kSliderBar,
                      child: Slider(
                        min: 0.0,
                        max: 33.0,
                        value: sliderValue,
                        onChanged: (value){},
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 45, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                            'Chart',
                            style: StyleRefer.kTextStyle.copyWith(
                                fontSize: 16,
                                color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor
                            )
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ColorTextBox(
                              text:'Extremly Low',
                              color: Color(0xff8A0101),
                            ),
                            SizedBox(width: 25),
                            AutoSizeText(
                                '${scale[0]} - ${scale[1]} %',
                                style: StyleRefer.kTextStyle.copyWith(
                                    fontSize: 13,
                                    color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor
                                )
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ColorTextBox(
                              text:'Essential Fat',
                              color: Color(0xffFFE400),
                            ),
                            SizedBox(width: 25),
                            AutoSizeText(
                                '${scale[1]} - ${scale[2]} %',
                                style: StyleRefer.kTextStyle.copyWith(
                                    fontSize: 13,
                                    color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor
                                )
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ColorTextBox(
                              text:'Atheletes',
                              color: Color(0xff00FF6D),
                            ),
                            SizedBox(width: 25),
                            AutoSizeText(
                                '${scale[3]} - ${scale[4]} %',
                                style: StyleRefer.kTextStyle.copyWith(
                                    fontSize: 13,
                                    color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor
                                )
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ColorTextBox(
                              text:'Fitness',
                              color: Color(0xff008137),
                            ),
                            SizedBox(width: 25),
                            AutoSizeText(
                                '${scale[5]} - ${scale[6]} %',
                                style: StyleRefer.kTextStyle.copyWith(
                                    fontSize: 13,
                                    color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor
                                )
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ColorTextBox(
                              text:'Average',
                              color: Color(0xffFFE400),
                            ),
                            SizedBox(width: 25),
                            AutoSizeText(
                                '${scale[7]} - ${scale[8]} %',
                                style: StyleRefer.kTextStyle.copyWith(
                                    fontSize: 13,
                                    color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor
                                )
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ColorTextBox(
                              text:'Obese',
                              color: Color(0xff8A0101),
                            ),
                            SizedBox(width: 25),
                            AutoSizeText(
                                '${AuthController.currentUser.gender == 'Female'? scale[8]+1 : scale[8]} % +',
                                style: StyleRefer.kTextStyle.copyWith(
                                    fontSize: 13,
                                    color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor
                                )
                            ),
                          ],
                        ),
                      ],
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



class ColorTextBox extends StatelessWidget {
  ColorTextBox({this.text, this.color});
  final Color color;
  final String text;
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Row(
      children: [
        Container(
          height: 13,
          width: 13,
          color: color,
        ),
        SizedBox(width: 10),
        AutoSizeText(
            text,
            style: StyleRefer.kTextStyle.copyWith(
                fontSize: 13,
                color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor
            )
        )
      ],
    );
  }
}
