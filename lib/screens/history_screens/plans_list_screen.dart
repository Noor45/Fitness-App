import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:t_fit/controllers/auth_controller.dart';
import 'package:t_fit/models/user_model/user_plan_model.dart';
import 'package:t_fit/screens/history_screens/user_detail_screen.dart';
import 'package:t_fit/utils/fonts.dart';
import '../../../cards/custom_cards.dart';
import '../../../utils/colors.dart';
import '../../../utils/style.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class PlanListScreen extends StatefulWidget {
  static const String ID = "/plan_list_screen";
  @override
  _PlanListScreenState createState() => _PlanListScreenState();
}

class _PlanListScreenState extends State<PlanListScreen> {
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    int type = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
        appBar: AppBar(
          elevation: theme.lightTheme == true ? 3 : 0,
          iconTheme: IconThemeData(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
          systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
          centerTitle: true,
          title: Text(
            '${type == 0 ?'Workout':'Meal'} Plan List',
            style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 15),
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: _isLoading,
          progressIndicator: CircularProgressIndicator(color: ColorRefer.kRedColor,),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ImageCard(
                  image: type == 0 ? 'assets/images/workout.png': 'assets/images/meal.png',
                  title: 'List of ${type == 0 ?'Workout':'Meal'} Plans',
                  subtitle: '',
                ),
                SizedBox(height: 15),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('user_plans').where('user_id', isEqualTo: AuthController.currentUser.uid)
                        .where('plan_type', isEqualTo: type).orderBy('start_date').snapshots(),
                    builder: (context, snapshot) {
                      List<PlanModel> plansList = [];
                      if (snapshot.hasData) {
                        final details = snapshot.data.docs;
                        for (var detail in details) {
                          PlanModel plans = PlanModel.fromMap(detail.data());
                          plansList.add(plans);
                        }
                      }
                      return plansList == null || plansList.length == 0 ? Container(
                        height: MediaQuery.of(context).size.height/1.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.list_bullet,
                              color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                              size: 50,
                            ),
                            SizedBox(height: 6),
                            AutoSizeText('No plan assign yet', style: TextStyle(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontFamily: FontRefer.OpenSans,  fontSize: 16),)
                          ],
                        ),
                        ) : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: plansList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.only(top: 15),
                              child: WeekCards(
                                title: 'Plan ${index+1}',
                                subtitle: '${plansList[index].planName} for ${plansList[index].duration} Week',
                                icon: type == 0 ? 'assets/icons/workout.svg' : 'assets/icons/meal.svg',
                                onPressed: () async{
                                  Navigator.pushNamed(context, UserPlanDetailScreen.ID, arguments: [plansList[index], type]);
                                },
                              ),
                            );
                          });
                    }
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        )
    );
  }
}






