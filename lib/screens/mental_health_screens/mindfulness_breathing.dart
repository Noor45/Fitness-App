import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t_fit/utils/colors.dart';
import 'package:t_fit/utils/fonts.dart';
import 'package:t_fit/utils/style.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';
import 'package:t_fit/widgets/round_button.dart';

class BreathExerciseScreen extends StatefulWidget {
  static const String ID = "/breath_exercise_screen";
  @override
  _BreathExerciseScreenState createState() => _BreathExerciseScreenState();
}
class _BreathExerciseScreenState extends State<BreathExerciseScreen> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  bool inhale = true;
  bool start = false;
  bool exerciseStarted = false;
  bool exercisePause = false;
  bool isCompleted = false;
  int set = 0;

  initiate(){
    controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween<double>(begin: 200, end: 300).animate(controller);
  }

  @override
  void initState() {
    initiate();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
        backgroundColor: theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
        appBar: AppBar(
          elevation: theme.lightTheme == true ? 3 : 0,
          iconTheme: IconThemeData(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
          systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
          centerTitle: true,
          title: Text(
            'Mindfulness Breathing',
            style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 14),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Align(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 20, width: 20),
                Container(
                  height: animation.value,
                  width: animation.value,
                  child: Image.asset('assets/images/lungs.png'),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/2.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: exerciseStarted == true ? false : true,
                        child: Column(
                          children: [
                            Text(
                              isCompleted == false ? 'Breathing Exercise' : 'Congratulations!',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontFamily: FontRefer.OpenSans,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 30),
                              child: Text(
                                isCompleted == false ? 'This Exercise helps you to control your breathing and relax.' : 'You\'ve completed this exercise.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  height: 1.5,
                                  fontFamily: FontRefer.OpenSans,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: exerciseStarted == true ? false : true,
                        child: SubmitButton(
                            title: 'Start',
                            buttonRadius: 20,
                            colour: ColorRefer.kRedColor,
                            width: MediaQuery.of(context).size.width/2.5,
                            height: 40,
                            onPressed: () async {
                              setState(() {
                                set = 0;
                                inhale = true;
                                exercisePause = false;
                                exerciseStarted = true;
                                if(start == false ) {
                                  startExercise();
                                  start = true;
                                } else{
                                  controller.forward();
                                }
                              });
                            }
                        ),
                      ),
                      Visibility(
                        visible: exerciseStarted == true ? true : false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Inhale',
                              style: TextStyle(
                                fontSize: 14,
                                color: inhale == true ? theme.lightTheme == true ? Colors.black : Colors.white : ColorRefer.kTextColor,
                                fontFamily: FontRefer.OpenSans,
                              ),
                            ),
                            SizedBox(width: 20),
                            Text(
                              'Exhale',
                              style: TextStyle(
                                color: inhale == false ? theme.lightTheme == true ? Colors.black : Colors.white : ColorRefer.kTextColor,
                                fontSize: 14,
                                fontFamily: FontRefer.OpenSans,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 50),
                      Visibility(
                        visible: exerciseStarted == true ? true : false,
                        child: Container(
                          margin: EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            children: [
                              Text(
                                set.toString(),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    child: LinearProgressIndicator(
                                        value: (set*0.1),
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                                        backgroundColor: theme.lightTheme == true ? ColorRefer.kLightGreyColor : Colors.grey,
                                        minHeight: 10.0),
                                  ),
                                ),
                              ),
                              Text(10.toString()),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      Visibility(
                        visible: exerciseStarted == true ? true : false,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SubmitButton(
                                  title: exercisePause == true ? 'Play' : 'Pause',
                                  buttonRadius: 20,
                                  colour: exercisePause == true ? Colors.orange : ColorRefer.kRedColor,
                                  width: MediaQuery.of(context).size.width/2.5,
                                  height: 40,
                                  onPressed: () async {
                                    setState(() {
                                      if(exercisePause == true){
                                        exercisePause = false;
                                        controller.forward();
                                        if(set == 10){
                                          set = 0;
                                          exercisePause = true;
                                          exerciseStarted = false;
                                          controller.stop(canceled: false);
                                        }
                                      }else{
                                        exercisePause = true;
                                        controller.stop(canceled: false);
                                      }
                                    });
                                  }
                              ),
                              SizedBox(width: 20),
                              SubmitButton(
                                  title: 'Stop',
                                  buttonRadius: 20,
                                  colour: ColorRefer.kRedColor,
                                  width: MediaQuery.of(context).size.width/2.5,
                                  height: 40,
                                  onPressed: () async {
                                    setState(() {
                                      set = 0;
                                      exercisePause = true;
                                      exerciseStarted = false;
                                      controller.stop(canceled: false);
                                    });
                                  }
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }

  startExercise(){
    animation
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if(set == 10){
            set = 0;
            isCompleted = true;
            exercisePause = false;
            exerciseStarted = false;
            controller.reset();
            controller.stop(canceled: false);
          }else{
            print('Exhale $set');
            controller.reverse();
            inhale = false;
          }
        } else if (status == AnimationStatus.dismissed) {
          print('Inhale $set');
          controller.forward();
          inhale = true;
          set++;
        }
      });
    controller.forward();
  }

}
