import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t_fit/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';

// ignore: must_be_immutable
class CameraGalleryBottomSheet extends StatelessWidget {
  Function cameraClick;
  Function galleryClick;
  CameraGalleryBottomSheet({this.cameraClick, this.galleryClick});
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Container(
      color: theme.lightTheme == true ? Colors.white : ColorRefer.kBoxColor,
      padding: EdgeInsets.only(left: 20, top: 30),
      height: 250,
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
                  size: 30,
                ),
                title: Text(
                  "Camera",
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: Text("Click to Capture image from camera", style: TextStyle(fontSize: 12),),
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
                  FontAwesomeIcons.image,
                  size: 30,
                ),
                title: Text(
                  "Gallery",
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: Text("Click to add picture from camera", style: TextStyle(fontSize: 12),),
              ),
            ),
          ),

        ],
      ),
    );
  }
}