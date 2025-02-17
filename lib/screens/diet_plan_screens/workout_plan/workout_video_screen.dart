import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t_fit/widgets/url_video_player.dart';
import 'package:t_fit/widgets/youtube_player.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/user_plan_controller.dart';
import '../../../functions/global_functions.dart';
import '../../../screens/main_screens/main_screen.dart';
import '../../../utils/colors.dart';
import '../../../widgets/confirm_box.dart';
import '../../../widgets/round_button.dart';
import '../../../utils/constants.dart';
import '../../../widgets/vimeo_player.dart';
import '../../../utils/style.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

class WorkoutVideoScreen extends StatefulWidget {
  static const String ID = 'workout_video_screen';
  @override
  _WorkoutVideoScreenState createState() => _WorkoutVideoScreenState();
}

class _WorkoutVideoScreenState extends State<WorkoutVideoScreen> {
  int type = 0;
  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  @override
  void initState() {
    if(VideoTools.workoutStart == false){
      VideoTools.workoutStart = true;
      initialSetData();
    }
    super.initState();
  }
  initialSetData(){
    setState(() {
      VideoTools.videoShow = true;
      VideoTools.setsButtonDisable = true;
      VideoTools.setsButtonColor = ColorRefer.kRedColor;
      VideoTools.repColor = ColorRefer.kRedColor.withOpacity(0.6);
      VideoTools.restColor = Colors.transparent;
      VideoTools.setButtonTitle = 'Move to next set';
      VideoTools.exerciseButtonTitle = 'Tap to Start Next Exercise';
      VideoTools.exerciseButtonColor = ColorRefer.kRedColor.withOpacity(0.5);
      if(VideoTools.workoutIndex == Constants.workoutDetailList.length-1){
        VideoTools.exerciseButtonDisable = true;
        VideoTools.exerciseButtonTitle = 'Done with the Workout';
      }
      VideoTools.workout = Constants.workoutDetailList[VideoTools.workoutIndex];
      type = checkVideoType(VideoTools.workout.link);
      VideoTools.videoID = type == 1 ? getVimeoVideoID(VideoTools.workout.link) : type == 2 ? getYoutubeVideoID(VideoTools.workout.link) : VideoTools.workout.link;
      VideoTools.duration = VideoTools.workout.rest;
      VideoTools.videoWidget =  type == 1 ? VimeoVideoPlayer(
        key: ValueKey(VideoTools.workoutIndex),
        videoEndFunction:showTimer,
        videoID: VideoTools.videoID,
      )  :  type == 2 ? YoutubeVideoPlayer(
        key: ValueKey(VideoTools.workoutIndex),
        videoEndFunction:showTimer,
        videoID: VideoTools.videoID,
      ) : UrlVideoPlayer(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width / 2,
        loaderPadding: EdgeInsets.all(120),
        buttonPadding: EdgeInsets.only(
          top: 80,
          left: MediaQuery.of(context).size.width / 2.1,
        ),
        url: VideoTools.videoID,
      );
    });
  }

  refresh() {
    setState(() {});
  }

  showTimer(){
    if(VideoTools.setNo < VideoTools.workout.sets){
      setState(() {
        VideoTools.timerShow = true;
        VideoTools.videoShow = false;
        VideoTools.setButtonTitle = 'Skip Rest';
        VideoTools.repColor = Colors.transparent;
        VideoTools.restColor = ColorRefer.kRedColor.withOpacity(0.5);
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          VideoTools.countController.restart(duration: VideoTools.duration);
        });
      });
    }
    if(VideoTools.setNo == VideoTools.workout.sets){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmBox(
            type: 1,
            title: '${VideoTools.workout.name} sets have been Completed',
            subTitle: 'Lets move to another exercise',
            firstButtonTitle: 'Good Job!',
            firstButtonOnPressed: (){
              Navigator.pop(context);
            },
            firstButtonColor: ColorRefer.kRedColor,
            secondButtonOnPressed: (){},
            secondButtonColor: ColorRefer.kSecondBlueColor,
            secondButtonTitle: '',
          );
        },
      );
    }
  }
  showVideo(){
    setState(() {
      VideoTools.timerShow = false;
      VideoTools.videoShow = true;
      VideoTools.restColor = Colors.transparent;
      VideoTools.repColor = ColorRefer.kRedColor.withOpacity(0.5);
      VideoTools.setButtonTitle = 'Move to next set';
      if(VideoTools.setNo < VideoTools.workout.sets)
        VideoTools.setNo++;
      if(VideoTools.setNo == VideoTools.workout.sets){
        VideoTools.setButtonTitle = 'Sets Completed';
        VideoTools.exerciseButtonDisable = true;
        VideoTools.setsButtonDisable = false;
        VideoTools.setsButtonColor = ColorRefer.kRedColor.withOpacity(0.5);
        VideoTools.exerciseButtonColor = ColorRefer.kRedColor;
      }
    });
  }

  @override
  void dispose() {
    VideoTools.timerShow = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    List args = ModalRoute.of(context).settings.arguments;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:  theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
      appBar: AppBar(
        elevation: theme.lightTheme == true ? 3 : 0,
        iconTheme: IconThemeData(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
        centerTitle: true,
        title: Text(
          '${Constants.workoutPlanDetail.planName}',
          style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 15),
        ),
        systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Center(
                      child: AutoSizeText(
                          '${VideoTools.workout.name} ${VideoTools.workout.repeat == null ? '' : 'x ${VideoTools.workout.repeat}'}',
                          textAlign: TextAlign.center, style: StyleRefer.kTextStyle.copyWith(fontSize: 15)),
                    ),
                    SizedBox(height: 5),
                    Center(
                      child: AutoSizeText(
                          'Burn ${args[0]} cal',
                          textAlign: TextAlign.center, style: StyleRefer.kTextStyle.copyWith(fontSize: 15, color: ColorRefer.kSecondBlueColor)),
                    ),
                    SizedBox(height: 15),
                    Visibility(
                      visible: VideoTools.videoShow,
                      child: Container(
                        child: VideoTools.videoWidget,
                      ),
                    ),
                    Visibility(
                      visible: VideoTools.timerShow,
                      child: Container(
                        child: CustomizeCounter(
                          duration: VideoTools.duration,
                          onStart: (){},
                          onComplete: showVideo,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                              'Workout details',
                              textAlign: TextAlign.center, style: StyleRefer.kTextStyle.copyWith(fontSize: 13)),
                          SizedBox(height: 5),
                          AutoSizeText(
                              '${VideoTools.setNo} of ${VideoTools.workout.sets} Sets',
                              textAlign: TextAlign.center, style: StyleRefer.kTextStyle.copyWith(fontSize: 13, color: ColorRefer.kRedColor)),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: width,
                      margin: EdgeInsets.only(left: 15, right: 15),
                      decoration: BoxDecoration(
                        color: theme.lightTheme == true ?  ColorRefer.kGreyColor :  Color(0xffA2A2A2),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RoundTile(
                            title: VideoTools.workout.name,
                            indicatorColor: VideoTools.repColor,
                            value: VideoTools.workout.repeat,
                            description: VideoTools.workout.des,
                            subtitle: '${VideoTools.workout.repeat.toString()} reps',
                            topMargin: 15,
                          ),
                          RoundTile(
                            title: 'Rest',
                            indicatorColor: VideoTools.restColor,
                            value: VideoTools.workout.rest,
                            subtitle: '${VideoTools.workout.rest} sec',
                            bottomMargin: 15,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25, right: 25, top: 25),
                      child: RoundedButton(
                        title: VideoTools.setButtonTitle,
                        buttonRadius: 8,
                        colour: VideoTools.setsButtonColor,
                        height: 40,
                        onPressed: (){
                          if(VideoTools.videoLoad == true){
                            if(VideoTools.timerShow == false){
                              showTimer();
                              return;
                            }
                            if(VideoTools.timerShow == true){
                              showVideo();
                              return;
                            }
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 20),
                      child: RoundedButton(
                        title: VideoTools.exerciseButtonTitle,
                        buttonRadius: 8,
                        colour: VideoTools.exerciseButtonColor,
                        height: 40,
                        onPressed:  () async{
                          if(VideoTools.videoLoad == true){
                            setState(() {
                              if(VideoTools.exerciseButtonDisable == true ){
                                if(VideoTools.workoutIndex < Constants.workoutDetailList.length-1){
                                  VideoTools.workoutIndex++;
                                  VideoTools.setNo = 1;
                                  initialSetData();
                                  refresh();
                                }
                                else{
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ConfirmBox(
                                        type: 1,
                                        title: 'Workout Completed',
                                        subTitle: 'Feeling better!',
                                        firstButtonTitle: 'Good Job! View Insights',
                                        firstButtonColor: ColorRefer.kRedColor,
                                        secondButtonOnPressed: (){},
                                        secondButtonColor: ColorRefer.kSecondBlueColor,
                                        secondButtonTitle: '',
                                        calories: args[0],
                                        complete: true,
                                        firstButtonOnPressed: (){
                                          Constants.userWorkoutData.forEach((element) {
                                            if(element.day == Constants.userWorkoutPlanData.currentDay && element.week == Constants.userWorkoutPlanData.currentWeek){
                                              element.workout = true;
                                              element.caloriesBurn = args[0];
                                            }
                                          });
                                          DietPlanController.saveWorkoutData();
                                          AuthController().updateUserFields();
                                          clear();
                                          Navigator.pushNamedAndRemoveUntil(context, MainScreen.MainScreenId, (route) => false);
                                        },
                                      );
                                    },
                                  );
                                  refresh();
                                }
                              }
                            });
                            setState(() {});
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  clear(){
    setState(() {
      VideoTools.setNo = 1;
      VideoTools.videoShow = false;
      VideoTools.timerShow = false;
      VideoTools.workoutStart = false;
      VideoTools.workoutIndex = 0;
      VideoTools.duration = 10;
      VideoTools.videoID = '';
      VideoTools.setsButtonDisable = false;
      VideoTools.exerciseButtonDisable = false;
      VideoTools.setButtonTitle = '';
      VideoTools.exerciseButtonTitle = '';
    });
  }

}

class RoundTile extends StatelessWidget {
  RoundTile({this.subtitle, this.title, this.value, this.indicatorColor, this.bottomMargin = 0, this.topMargin = 0, this.description = ''});
  final String title;
  final String  subtitle;
  final String  description;
  final int  value;
  final double  bottomMargin;
  final double  topMargin;
  final Color indicatorColor;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      margin: EdgeInsets.only(bottom: bottomMargin, top: topMargin),
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: indicatorColor,
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.white),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: value == null ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                title,
                style: StyleRefer.kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Visibility(
                visible: value == null ? false : true,
                child: AutoSizeText(
                  subtitle,
                  style: StyleRefer.kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ],
          ),
          Visibility(
            visible: description.isEmpty ?  false:true ,
            child: Padding(
              padding: EdgeInsets.only(top: 3),
              child: AutoSizeText(
                description,
                style: StyleRefer.kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class CustomizeCounter extends StatelessWidget {
  CustomizeCounter({this.duration, this.onComplete, this.onStart});
  final int duration;
  final Function onStart;
  final Function onComplete;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Container(
      alignment: Alignment.center,
      child: CircularCountDownTimer(
        duration: duration,
        initialDuration: duration,
        controller: VideoTools.countController,
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 3.5,
        ringColor: theme.lightTheme == true ?  ColorRefer.kGreyColor : Color(0xffA2A2A2),
        fillColor: ColorRefer.kRedColor,
        backgroundColor: Colors.transparent,
        strokeWidth: 15.0,
        strokeCap: StrokeCap.butt,
        textStyle: TextStyle(fontSize: 33.0, color: theme.lightTheme == true ?  ColorRefer.kGreyColor : Colors.white, fontWeight: FontWeight.bold),
        textFormat: CountdownTextFormat.S,
        isReverse: true,
        isReverseAnimation: true,
        isTimerTextShown: true,
        autoStart: false,
        onStart: onStart,
        onComplete: onComplete,
      ),
    );
  }
}
