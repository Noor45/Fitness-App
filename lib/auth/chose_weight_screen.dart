import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:t_fit/services/theme_model.dart';
import '../auth/chose_height_screen.dart';
import '../controllers/auth_controller.dart';
import '../widgets/input_field.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/fonts.dart';
import 'package:provider/provider.dart';
import '../widgets/round_button.dart';
import 'package:flutter/material.dart';

class SelectWeightScreen extends StatefulWidget {
  static const String ID = "/select_weight_screen";
  @override
  _SelectWeightScreenState createState() => _SelectWeightScreenState();
}

class _SelectWeightScreenState extends State<SelectWeightScreen> {
  String gender;
  double _weight;
  int slideIndex = Constants.update  == true ?  3 : 2;
  int v = Constants.update  == true ?  6 : 5;
  String value = 'kg';
  int type = 1;
  List<String> list = ['kg', 'pound'];
  bool showMsg = false;
  String msg = '';
  final formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
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

  @override
  void initState() {
    if(Constants.update == true){
      if(AuthController.currentUser.weight != 0.0){
        _weight = AuthController.currentUser.weight['value'];
        controller.text = _weight.toString();
        value = AuthController.currentUser.weight['key'];
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
      backgroundColor: theme.lightTheme == true ? Colors.white :  ColorRefer.kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      ),
      body: SafeArea(
          child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.only(left: 15, right: 15),
            child: Form(
              key: formKey,
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
                          color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                          fontSize: 15,
                          fontFamily: FontRefer.OpenSans,
                        ),
                      ),
                    ),
                  ),
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
                        width: width/1.8,
                        label: 'Enter your weight',
                        maxLength: 4,
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
                      SelectData(
                        width: width/3,
                        value: value,
                        selectionList: list,
                        onChanged: (option){
                          setState(() {
                            showMsg = false;
                            value = option;
                            if(value == 'kg')
                              type = 1;
                            if(value == 'pound')
                              type = 2;
                          });
                        },
                      ),

                    ],
                  ),

                  SizedBox(height: 30),
                  ButtonWithIcon(
                      title: 'Next',
                      buttonRadius: 5,
                      colour: _weight == null
                          ? ColorRefer.kRedColor.withOpacity(0.5)
                          : ColorRefer.kRedColor,
                      height: 40,
                      onPressed: _weight == null || controller.text == ''
                          ? null
                          : () {

                                if(value == 'kg'){
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
      )
      ),
    );
  }

  updateData(){
    AuthController.currentUser.weight = {
      'value': double.parse(_weight.toStringAsFixed(1)),
      'key': value,
    };
    AuthController().updateUserFields();
    Navigator.pushNamed(context, SelectHeightScreen.ID);
  }
}
