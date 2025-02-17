import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import 'fonts.dart';
import '../widgets/gradient.dart';
class StyleRefer {
  // static var kTextFieldDecoration = InputDecoration(
  //   hintStyle: TextStyle(
  //     color: ColorRefer.kDarkColor,
  //     fontSize: 9,
  //   ),
  //   focusedBorder: UnderlineInputBorder(
  //       borderSide: BorderSide(color: ColorRefer.kDarkColor)
  //   ),
  //   enabledBorder: UnderlineInputBorder(
  //       borderSide: BorderSide(color: theme.brightness == Brightness.light ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor)
  //   ),
  //   focusColor: Colors.black,
  //   contentPadding: EdgeInsets.only(left: 0, top: 3),
  // );
  // static var kWithoutBorderTextFieldDecoration = InputDecoration(
  //   hintStyle: TextStyle(
  //     color: theme.brightness == Brightness.light ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
  //     fontSize: 12,
  //   ),
  //   enabledBorder: InputBorder.none,
  //   focusedBorder: InputBorder.none,
  //   focusColor: theme.brightness == Brightness.light ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
  //   contentPadding: EdgeInsets.only(left: 10, top: 3),
  // );
  // static var kRoundTextFieldDecoration = InputDecoration(
  //   hintStyle: TextStyle(
  //     color: theme.brightness == Brightness.light ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
  //     fontSize: 12,
  //   ),
  //   border: OutlineInputBorder(
  //     borderRadius: BorderRadius.all(Radius.circular(15.0)),
  //   ),
  //   enabledBorder: OutlineInputBorder(
  //     borderSide:
  //     BorderSide(color: theme.brightness == Brightness.light ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, width: 1.0),
  //     borderRadius: BorderRadius.all(Radius.circular(15.0)),
  //   ),
  //   focusedBorder: OutlineInputBorder(
  //     borderSide:
  //     BorderSide(color: theme.brightness == Brightness.light ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, width: 2.0),
  //     borderRadius: BorderRadius.all(Radius.circular(15.0)),
  //   ),
  //   focusColor: theme.brightness == Brightness.light ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
  //   contentPadding: EdgeInsets.only(left: 10, top: 3),
  // );

  static TextStyle kTextStyle =  TextStyle(fontFamily: FontRefer.OpenSans);

  static TextStyle kCheckBoxTextStyle = TextStyle(fontFamily: FontRefer.SansSerif, fontSize: 12);

  static LinearGradient gradient = LinearGradient(
      colors: <Color>[
        Color(0xff8A0101),
        Color(0xffFFE400),
        Color(0xff00FF6D),
        Color(0xff008137),
        Color(0xffFFE400),
        Color(0xff8A0101),
      ],
      tileMode: TileMode.decal,
      stops: AuthController.currentUser.gender == 'Female' ? femaleFatRange : maleFatRange
  );
  static List<double> femaleFatRange = [0.30, 0.39, 0.63, 0.72, 0.93, 1.0,];
  static List<double> maleFatRange = [0.06, 0.15, 0.39, 0.51, 0.92, 1.0,];
  static var kSliderBar = SliderThemeData(
  trackHeight: 25,
  thumbColor: Colors.white,
  showValueIndicator: ShowValueIndicator.never,
  trackShape: GradientRectSliderTrackShape(gradient: gradient, darkenInactive: false),
  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 14, elevation: 0));

}
