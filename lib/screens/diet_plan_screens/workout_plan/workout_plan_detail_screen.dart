import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:t_fit/widgets/url_video_player.dart';
import 'package:t_fit/widgets/youtube_player.dart';
import '../../../functions/global_functions.dart';
import '../../../models/workout_model/workout_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/strings.dart';
import '../../../utils/style.dart';
import '../../../widgets/round_button.dart';
import '../../../widgets/vimeo_player.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';
import '../../../screens/diet_plan_screens/workout_plan/workout_video_screen.dart';

class WorkoutPlanDetailScreen extends StatefulWidget {
  static const String ID = "/workout_plan_detail_screen";
  @override
  _WorkoutPlanDetailScreenState createState() => _WorkoutPlanDetailScreenState();
}

class _WorkoutPlanDetailScreenState extends State<WorkoutPlanDetailScreen> {
  WorkoutPlanModel workouts;
  bool isDone = false;
  String buttonTitle  = '' ;
   changeButtonTitle(){
    buttonTitle = isDone == true ? 'Workout Completed' : 'Start Workouts';
    setState(() {
      if(workouts.week == Constants.userWorkoutPlanData.currentWeek && workouts.day == Constants.userWorkoutPlanData.currentDay){
        if(VideoTools.workoutStart == true){
          buttonTitle = 'Continue Workouts';
        }
      }
    });
  }
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    List args = ModalRoute.of(context).settings.arguments;
    workouts = args[0];
    isDone = args[1];
    changeButtonTitle();
    return Scaffold(
      backgroundColor: theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
      appBar: AppBar(
        elevation: theme.lightTheme == true ? 3 : 0,
        centerTitle: true,
        title: Text(
          workouts.title,
          style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 15),
        ),
        iconTheme: IconThemeData(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
        systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: AutoSizeText(
                  StringRefer.kWorkoutString,
                  style: StyleRefer.kTextStyle.copyWith(color: ColorRefer.kPinkColor, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: Constants.workoutDetailList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return  WorkoutDetailCard(
                        visible: VideoTools.workoutIndex == index ? workouts.week == Constants.userWorkoutPlanData.currentWeek && workouts.day == Constants.userWorkoutPlanData.currentDay ?  true : false : false,
                        burnCal: Constants.workoutDetailList[index].burnCal,
                        rest: Constants.workoutDetailList[index].rest,
                        title: '${Constants.workoutDetailList[index].name} X ${Constants.workoutDetailList[index].repeat == null ? "" : Constants.workoutDetailList[index].repeat } ${Constants.workoutDetailList[index].repeat == null ? "" : 'reps X'} ${Constants.workoutDetailList[index].sets} Sets',
                        icon: 'assets/icons/workout.svg',
                        onPressed: () {
                          int type = checkVideoType(Constants.workoutDetailList[index].link);
                          String id = type == 1 ? getVimeoVideoID(Constants.workoutDetailList[index].link) : type == 2 ? getYoutubeVideoID(Constants.workoutDetailList[index].link) : Constants.workoutDetailList[index].link;
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                insetPadding: EdgeInsets.only(top: 30, left: 0, right: 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                elevation: 0,
                                backgroundColor: Colors.transparent,
                                child: Container(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight:  Radius.circular(10))
                                        ),
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            AutoSizeText('Preview', style: TextStyle(fontSize: 15, color: Colors.black),),
                                            InkWell(
                                              onTap: (){
                                                Navigator.pop(context);
                                              },
                                              child: Icon(Icons.close, color: Colors.black),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight:  Radius.circular(10))
                                        ),
                                        padding: EdgeInsets.only(bottom: 30),
                                        child: type == 1 ? VimeoVideoPlayer(
                                          key: ValueKey(id),
                                          videoEndFunction: (){},
                                          videoID: id,
                                        )  :  type == 2 ? YoutubeVideoPlayer(
                                          key: ValueKey(id),
                                          videoEndFunction: (){},
                                          videoID: id,
                                        ) : UrlVideoPlayer(
                                          width: MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context).size.width / 2,
                                          loaderPadding: EdgeInsets.all(120),
                                          buttonPadding: EdgeInsets.only(
                                            top: 80,
                                            left: MediaQuery.of(context).size.width / 2.1,
                                          ),
                                          url: id,
                                        ),
                                        // child: VimeoVideoPlayer(
                                        //   key: ValueKey(id),
                                        //   videoEndFunction: (){},
                                        //   videoID: id,
                                        // ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 20),
                child: RoundedButton(
                  title: buttonTitle,
                  buttonRadius: 8,
                  colour: isDone  == false?  workouts.week == Constants.userWorkoutPlanData.currentWeek && workouts.day == Constants.userWorkoutPlanData.currentDay ?
                  ColorRefer.kRedColor : ColorRefer.kRedColor.withOpacity(0.4) : ColorRefer.kRedColor.withOpacity(0.4),
                  height: 40,
                  onPressed: () async{
                    if(workouts.week == Constants.userWorkoutPlanData.currentWeek && workouts.day == Constants.userWorkoutPlanData.currentDay){
                      if(isDone == false){
                        await Navigator.pushNamed(context, WorkoutVideoScreen.ID, arguments: [workouts.caloriesBurn, workouts.id]);
                        if(VideoTools.workoutStart == true){
                          changeButtonTitle();
                        }
                        setState(() {});
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WorkoutDetailCard extends StatefulWidget {
  WorkoutDetailCard({this.onPressed, this.title, this.icon, this.visible, this.rest, this.burnCal});
  final String title;
  final String icon;
  final bool visible;
  final int burnCal;
  final int rest;
  final Function onPressed;
  @override
  _WorkoutDetailCardState createState() => _WorkoutDetailCardState();
}

class _WorkoutDetailCardState extends State<WorkoutDetailCard> {

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: widget.onPressed,
            child: Container(
              width: width,
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border(
                  bottom: BorderSide(width: 1, color: theme.lightTheme == true ?  ColorRefer.kDarkGreyColor :  Colors.white),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.only(top: 5),
                          child: SvgPicture.asset(widget.icon),
                      ),
                      SizedBox(width: 12),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              widget.title,
                              style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white, fontWeight: FontWeight.w900, fontSize: 15),
                            ),
                            SizedBox(height: 5),
                            AutoSizeText(
                              '${widget.burnCal == 0 ? '' :'Burn ${widget.burnCal} cal,'} ${widget.rest} sec rest',
                              style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : Colors.white, fontSize: 12),
                            ),
                            Visibility(
                              visible: VideoTools.workoutStart == true ? widget.visible : false,
                              child: Container(
                                padding: EdgeInsets.only(top: 2),
                                child: Text(
                                  'Continue',
                                  style: StyleRefer.kTextStyle.copyWith(color: ColorRefer.kRedColor, fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
