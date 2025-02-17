import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../utils/colors.dart';
import '../utils/style.dart';
import '../utils/fonts.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';


class SwitchTab extends StatefulWidget {
  SwitchTab({this.text, this.isSwitched, this.onChanged});
  final String text;
  bool isSwitched;
  final Function onChanged;
  @override
  _SwitchTabState createState() => _SwitchTabState();
}

class _SwitchTabState extends State<SwitchTab> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.white12),
        ),
        color: Colors.white10,
      ),
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Text(
              widget.text,
              style: TextStyle(color: Colors.white, fontSize: 14,  fontFamily: FontRefer.OpenSans,  fontWeight: FontWeight.w700),
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
    );
  }
}

class NotificationCard extends StatefulWidget {
  NotificationCard({this.onPressed, this.type, this.des, this.title, this.time, this.mealPortion, this.md});
  final int type;
  final String title;
  final String time;
  final String des;
  final int mealPortion;
  final int md;
  final Function onPressed;
  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {

  @override
  void initState() {
    print(iconFunction());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Card(
      margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
      elevation: 7,
      color: theme.lightTheme == true ? Colors.white : ColorRefer.kBoxColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: widget.onPressed,
        child: Container(
          width: width,
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 15),
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconFunction(),
                width: 50,
                height: 50,
                color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : Colors.white,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor : Colors.white, fontWeight: FontWeight.w900, fontSize: 13),
                  ),
                  SizedBox(height: 6),
                  Container(
                    width: width/1.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.des,
                          style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white, fontWeight: FontWeight.w600, fontSize: 11),
                        ),
                        Text(
                          widget.time,
                          style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

   iconFunction(){
    if(widget.mealPortion == null) {
      if(widget.type == 2){
        return 'assets/icons/dumbbell.svg';
      }
      if(widget.type == 3){
        return 'assets/icons/updates.svg';
      }
    }else{
      if(widget.type == 1){
        if(widget.md == 1){
          if(widget.mealPortion == 1){
            return 'assets/icons/dinner.svg';
          }
        }
        if(widget.md == 2){
          if(widget.mealPortion == 1){
            return 'assets/icons/lunch.svg';
          }
          if(widget.mealPortion == 2){
            return 'assets/icons/dinner.svg';
          }
        }
        if(widget.md == 3){
          if(widget.mealPortion == 1){
            return 'assets/icons/breakfast.svg';
          }
          if(widget.mealPortion == 2){
            return 'assets/icons/lunch.svg';
          }
          if(widget.mealPortion == 3){
            return 'assets/icons/dinner.svg';
          }
        }
        if(widget.md == 4){
          if(widget.mealPortion == 1){
            return 'assets/icons/breakfast.svg';
          }
          if(widget.mealPortion == 2){
            return 'assets/icons/lunch.svg';
          }
          if(widget.mealPortion == 3){
            return 'assets/icons/lunch.svg';
          }
          if(widget.mealPortion == 4){
            return 'assets/icons/dinner.svg';
          }
        }
        if(widget.md == 5){
          if(widget.mealPortion == 1){
            return 'assets/icons/breakfast.svg';
          }
          if(widget.mealPortion == 2){
            return 'assets/icons/lunch.svg';
          }
          if(widget.mealPortion == 3){
            return 'assets/icons/lunch.svg';
          }
          if(widget.mealPortion == 4){
            return 'assets/icons/lunch.svg';
          }
          if(widget.mealPortion == 5){
            return 'assets/icons/dinner.svg';
          }
        }
        if(widget.md == 6){
          if(widget.mealPortion == 1){
            return 'assets/icons/breakfast.svg';
          }
          if(widget.mealPortion == 2){
            return 'assets/icons/lunch.svg';
          }
          if(widget.mealPortion == 3){
            return 'assets/icons/lunch.svg';
          }
          if(widget.mealPortion == 4){
            return 'assets/icons/lunch.svg';
          }
          if(widget.mealPortion == 5){
            return 'assets/icons/lunch.svg';
          }
          if(widget.mealPortion == 6){
            return 'assets/icons/dinner.svg';
          }
        }
      }
    }
  }

}