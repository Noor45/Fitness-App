import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_fit/screens/chat_screens/chat_main_screen.dart';
import 'package:t_fit/screens/notification_screens/blog_favorites_blog.dart';
import 'package:t_fit/screens/notification_screens/notification_screen.dart';
import 'package:t_fit/services/theme_model.dart';
import 'package:t_fit/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/utils/style.dart';
import 'package:toast/toast.dart';
import 'package:video_compress/video_compress.dart';
import '../chat_screens/file_send_in_chat.dart';
import '../../screens/main_screens/dashboard_screen.dart';
import '../../screens/main_screens/diet_plan_screen.dart';
import '../../screens/main_screens/profile_screen.dart';
import '../../screens/main_screens/blog_screen.dart';
import '../../widgets/main_bottom_sheet.dart';
import '../../utils/colors.dart';

class MainScreen extends StatefulWidget {
  static const MainScreenId = 'main_screen';
  MainScreen({this.tab});
  final int tab;
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey globalKey = new GlobalKey(debugLabel: 'btm_app_bar');
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;
  bool showSpinner = false;
  File file;
  bool notification = true;
  bool isSwitched = false;
  final picker = ImagePicker();
  List<Widget> tabs = [];
  void pickImage(ImageSource imageSource) async {
    XFile galleryImage = await picker.pickImage(source: imageSource, imageQuality: 15);
    setState(() {
      if (galleryImage != null) {
        file = File(galleryImage.path);
        Navigator.pushNamed(context, FileSendInChatScreen.ID, arguments: [0, file]);
      }
    });
  }

  void pickVideo(ImageSource videoSource) async {
   await picker.pickVideo(source: videoSource).then((value) async{
     if (value != null) {
       file = File(value.path);
       final thumb = await VideoCompress.getFileThumbnail(
           file.path,
           quality: 30,
       );
       Navigator.pushNamed(context, FileSendInChatScreen.ID, arguments: [1, file, thumb.path]);
     }
    });
  }

  @override
  void initState() {
    tabs = [
      DashBoardScreen(),
      DietPlanScreen(),
      BlogScreen(),
      ProfileScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final  theme = Provider.of<DarkThemeProvider>(context);
    print(theme.lightTheme);
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
        appBar: AppBar(
          elevation: theme.lightTheme == true ? 3 : 0,
          systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
          centerTitle: true,
          title: Text(
            selectedIndex == 0 ? 'Dashboard' : selectedIndex == 1 ? 'Weight Loss Plan' :
            selectedIndex == 2 ? 'Blogs' : 'Profile',
            style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 14),
          ),
          leading: Padding(
            padding: EdgeInsets.only(top: 5,  right: 10, left: 10),
            child: IconButton(icon: Icon(theme.lightTheme == true ? Icons.dark_mode : Icons.light_mode), iconSize: 20,
            color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
            onPressed: (){
                  setState(() {
                    if(theme.lightTheme){
                      theme.lightTheme = false; ThemeData.dark();
                      Toast.show("Switching to Dark mode...", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM, backgroundColor: Colors.white, textColor: Colors.black);
                    }
                    else{
                      theme.lightTheme = true; ThemeData.light();
                      Toast.show("Switching to Light mode...", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    }
                  });
                },
            ),
          ),
          actions: [
            Container(
              child: selectedIndex == 0 ? InkWell(
                onTap: (){
                  Navigator.pushNamed(context, NotificationScreen.ID);
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 10, top: 5),
                  alignment: Alignment.center,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Icon(
                        CupertinoIcons.bell_solid,
                        color: theme.lightTheme == true ? ColorRefer.kRedColor : ColorRefer.kLightGreyColor,
                        size: 18,
                      ),
                      Positioned(
                        left: 10,
                        child: ClipRRect(
                          child: new Container(
                            width: 9,
                            height: 9,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.all(1),
                            decoration: new BoxDecoration(
                              color: Constants.notificationVisibility == true ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              border: Border(
                                left: BorderSide(color: Constants.notificationVisibility == true ? theme.lightTheme == true ? Colors.black : Colors.white : Colors.transparent),
                                right: BorderSide(color: Constants.notificationVisibility == true ? theme.lightTheme == true ? Colors.black  : Colors.white : Colors.transparent),
                                bottom: BorderSide(color: Constants.notificationVisibility == true ? theme.lightTheme == true ? Colors.black  : Colors.white : Colors.transparent),
                                top: BorderSide(color: Constants.notificationVisibility == true ? theme.lightTheme == true ? Colors.black  : Colors.white : Colors.transparent),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ) :
              selectedIndex == 1 ? InkWell(
                onTap: (){
                  Navigator.pushNamed(context, ChatMainScreen.ID);
                },
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 15, top: 5),
                  child: Row(
                    children: [
                      Icon(
                        Icons.chat_outlined,
                        color: theme.lightTheme == true ? ColorRefer.kRedColor : ColorRefer.kLightGreyColor,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ) :
              selectedIndex == 2 ?  InkWell(
                onTap: () async{
                  await Navigator.pushNamed(context, BlogFavoritesScreen.ID);
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 15, top: 5),
                  alignment: Alignment.center,
                  child: Icon(
                    CupertinoIcons.bookmark_fill,
                    color: theme.lightTheme == true ? ColorRefer.kRedColor : ColorRefer.kLightGreyColor,
                    size: 18,
                  ),
                ),
              ) : Container(),
            )
          ],
        ),
        body: tabs[selectedIndex],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: theme.lightTheme == true ? Colors.white : ColorRefer.kBottomNavigatorColor,
          child: Icon(
            Icons.add_circle_outline_outlined,
            color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
          ),
          onPressed: () {
            function();
          },
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomAppBar(
            elevation: 10,
            color: theme.lightTheme == true ? Colors.white : ColorRefer.kBottomNavigatorColor,
            shape: CircularNotchedRectangle(),
            notchMargin: 5,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 4),
                      SvgPicture.asset(
                        'assets/icons/dashboard.svg',
                        color: selectedIndex == 0 ? ColorRefer.kRedColor : theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                      ),
                      SizedBox(height: 4),
                      SvgPicture.asset(
                        'assets/icons/dot.svg',
                        color: selectedIndex == 0 ? ColorRefer.kRedColor : Colors.transparent,
                      ),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                ),
                IconButton(
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 4),
                      SvgPicture.asset(
                        'assets/icons/plan.svg',
                        color: selectedIndex == 1 ? ColorRefer.kRedColor : theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                      ),
                      SizedBox(height: 4),
                      SvgPicture.asset(
                        'assets/icons/dot.svg',
                        color: selectedIndex == 1 ? ColorRefer.kRedColor : Colors.transparent,
                      ),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                ),
                SizedBox(width: 15),
                IconButton(
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 4),
                      SvgPicture.asset(
                        'assets/icons/videos.svg',
                        color: selectedIndex == 2 ? ColorRefer.kRedColor : theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                      ),
                      SizedBox(height: 4),
                      SvgPicture.asset(
                        'assets/icons/dot.svg',
                        color: selectedIndex == 2 ? ColorRefer.kRedColor : Colors.transparent,
                      ),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                  },
                ),
                IconButton(
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 4),
                      SvgPicture.asset(
                        'assets/icons/user.svg',
                        color: selectedIndex == 3 ? ColorRefer.kRedColor : theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor,
                      ),
                      SizedBox(height: 4),
                      SvgPicture.asset(
                        'assets/icons/dot.svg',
                        color: selectedIndex == 3 ? ColorRefer.kRedColor : Colors.transparent,
                      ),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      selectedIndex = 3;
                    });
                  },
                ),
              ],
            ),
          ),
        ));
  }

  function() {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          child: Container(
            height: 250,
            child: CameraVideoBottomSheet(
              cameraClick: () => pickImage(ImageSource.camera),
              galleryClick: () => pickVideo(ImageSource.camera),
            ),
          ),
        );
     });
  }
}
