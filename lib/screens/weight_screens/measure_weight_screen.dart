import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:t_fit/controllers/general_controller.dart';
import 'package:t_fit/functions/global_functions.dart';
import 'package:t_fit/models/user_model/user_weight_model.dart';
import 'package:toast/toast.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/input_field.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/fonts.dart';
import '../../widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class MeasureWeightScreen extends StatefulWidget {
  static const String ID = "/measure_weight_screen";
  @override
  _MeasureWeightScreenState createState() => _MeasureWeightScreenState();
}

class _MeasureWeightScreenState extends State<MeasureWeightScreen> {
  UserWeightModel dailyWeight = UserWeightModel();
  InputDecoration fieldDecoration;
  double _weight;
  String note;
  String value = 'kg';
  int type = 1;
  bool showMsg = false;
  String msg = '';
  final formKey = GlobalKey<FormState>();
  Random _rnd = Random();
  TextEditingController writeNoteController = TextEditingController();
  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  TextEditingController controller = TextEditingController();

  fieldDecor(DarkThemeProvider theme){
    fieldDecoration = InputDecoration(
      enabledBorder: InputBorder.none,
      counterText: '',
      hintStyle: TextStyle(
          fontSize: 13,
          fontFamily: FontRefer.OpenSans,
          color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
      focusedBorder: InputBorder.none,
      focusColor: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
      contentPadding: EdgeInsets.only(left: 10, top: 3),
    );
  }

  @override
  void initState() {
    value = AuthController.currentUser.weight['key'];

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    fieldDecor(theme);
    return Scaffold(
      backgroundColor: theme.lightTheme == true ? Colors.white :  ColorRefer.kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      ),
      body: SafeArea(
          child: Container(
            width: width,
            height: height,
            padding: EdgeInsets.only(left: 15, right: 15, top: width/2.5),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      'Weight',
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
                        InputDataField(
                          width: width/1.6,
                          label: 'Enter your weight',
                          maxLength: 5,
                          msg: msg,
                          showMsg: showMsg,
                          controller: controller,
                          validator: (String weight) {
                            if (weight.isEmpty) return "Weight is required!";
                            if (weight == '') return "Weight is required!";
                          },
                          onChanged: (value){
                            showMsg = false;
                            setState(() {
                              if(value != '')
                                _weight = double.parse(value);

                            });
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
                          child: Text(AuthController.currentUser.weight['key'], style: TextStyle(
                              fontSize: 15,
                              color: theme.lightTheme == true ? Colors.black54 : Colors.white,
                              fontFamily: FontRefer.OpenSans),),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: width,
                      padding: EdgeInsets.only(left: 15, right: 20),
                      decoration: BoxDecoration(
                        color:  theme.lightTheme == true ? ColorRefer.kLightGreyColor : ColorRefer.kBoxColor,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: TextField(
                        controller: writeNoteController,
                        maxLines: 5,
                        keyboardType: TextInputType.multiline,
                        onChanged: (value){
                          note = value;
                        },
                        decoration : InputDecoration(
                          enabledBorder: InputBorder.none,
                          counterText: '',
                          hintText: 'Write note (Additional Option)...',
                          hintStyle: TextStyle(
                              fontSize: 13,
                              fontFamily: FontRefer.OpenSans,
                              color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
                          focusedBorder: InputBorder.none,
                          focusColor: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                          contentPadding: EdgeInsets.only(left: 10, top: 10),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    ButtonWithIcon(
                        title: 'Save',
                        buttonRadius: 5,
                        colour: _weight == null
                            ? ColorRefer.kRedColor.withOpacity(0.5)
                            : ColorRefer.kRedColor,
                        height: 40,
                        onPressed: _weight == null || controller.text == ''
                            ? null
                            : () {
                          FocusScope.of(context).unfocus();
                          if(AuthController.currentUser.weight['key'] == 'kg'){
                            if(_weight < 35.0 || _weight > 110.0) {
                              setState(() {
                                showMsg = true;
                                msg = "Weight should be 35 to 110 kg";
                              });
                            }else{
                              showMsg = false;
                              updateData();
                            }
                          }else{
                            if(_weight < 77.0 || _weight > 243.0) {
                              setState(() {
                                showMsg = true;
                                msg = "Weight should be 77 to 243 pounds";
                              });
                            }else{
                              showMsg = false;
                              updateData();
                            }
                          }
                        }
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }


  updateData() async{
    setState(() {
      dailyWeight.weight = _weight;
      dailyWeight.note = note;
      dailyWeight.key = value;
      dailyWeight.date = Timestamp.now();
      dailyWeight.uid = AuthController.currentUser.uid;
      dailyWeight.id =  getRandomString(16).substring(2);
      Constants.dailyWeight = dailyWeight;
    });
    GeneralController.saveUserWeight(dailyWeight);
    await dbHelper.insertWeightData(dailyWeight);
    Toast.show("Saved", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    Navigator.pop(context);
  }
}
