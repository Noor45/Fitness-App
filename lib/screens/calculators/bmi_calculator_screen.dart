import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:t_fit/functions/calculator_functions.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/style.dart';
import '../../widgets/input_field.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';
import '../../widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class BMICalculatorScreen extends StatefulWidget {
  static const String ID = "/bmi_calculator_screen";
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  String gender;
  double _cm = 0.0;
  double _feet = 0.0;
  double _inches = 0.0;
  double _weight = 0.0;
  String heightMsg = '';
  bool showHeightMsg = false;
  String weightMsg = '';
  bool showWeightMsg = false;
  String heightValue = 'cm';
  TextEditingController cmController = TextEditingController();
  TextEditingController feetController = TextEditingController();
  TextEditingController inchesController = TextEditingController();
  List<String> heightList = [
    'cm',
    'feet'
  ];
  String weightValue = 'kg';
  List<String> weightList = [
    'kg',
    'pound'
  ];
  TextEditingController weightController = TextEditingController();

  valueType(int option){
    setState(() {
      if(option == 1) {
        heightValue = 'cm';
      }
      if(option == 2){
        heightValue = 'feet';
      }
    });
  }

  @override
  void initState() {
    //************************** initialize height and weight value **************************
      if(AuthController.currentUser.height != 0.0){
        heightValue = AuthController.currentUser.height['key'];
        if(heightValue == 'feet'){
          if(AuthController.currentUser.height != 0.0){
            _feet = AuthController.currentUser.height['value'];
            feetController.text = _feet.toString();
          }
          _inches = AuthController.currentUser.height['inches'];
          if(_inches != null) inchesController.text = _inches.toString();
        }
        if(heightValue == 'cm'){
          if(AuthController.currentUser.height != 0.0){
            _cm = AuthController.currentUser.height['value'];
            cmController.text = _cm.toString();
          }
          _inches = AuthController.currentUser.height['inches'];
          if(_inches != null) inchesController.text = _inches.toString();
        }
      }
      if(AuthController.currentUser.weight != 0.0){
        _weight = AuthController.currentUser.weight['value'];
        weightController.text = _weight.toString();
        weightValue = AuthController.currentUser.weight['key'];
      }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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
          'BMI Calculators',
          style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 14),
        ),
      ),
      body: SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
              width: width,
              height: height,
              padding: EdgeInsets.only(left: 15, right: 15, top: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      'BMI (Body Mass Index)',
                      style: TextStyle(
                        fontSize: 16,
                        color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                        fontFamily: FontRefer.OpenSans,)
                    ),
                    SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          'Your Weight',
                          style: TextStyle(
                              fontSize: 14,
                              color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : Colors.white,
                              fontFamily: FontRefer.OpenSans),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputDataField(
                              width: width/1.8,
                              label: 'Enter your weight',
                              controller: weightController,
                              maxLength: 5,
                              msg: weightMsg,
                              showMsg: showWeightMsg,
                              onChanged: (value){
                                clear();
                                setState(() {
                                  if(value != '')
                                    _weight = double.parse(value);
                                });
                              },
                              textInputType: TextInputType.numberWithOptions(decimal: true),
                            ),
                            SelectData(
                              width: width/3,
                              value: weightValue,
                              selectionList: weightList,
                              onChanged: (option){
                                setState(() {
                                  weightValue = option;
                                });
                              },
                            ),

                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          'Your Height',
                          style: TextStyle(
                            fontSize: 14,
                            color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : Colors.white,
                            fontFamily: FontRefer.OpenSans),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: InputDataField(
                                width: heightValue == 'cm' ? width/1.7: width/3.5,
                                label: heightValue == 'cm' ? 'Enter your height': 'Feet',
                                controller: heightValue == 'cm' ? cmController : feetController,
                                msg: heightMsg,
                                showMsg: showHeightMsg,
                                maxLength: heightValue == 'cm' ? 5 : 1,
                                onChanged: (v){
                                  setState(() {
                                    if(v != ''){
                                      if(heightValue == 'cm') _cm = double.parse(v);
                                      else _feet = double.parse(v);
                                    }
                                  });
                                  clear();
                                },
                                textInputType: TextInputType.numberWithOptions(decimal: true),
                              ),
                            ),
                            Visibility(
                              visible: heightValue == 'cm' ? false : true,
                              child: Expanded(
                                child: InputDataField(
                                  width: width/3.5,
                                  label: 'Inches',
                                  maxLength: 2,
                                  controller: inchesController,
                                  onChanged: (value){
                                    setState(() {
                                      if(value != '')
                                        _inches = double.parse(value);
                                    });
                                    clear();
                                  },
                                  textInputType: TextInputType.numberWithOptions(decimal: true),
                                ),
                              ),
                            ),
                            SelectData(
                              width: width/4,
                              value: heightValue,
                              selectionList: heightList,
                              onChanged: (option){
                                setState(() {
                                  heightValue = option;
                                  if(heightValue == 'cm')
                                    _inches = null;
                                  if(heightValue == 'feet')
                                    _inches = 0.0;
                                });
                                clear();
                              },
                            ),

                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    RoundedButton(
                        title: 'Compute BMI',
                        buttonRadius: 5,
                        colour: ColorRefer.kRedColor,
                        height: 45,
                        onPressed: () async {
                          bool validate = validations();
                          if(validate != false){
                            setState(() {
                              clear();
                              FocusScope.of(context).requestFocus(FocusNode());
                              if(heightValue == 'cm'){
                                AuthController.currentUser.height = {
                                  'value': double.parse(_cm.toStringAsFixed(1)),
                                  'inches' : null,
                                  'key': heightValue,
                                };
                              }
                              if(heightValue == 'feet'){
                                AuthController.currentUser.height = {
                                  'value': double.parse(_feet.toStringAsFixed(1)),
                                  'inches' : double.parse(_inches.toStringAsFixed(1)),
                                  'key': heightValue,
                                };
                              }
                              AuthController.currentUser.weight = {
                                'value': double.parse(_weight.toStringAsFixed(1)),
                                'key': weightValue,
                              };
                              //************************** calculate BMI **************************
                              AuthController.currentUser.bmi = calculateBMI(
                                weight: _weight,
                                weightUnit: weightValue,
                                height: heightValue == 'cm' ? double.parse(_cm.toStringAsFixed(1)) :
                                double.parse(_feet.toStringAsFixed(1)) + (double.parse(_inches.toStringAsFixed(1))*0.0833333),
                                heightUnit: heightValue,
                              );
                              AuthController().updateUserFields();
                            });
                          }
                        }
                    ),
                    SizedBox(height: 20),
                    AutoSizeText(
                      'Your BMI',
                      style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontWeight: FontWeight.w900),
                    ),
                    Container(
                      width: width,
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.fromLTRB(15, 30, 15, 30),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: AutoSizeText(
                        AuthController.currentUser.bmi.toString(),
                        style: TextStyle(
                            fontSize: 24,
                            color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                            fontWeight: FontWeight.w900,
                            fontFamily: FontRefer.OpenSans,)
                      ),
                    ),
                    SizedBox(height: 20),
                    //************************** Chart for BMI **************************
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                            'BMI Categories:',
                            style: TextStyle(
                              fontSize: 15,
                              color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontRefer.OpenSans,)
                        ),
                        SizedBox(height: 10),
                        AutoSizeText(
                            'Underweight = <18.5',
                            style: TextStyle(
                              fontSize: 13,
                              color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                              fontFamily: FontRefer.OpenSans,)
                        ),
                        SizedBox(height: 3),
                        AutoSizeText(
                            'Normal weight = 18.5–24.9',
                            style: TextStyle(
                              fontSize: 13,
                              color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                              fontFamily: FontRefer.OpenSans,)
                        ),
                        SizedBox(height: 3),
                        AutoSizeText(
                            'Overweight = 25–29.9',
                            style: TextStyle(
                              fontSize: 13,
                              color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                              fontFamily: FontRefer.OpenSans,)
                        ),
                        SizedBox(height: 3),
                        AutoSizeText(
                            'Obesity = BMI of 30 or greater',
                            style: TextStyle(
                              fontSize: 13,
                              color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                              fontFamily: FontRefer.OpenSans,)
                        ),


                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
//************************** Function for validation of height and weight values **************************
  validations(){
    if(heightValue == 'cm'){
      if(_cm < 145.0 || _cm > 230.0 ) {
        setState(() {
          showHeightMsg = true;
          heightMsg = "Height should be 145 to 230 cm";
        });
        return false;
      }
    }else{
      if(_feet < 4.0 || _feet > 8) {
        setState(() {
          showHeightMsg = true;
          heightMsg = "Height should be 4 to 8 foot";
        });
        return false;
      }
    }
    if(weightValue == 'kg'){
      if(_weight < 35.0 || _weight > 110.0) {
        setState(() {
          showWeightMsg = true;
          weightMsg = "Weight should be 35 to 110 kg";
        });
        return false;
      }
    }else{
      if(_weight < 77.0 || _weight > 243.0) {
        setState(() {
          showWeightMsg = true;
          weightMsg = "Weight should be 77 to 243 pounds";
        });
        return false;
      }
    }
  }
  clear(){
    setState(() {
      showWeightMsg = false;
      showHeightMsg = false;
    });
  }
}
