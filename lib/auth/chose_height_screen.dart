import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import '../functions/calculator_functions.dart';
import '../services/theme_model.dart';
import '../auth/select_allergies_screen.dart';
import '../controllers/auth_controller.dart';
import '../widgets/input_field.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/fonts.dart';
import '../widgets/round_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SelectHeightScreen extends StatefulWidget {
  static const String ID = "/select_height_screen";
  @override
  _SelectHeightScreenState createState() => _SelectHeightScreenState();
}

class _SelectHeightScreenState extends State<SelectHeightScreen> {
  String gender;
  double _cm;
  double _feet;
  double _inches;
  int slideIndex = Constants.update  == true ?  4 : 3;
  int v = Constants.update  == true ?  6 : 5;
  String value = 'cm';
  List<String> list = [
    'cm',
    'feet'
  ];
  bool showMsg = false;
  String msg = '';
  TextEditingController cmController = TextEditingController();
  TextEditingController feetController = TextEditingController();
  TextEditingController inchesController = TextEditingController();
  Widget _buildPageIndicator(bool isCurrentPage, DarkThemeProvider theme) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      height: isCurrentPage ? 8.0 : 8.0,
      width: isCurrentPage ? 8.0 : 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCurrentPage ? theme.lightTheme == true ? ColorRefer.kRedColor : Colors.white : Colors.grey,
      ),
    );
  }

  valueType(int option){
    setState(() {
      if(option == 1) {
        value = 'cm';
      }
      if(option == 2){
        value = 'feet';
      }
    });
  }

  calculate(){
   double bmi = 0.0;
   bmi = calculateBMI(
     weight: AuthController.currentUser.weight['value'],
     weightUnit: AuthController.currentUser.weight['key'],
     height: value == 'cm' ? AuthController.currentUser.height['value'] :
     AuthController.currentUser.height['value']+ (AuthController.currentUser.height['inches']*0.0833333),
     heightUnit: AuthController.currentUser.height['key'],
   );
   AuthController.currentUser.bmi = bmi;
  }

  @override
  void initState() {
    if(Constants.update == true){
      value = AuthController.currentUser.height['key'];
      if(value == 'feet'){
        if(AuthController.currentUser.height != 0.0){
          _feet = AuthController.currentUser.height['value'];
          feetController.text = _feet.toString();
        }
        _inches = AuthController.currentUser.height['inches'];
        if(_inches != null) inchesController.text = _inches.toString();
      }
      if(value == 'cm'){
        if(AuthController.currentUser.height != 0.0){
          _cm = AuthController.currentUser.height['value'];
          cmController.text = _cm.toString();
        }
        _inches = AuthController.currentUser.height['inches'];
        if(_inches != null) inchesController.text = _inches.toString();
      }
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).requestFocus(FocusNode());
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: width,
              height: height,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 15, right: 15),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: Constants.update == true ? false : true,
                      child: Container(
                        padding:EdgeInsets.only(bottom: 8),
                        child: AutoSizeText(
                          'Step 3 of 4',
                          style: TextStyle(
                            color: ColorRefer.kGreyColor,
                            fontSize: 15,
                            fontFamily: FontRefer.OpenSans,
                          ),
                        ),
                      ),
                    ),
                    AutoSizeText(
                      'Height',
                      style: TextStyle(
                          fontSize: 25,
                          color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white,
                          fontFamily: FontRefer.OpenSans,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: InputDataField(
                            width: value == 'cm' ? width/1.8 : width/3.5,
                            label: value == 'cm' ? 'Enter your height': 'Feet',
                            controller: value == 'cm' ? cmController : feetController,
                            msg: msg,
                            showMsg: showMsg,
                            maxLength: value == 'cm' ? 5 : 1,
                            onChanged: (v){
                              setState(() {
                                showMsg = false;
                                if(v != ''){
                                  if(value == 'cm') _cm = double.parse(v);
                                  else _feet = double.parse(v);
                                }
                              });
                            },
                            textInputType: TextInputType.numberWithOptions(decimal: true),
                          ),
                        ),
                        Visibility(
                          visible: value == 'cm' ? false : true,
                          child: Expanded(
                            child: InputDataField(
                              width: width/3.5,
                              label: 'Inches',
                              maxLength: 2,
                              controller: inchesController,
                              onChanged: (value){
                                showMsg = false;
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
                          width: value == 'cm' ? width/3: width/4,
                          value: value,
                          selectionList: list,
                          onChanged:  (option){
                            setState(() {
                              value = option;
                              if(value == 'cm')
                                _inches = null;
                              if(value == 'feet')
                                _inches = 0.0;
                            });
                          },
                        ),

                      ],
                    ),
                    SizedBox(height: 30),
                    ButtonWithIcon(
                        title: 'Next',
                        buttonRadius: 5,
                        colour: value == 'cm' ? _cm == null
                            ? ColorRefer.kRedColor.withOpacity(0.5)
                            : ColorRefer.kRedColor : _feet == null ?
                              ColorRefer.kRedColor.withOpacity(0.5)
                            : ColorRefer.kRedColor,
                        height: 40,
                        onPressed: value == 'cm' ? _cm == null  || cmController.text == ''
                            ? null : () async {
                          if(_cm < 145.0 || _cm > 230.0 ) {
                            setState(() {
                              showMsg = true;
                              msg = "Height should be 145 to 230 cm";
                            });
                          }else{
                            showMsg = false;
                            AuthController.currentUser.height = {'value': double.parse(_cm.toStringAsFixed(1)), 'inches' : null, 'key': value};
                            await calculate();
                            AuthController().updateUserFields();
                            if (Constants.update == true) Navigator.pushNamed(context, SelectAllergies.ID);
                            else Navigator.pushReplacementNamed(context, SelectAllergies.ID);
                          }
                        }
                        : _feet == null   ||  feetController.text == '' ? null : () async{
                          if(_feet < 4.0 || _feet > 8) {
                            setState(() {
                              showMsg = true;
                              msg = "Height should be 4 to 8 foot";
                            });
                          }else{
                            showMsg = false;
                            AuthController.currentUser.height = {
                              'value': double.parse(_feet.toStringAsFixed(1)),
                              'inches' : double.parse(_inches.toStringAsFixed(1)),
                              'key': value,
                            };
                            await calculate();
                            AuthController().updateUserFields();
                            Navigator.pushNamed(context, SelectAllergies.ID);
                          }
                        }
                      ) ,
                    SizedBox(height: 30),
                    Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < v; i++)
                            i == slideIndex
                                ? _buildPageIndicator(true, theme)
                                : _buildPageIndicator(false, theme),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}
