import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:t_fit/functions/calculator_functions.dart';
import '../../cards/custom_cards.dart';
import '../../controllers/auth_controller.dart';
import '../../screens/calculators/fat_calculator_result_screen.dart';
import '../../utils/style.dart';
import '../../widgets/input_field.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';
import '../../widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class FatCalculatorScreen extends StatefulWidget {
  static const String ID = "/fat_calculator_screen";
  @override
  _FatCalculatorScreenState createState() => _FatCalculatorScreenState();
}

class _FatCalculatorScreenState extends State<FatCalculatorScreen> {
  int age = 0;
  double _cm = 0;
  double _feet = 0;
  double _inches = 0;
  double _neck = 0;
  double _waist = 0;
  double _hip = 0;
  double _weight = 0;
  String gender;
  bool male = false;
  bool female = false;
  String value = 'cm';
  String heightValue = 'cm';
  String weightValue = 'kg';
  String heightMsg = '';
  bool showHeightMsg = false;
  String weightMsg = '';
  bool showWeightMsg = false;
  String ageMsg = '';
  bool showAgeMsg = false;
  String neckMsg = '';
  bool showNeckMsg = false;
  String waistMsg = '';
  bool showWaistMsg = false;
  String hipsMsg = '';
  bool showHipsMsg = false;
  String goalValue = 'Lose Weight';
  String activityValue = 'Sedentary';
  List<String> heightList = ['cm', 'feet'];
  List<String> weightList = ['kg', 'pound'];
  List<String> goalList = ['Lose Weight', 'Maintain Weight', 'Gain Weight'];
  List<String> activityList = ['Sedentary', 'Light', 'Moderate', 'Extreme'];
  TextEditingController cmController = TextEditingController();
  TextEditingController feetController = TextEditingController();
  TextEditingController inchesController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController neckController = TextEditingController();
  TextEditingController waistController = TextEditingController();
  TextEditingController hipController = TextEditingController();

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
    //************************** initialize values **************************
    ageController.text = AuthController.currentUser.age.toString();
    age = AuthController.currentUser.age;
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
    if(AuthController.currentUser.waist != 0.0 && AuthController.currentUser.neck != null){
      _waist = AuthController.currentUser.waist;
      waistController.text = _waist.toString();
    }
    if(AuthController.currentUser.neck != 0.0 && AuthController.currentUser.neck != null){
      _neck = AuthController.currentUser.neck;
      neckController.text = _neck.toString();
    }
    if(AuthController.currentUser.hips != 0.0 && AuthController.currentUser.neck != null){
      _hip = AuthController.currentUser.hips;
      hipController.text = _hip.toString();
    }
    if(AuthController.currentUser.gender == 'Male')
      male = true;
    if(AuthController.currentUser.gender == 'Female')
      female = true;


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
          'Body Fat Calculator',
          style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 14),
        ),
      ),
      body: SafeArea(
          child: Container(
            width: width,
            height: height,
            padding: EdgeInsets.only(left: 15, right: 15, top: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                      'Calculate Body Fat',
                      style: TextStyle(
                        fontSize: 16,
                        color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                        fontFamily: FontRefer.OpenSans,)
                  ),
                  SizedBox(height: 15),
                  //************************** Age value Field **************************
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        'Age',
                        style: TextStyle(
                            fontSize: 14,
                            color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white,
                            fontFamily: FontRefer.OpenSans),
                      ),
                      SizedBox(height: 10),
                      InputDataField(
                        width: width,
                        controller: ageController,
                        msg: ageMsg,
                        showMsg: showAgeMsg,
                        maxLength: 2,
                        textInputType: TextInputType.number,
                        label: 'Enter your age',
                        onChanged: (value) {
                          clear();
                          setState(() {
                            if(value != '')
                              age = int.parse(value);
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  //************************** Gender **************************
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        'Gender',
                        style: TextStyle(
                            fontSize: 14,
                            color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white,
                            fontFamily: FontRefer.OpenSans),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GenderSelection(
                            text: 'Male',
                            select: male,
                            onPressed: (){
                              setState(() {
                                male = true;
                                female = false;
                                AuthController.currentUser.gender = 'Male';
                              });
                            },
                          ),
                          GenderSelection(
                            text: 'Female',
                            select: female,
                            onPressed: (){
                              setState(() {
                                female = true;
                                male = false;
                                AuthController.currentUser.gender = 'Female';
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  //************************** Weight value Field **************************
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        'Weight',
                        style: TextStyle(
                            fontSize: 14,
                            color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white,
                            fontFamily: FontRefer.OpenSans),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InputDataField(
                            maxLength: 4,
                            msg: weightMsg,
                            showMsg: showWeightMsg,
                            width: width/1.8,
                            label: 'Enter your weight',
                            controller: weightController,
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
                  //************************** Height value Field **************************
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        'Height',
                        style: TextStyle(
                          fontSize: 14,
                          color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white,
                          fontFamily: FontRefer.OpenSans,),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: InputDataField(
                              msg: heightMsg,
                              showMsg: showHeightMsg,
                              maxLength: heightValue == 'cm' ? 5 : 1,
                              width: heightValue == 'cm' ? width/1.7: width/3.5,
                              label: heightValue == 'cm' ? 'Enter your height': 'Feet',
                              controller: heightValue == 'cm' ? cmController : feetController,
                              onChanged: (v){
                                clear();
                                setState(() {
                                  if(v != ''){
                                    if(heightValue == 'cm') _cm = double.parse(v);
                                    else _feet = double.parse(v);
                                  }
                                });
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
                              clear();
                              setState(() {
                                heightValue = option;
                                if(heightValue == 'cm')
                                  _inches = null;
                                if(heightValue == 'feet')
                                  _inches = 0.0;
                              });
                            },
                          ),

                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  //************************** Neck value Field **************************
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        'Neck',
                        style: TextStyle(
                          fontSize: 14,
                          color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white,
                          fontFamily: FontRefer.OpenSans),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputDataField(
                            label: '0.0',
                            width: width/1.7,
                            msg: neckMsg,
                            controller: neckController,
                            showMsg: showNeckMsg,
                            maxLength: 4,
                            onChanged: (value){
                              try{
                                clear();
                                setState(() {
                                  if(value != '' && value != 0 && value == null)
                                    print(double.parse(value.toString()));
                                  _neck = double.parse(value);
                                });
                              }catch(e){}
                            },
                            textInputType: TextInputType.numberWithOptions(decimal: true),
                          ),
                          Container(
                            width: width/4,
                            height: 48,
                            padding: EdgeInsets.only(left: 15, right: 15, top: 12),
                            decoration: BoxDecoration(
                              color: theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Text('inches', style: TextStyle(
                              fontSize: 15,
                              color: theme.lightTheme == true ? Colors.black54 : Colors.white,
                              fontFamily: FontRefer.OpenSans),),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  //************************** Waist value Field **************************
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        'Waist',
                        style: TextStyle(
                          fontSize: 14,
                          color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white,
                          fontFamily: FontRefer.OpenSans),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputDataField(
                            width: width/1.7,
                            label: '0.0',
                            msg: waistMsg,
                            showMsg: showWaistMsg,
                            maxLength: 4,
                            controller: waistController,
                            onChanged: (value){
                              try{
                                clear();
                                setState(() {
                                  if(value != '' && value != 0 && value != null )
                                    _waist = double.parse(value.toString());
                                });
                              }catch(e){}
                            },
                            textInputType: TextInputType.numberWithOptions(decimal: true),
                          ),
                          Container(
                            width: width/4,
                            height: 48,
                            padding: EdgeInsets.only(left: 15, right: 15, top: 12),
                            decoration: BoxDecoration(
                              color: theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Text('inches', style: TextStyle(
                              fontSize: 15,
                              color: theme.lightTheme == true ? Colors.black54 : Colors.white,
                              fontFamily: FontRefer.OpenSans),),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //************************** Hip value Field **************************
                  Visibility(
                    visible: female == true ? true : false,
                    child: Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            'Hips',
                            style: TextStyle(
                              fontSize: 14,
                              color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white,
                              fontFamily: FontRefer.OpenSans),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InputDataField(
                                width: width/1.7,
                                label: '0.0',
                                msg: hipsMsg,
                                showMsg: showHipsMsg,
                                maxLength: 4,
                                controller: hipController,
                                onChanged: (value){
                                  try{
                                    setState(() {
                                      clear();
                                      if(value != '')
                                        _hip = double.parse(value.toString());
                                    });
                                  }catch(e){}
                                },
                                textInputType: TextInputType.numberWithOptions(decimal: true),
                              ),
                              Container(
                                width: width/4,
                                height: 48,
                                padding: EdgeInsets.only(left: 15, right: 15, top: 12),
                                decoration: BoxDecoration(
                                  color: theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                ),
                                child: Text('inches', style: TextStyle(
                                  fontSize: 15,
                                  color: theme.lightTheme == true ? Colors.black54 : Colors.white,
                                  fontFamily: FontRefer.OpenSans),),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  //************************** Compute Body Fat **************************
                  SizedBox(height: 20),
                  RoundedButton(
                      title: 'Compute Body Fat',
                      buttonRadius: 5,
                      colour: ColorRefer.kRedColor,
                      height: 45,
                      onPressed: () async {
                        setState(() {
                        FocusScope.of(context).unfocus();
                          bool allow = validation();
                          if(allow != false){
                            clear();
                            double bodyFat = AuthController.currentUser.gender == 'Female' ?
                            //************************** Calculate body fat for Female **************************
                            calculateBodyFatFemale(
                              height: heightValue == 'cm' ? double.parse(_cm.toStringAsFixed(1)) :
                              double.parse(_feet.toStringAsFixed(1)) + (double.parse(_inches.toStringAsFixed(1))*0.0833333),
                              heightUnit: heightValue,
                              hip: inchesToCentimeter(_hip),
                              neck: inchesToCentimeter(_neck),
                              waist: inchesToCentimeter(_waist)
                            ) :
                            //************************** Calculate body fat for Male **************************
                            calculateBodyFatMale(
                              height: heightValue == 'cm' ? double.parse(_cm.toStringAsFixed(1)) :
                              double.parse(_feet.toStringAsFixed(1)) + (double.parse(_inches.toStringAsFixed(1))*0.0833333),
                              heightUnit: heightValue,
                              neck: inchesToCentimeter(_neck),
                              waist: inchesToCentimeter(_waist),
                            );
                            saveData(bodyFat: bodyFat.isNaN  ? null : bodyFat);
                            Navigator.pushNamed(context, FatCalculatorResultScreen.ID, arguments: bodyFat.isNaN  ? 0.0.toString() : bodyFat.isNegative ? 1.0.toString() : bodyFat.toStringAsFixed(1));
                          }
                        });
                      }
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          )
      ),
    );
  }

  saveData({double bodyFat}){
    if(AuthController.currentUser.gender == 'Female'){
      AuthController.currentUser.hips = _hip;
    }
    AuthController.currentUser.waist = _waist;
    AuthController.currentUser.age = age;
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
    AuthController.currentUser.neck = _neck;
      bodyFat = bodyFat == null ? null : double.parse(bodyFat.toStringAsFixed(1));

      if(bodyFat.isNegative){
        bodyFat = 1.0;
      }
      if(bodyFat > 33){
        bodyFat = 33;
      }
    setState(() {
      AuthController.currentUser.bfp = bodyFat == null ? null : bodyFat;
      AuthController().updateUserFields();
    });
  }
  //************************** Function for validation of age, height and weight values **************************
  validation(){
    if(age < 15.0 || age > 80.0){
      setState(() {
        showAgeMsg = true;
        ageMsg =  "Age should be 15 to 80";
      });
      return false;
    }
    if(heightValue == 'cm'){
      if(_cm < 145.0 || _cm > 230.0 ) {
        setState(() {
          showHeightMsg = true;
          heightMsg = "Height value should be 145 to 230 cm";
        });
        return false;
      }
    }else{
      if(_feet < 4.0 || _feet > 8) {
        setState(() {
          showHeightMsg = true;
          heightMsg = "Height value should be 4 to 8 foot";
        });
        return false;
      }
    }
    if(weightValue == 'kg'){
      if(_weight < 35.0 || _weight > 110.0) {
        setState(() {
          showWeightMsg = true;
          weightMsg = "Weight value should be 35 to 110 kg";
        });
        return false;
      }
    }else{
      if(_weight < 77.0 || _weight > 243.0) {
        setState(() {
          showWeightMsg = true;
          weightMsg = "Weight value should be 77 to 243 pounds";
        });
        return false;
      }
    }
    if(_neck < 11.0 || _neck > 25.0){
      setState(() {
        showNeckMsg = true;
        neckMsg =  "Neck value should be 11 to 25 inch";
      });
      return false;
    }
    if(_waist < 25.0 || _waist > 45.0){
      setState(() {
        showWaistMsg = true;
        waistMsg =  "Waist value should be 25 to 45 inch";
      });
      return false;
    }
    if(female == true){
      if(_hip < 27.0 || _hip > 58.0){
        setState(() {
          showHipsMsg = true;
          hipsMsg =  "Hip value should be 27 to 58 inch";
        });
        return false;
      }
    }
  }

  double inchesToCentimeter(double inches){
    return (inches * 2.54);
  }

  clear(){
    setState(() {
      heightMsg = '';
      showHeightMsg = false;
      weightMsg = '';
      showWeightMsg = false;
      ageMsg = '';
      showAgeMsg = false;
      neckMsg = '';
      showNeckMsg = false;
      waistMsg = '';
      showWaistMsg = false;
      hipsMsg = '';
      showHipsMsg = false;
    });
  }
}



