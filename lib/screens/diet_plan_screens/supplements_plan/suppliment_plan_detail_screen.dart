import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rubber/rubber.dart';
import '../../../models/supplement_model/supplement_detail_model.dart';
import '../../../models/supplement_model/supplement_model.dart';
import '../../../models/supplement_model/supplement_use_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/style.dart';
import '../../../utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class SupplementPlanDetailScreen extends StatefulWidget {
  static const String ID = "/supplement_plan_detail_screen";
  @override
  _SupplementPlanDetailScreenState createState() => _SupplementPlanDetailScreenState();
}

class _SupplementPlanDetailScreenState extends State<SupplementPlanDetailScreen> with SingleTickerProviderStateMixin {
  List args = [];
  SupplementPlanModel supplementPlan;
  SupplementUseModel supplementUse;
  SupplementDetailModel supplementDetail;
  String day;
  ScrollController _scrollController = ScrollController();
  RubberAnimationController _controller;
  @override
  void initState() {
    _controller = RubberAnimationController(
        vsync: this,
        lowerBoundValue: AnimationControllerValue(percentage: 0.2),
        halfBoundValue: AnimationControllerValue(percentage: 0.5),
        duration: Duration(milliseconds: 200)
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    args = ModalRoute.of(context).settings.arguments;
    day = args[1];
    supplementPlan = args[0];
    supplementUse = SupplementUseModel.fromMap(supplementPlan.use);
    supplementDetail = SupplementDetailModel.fromMap(supplementPlan.detail);
    return Scaffold(
      backgroundColor: theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
      appBar: AppBar(
        elevation: theme.lightTheme == true ? 3 : 0,
        systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
        iconTheme: IconThemeData(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
        centerTitle: true,
        title: Text(
          'Day ${supplementPlan.day}',
          style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 15),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage("assets/images/supplement_photo.png"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(theme.lightTheme == true ? 0.3 : 0.4), BlendMode.darken)
          ),
        ),
        child: RubberBottomSheet(
          scrollController: _scrollController,
          lowerLayer: _getLowerLayer(supplementPlan.name, day, supplementUse.dosage, theme),
          header: Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40)
              ),
            ),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SupplementChart(
                    title: 'Dosage',
                    value: supplementUse.grams.toString(),
                    unit: 'grams',
                    show: true,
                    leftSpace: 20,
                  ),
                  SupplementChart(
                    title: 'Cycle',
                    value: supplementUse.durationWeek.toString(),
                    unit: 'Week',
                    show: true,
                    leftSpace: 30,
                  ),
                  SupplementChart(
                    title: 'Rec. level',
                    blockColor: supplementUse.level == 'must' ? ColorRefer.kRedColor : Colors.yellow,
                    showBlock: true,
                    unit: supplementUse.level,
                    show: false,
                    leftSpace: 40,
                  ),
                ],
              ),
            ),
          ),
          headerHeight: 120,
          upperLayer: _getUpperLayer(supplementDetail, supplementPlan.name),
          animationController: _controller,
        ),
      ),

    );
  }
  Widget _getLowerLayer(String supplementName, String day, String dosage, DarkThemeProvider theme) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage("assets/images/supplement_photo.png"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(theme.lightTheme == true ? 0.3 : 0.4), BlendMode.darken)
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20,top: width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                supplementName,
                style: StyleRefer.kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 35),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  SvgPicture.asset('assets/icons/time.svg'),
                  SizedBox(width: 10),
                  AutoSizeText(
                    '$day, ${dosage.capitalize()}',
                    style: StyleRefer.kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _getUpperLayer(SupplementDetailModel supplementDetail, String name) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 25, 20, 0),
      decoration: BoxDecoration(color: Colors.white),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: StyleRefer.kTextStyle.copyWith(color: ColorRefer.kRedColor, fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              supplementDetail.des,
              style: StyleRefer.kTextStyle.copyWith(color: Colors.black87, fontSize: 15),
            ),
            Visibility(
              visible: supplementDetail.image == '' ? false : true,
              child: Container(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Image.network(supplementDetail.image)
              ),
            ),
            Visibility(
              visible: supplementDetail.formula == '' ? false : true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Formula',
                    style: StyleRefer.kTextStyle.copyWith(color: ColorRefer.kRedColor, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    supplementDetail.formula.toUpperCase(),
                    style: StyleRefer.kTextStyle.copyWith(color: Colors.black87, fontSize: 15),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Calories',
              style: StyleRefer.kTextStyle.copyWith(color: ColorRefer.kRedColor, fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              supplementDetail.calories,
              style: StyleRefer.kTextStyle.copyWith(color: Colors.black87, fontSize: 15),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class SupplementChart extends StatelessWidget {
  SupplementChart({this.title, this.value = '', this.show, this.unit, this.leftSpace, this.blockColor, this.showBlock = false});
  final bool show;
  final String value;
  final String title;
  final String unit;
  final bool showBlock;
  final Color blockColor;
  final double leftSpace;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.only(left: leftSpace, right: 30),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 1, color: show == true ? Colors.black12 : Colors.white),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: StyleRefer.kTextStyle.copyWith(color: Colors.black87, fontSize: 10),
          ),
          SizedBox(height: 3),
          Container(
            child: showBlock == false ?
            Text(
              value.toString().capitalize(),
              style: StyleRefer.kTextStyle.copyWith(color: Colors.black, fontSize: 13),
            ) : Icon(Icons.circle, color: blockColor, size: 20,),
          ),
          SizedBox(height: 3),
          Text(
            unit.capitalize(),
            style: StyleRefer.kTextStyle.copyWith(color: Colors.black87, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

