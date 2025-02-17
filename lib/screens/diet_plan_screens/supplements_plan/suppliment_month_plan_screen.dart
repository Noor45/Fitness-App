import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../../../cards/custom_cards.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/style.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';
import '../../../screens/diet_plan_screens/supplements_plan/suppliment_week_plan_screen.dart';


class SupplimentMonthPlanScreen extends StatefulWidget {
  static const String ID = "/supplement_month_plan_screen";
  @override
  _SupplimentMonthPlanScreenState createState() => _SupplimentMonthPlanScreenState();
}

class _SupplimentMonthPlanScreenState extends State<SupplimentMonthPlanScreen> {
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor:  theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
      appBar: AppBar(
        elevation: theme.lightTheme == true ? 3 : 0,
        iconTheme: IconThemeData(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
        systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
        centerTitle: true,
        title: Text(
          'Supplements',
          style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 15),
        )
      ),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: _isLoading,
          progressIndicator: Theme(
            data: Theme.of(context).copyWith(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorRefer.kRedColor)),
            child: CircularProgressIndicator(
              color: ColorRefer.kRedColor,
            ),
          ),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ImageCard(
                    image: 'assets/images/supplements.png',
                    title: 'Supplements',
                    subtitle: '',
                  ),
                  SizedBox(height: 15),
                  Container(
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: Constants.supplementPlanDetail.duration,
                        itemBuilder: (BuildContext context, int index) {
                          return  WeekCards(
                            title: 'WEEK ${index+1}',
                            showSubtitle: false,
                            subtitle: '',
                            icon: 'assets/icons/supplements.svg',
                            onPressed: () async{
                              Constants.userWeeklySupplementsList = [];
                              Constants.userSupplementsList.forEach((element) {
                                if(element.week == index+1){
                                  Constants.userWeeklySupplementsList.add(element);
                                }
                              });
                              Navigator.pushNamed(context, SupplementWeekPlanScreen.ID, arguments: index+1);

                            },
                          );
                        }
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}