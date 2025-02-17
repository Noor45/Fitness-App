import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:t_fit/utils/colors.dart';
import '../utils/fonts.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class SettingTabs extends StatefulWidget {
  SettingTabs({this.title, this.onTap});
  final String title;
  final Function onTap;
  @override
  _SettingTabsState createState() => _SettingTabsState();
}

class _SettingTabsState extends State<SettingTabs> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Card(
      elevation: 5,
      color: theme.lightTheme == true ? Colors.white : Colors.white10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          width: width,
          height: MediaQuery.of(context).size.height / 14,
          padding: EdgeInsets.only(left: 20),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                widget.title,
                style: TextStyle(fontSize: 14, fontFamily: FontRefer.OpenSans, fontWeight: FontWeight.w700),
              ),
              SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class SwitchCard extends StatefulWidget {
  SwitchCard({this.text, this.isSwitched, this.onChanged});
  final String text;
  bool isSwitched;
  final Function onChanged;

  @override
  _SwitchCardState createState() => _SwitchCardState();
}

class _SwitchCardState extends State<SwitchCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      color: theme.lightTheme == true ? Colors.white : Colors.white10,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 14,
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  widget.text,
                  style: TextStyle(fontSize: 14,  fontFamily: FontRefer.OpenSans,  fontWeight: FontWeight.w700),
                ),
              ),
              Expanded(
                flex: 1,
                child: FlutterSwitch(
                  width: 43.0,
                  height: 25,
                  toggleSize: 25.0,
                  value: widget.isSwitched,
                  borderRadius: 20.0,
                  activeColor: Colors.blue,
                  inactiveColor: Colors.grey,
                  onToggle: widget.onChanged,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageCard extends StatefulWidget {
  @override
  _LanguageCardState createState() => _LanguageCardState();
}

class _LanguageCardState extends State<LanguageCard> {
  int val = -1;
  // String _verticalGroupValue = "English";
  // List<String> _status = ["English", "Chinese", "Arabic", "Russian", "Spanish"];
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.only(left: 40, right: 40),

      elevation: 0,
      child: contentBox(context),
    );
  }

  function(dynamic value){
    setState(() {
      val = value;
    });
  }

  contentBox(context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 260,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: theme.lightTheme == true ? Colors.white :  Color(0xff2A2A2A),

      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Text('English'),
                   onTap: (){
                      function(1);
                      // changeLanguage(context, 'en');
                   },
                ),
                Radio(
                  value: 1,
                  groupValue: val,
                  onChanged: (value) {
                    function(value);
                    // changeLanguage(context, 'en');
                  },
                  activeColor: ColorRefer.kRedColor,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(child: Text('Chinese'),
                  onTap: (){
                    function(2);
                    // changeLanguage(context, 'ch');
                  },
                ),
                Radio(
                  value: 2,
                  groupValue: val,
                  onChanged: (value) {
                    function(value);
                    // changeLanguage(context, 'ch');
                  },
                  activeColor: ColorRefer.kRedColor,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Text('Arabic'),
                  onTap: (){
                    function(3);
                    // changeLanguage(context, 'ar');
                  }
                ),
                Radio(
                  value: 3,
                  groupValue: val,
                  onChanged: (value) {
                    function(value);
                    // changeLanguage(context, 'ar');
                  },
                  activeColor: ColorRefer.kRedColor,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Text('Russian'),
                  onTap: () {
                    function(4);
                    // changeLanguage(context, 'ru');
                  },
                ),
                Radio(
                  value: 4,
                  groupValue: val,
                  onChanged: (value) {
                    function(value);
                    // changeLanguage(context, 'ru');
                  },
                  activeColor: ColorRefer.kRedColor,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    child: Text('Spanish'),
                    onTap: (){
                      function(5);
                      // changeLanguage(context, 'es');
                    }
                ),
                Radio(
                  value: 5,
                  groupValue: val,
                  onChanged: (value) {
                    function(value);
                    // changeLanguage(context, 'es');
                  },
                  activeColor: ColorRefer.kRedColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
