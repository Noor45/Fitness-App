import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t_fit/utils/colors.dart';
import '../utils/fonts.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

// ignore: must_be_immutable
class CameraVideoBottomSheet extends StatelessWidget {
  Function cameraClick;
  Function galleryClick;
  CameraVideoBottomSheet({this.cameraClick, this.galleryClick});
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        color: theme.lightTheme == true ?  Colors.white : ColorRefer.kBoxColor,
        padding: EdgeInsets.only(left: 20, top: 30),
        child: Column(
          children: <Widget>[
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: (){
                  cameraClick.call();
                  Navigator.pop(context);
                },
                child: ListTile(
                  leading: Icon(
                    FontAwesomeIcons.camera,
                    size: 25,
                  ),
                  title: Text(
                    "Camera",
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.5,
                      fontFamily: FontRefer.SansSerif,
                    ),
                  ),
                  subtitle: Text(
                      "Click to capture image from Camera",
                    style: TextStyle(
                        fontSize: 12,
                        height: 1.5,
                        fontFamily: FontRefer.SansSerif,
                    ),
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: (){
                  galleryClick.call();
                  Navigator.pop(context);
                },
                child: ListTile(
                  leading: Icon(
                    FontAwesomeIcons.video,
                    size: 25,
                  ),
                  title: Text(
                    "Video",
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.5,
                      fontFamily: FontRefer.SansSerif,
                    ),
                  ),
                  subtitle: Text("Click to take video from Camera",
                    style: TextStyle(fontSize: 12, height: 1.5, fontFamily: FontRefer.SansSerif),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}