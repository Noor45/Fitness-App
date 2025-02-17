import 'dart:async';
import 'package:t_fit/utils/colors.dart';
import 'package:t_fit/widgets/fullscreen_player.dart';

import '../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayer extends StatefulWidget {
  YoutubeVideoPlayer({this.videoID, @required this.videoEndFunction, Key key})
      : super(key: key);
  final Function videoEndFunction;
  final String videoID;
  @override
  _YoutubeVideoPlayerState createState() => _YoutubeVideoPlayerState();
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
  YoutubePlayerController  controller;
  void initState() {
    super.initState();
    if (controller != null) {
      controller.pause();
    }
    VideoTools.videoLoad = false;
    controller = YoutubePlayerController(
      initialVideoId: widget.videoID,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    );

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);

  }

  Future<void> _disposeVideoPlayer() async {
    controller.pause();
    controller.dispose();
  }

  @override
  void dispose() {
    _disposeVideoPlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.black,
          child:  YoutubePlayer(
            controller: controller,
            showVideoProgressIndicator: true,
            bufferIndicator: CircularProgressIndicator(color: ColorRefer.kRedColor),
            progressIndicatorColor: ColorRefer.kRedColor,
            progressColors: ProgressBarColors(playedColor: ColorRefer.kRedColor, ),
            onReady: () {
              setState(() {
                VideoTools.videoLoad = true;
              });
            },
            onEnded: (data) {
              widget.videoEndFunction.call();
            },
          ),
        ),
      ],
    );
  }


  //================================ OVERLAY ================================//

  // Widget _videoOverlay() {
  //   return _overlay
  //       ? Stack(
  //     children: <Widget>[
  //       GestureDetector(
  //         child: Center(
  //           child: Container(
  //             width: videoWidth,
  //             height: videoHeight,
  //             decoration: BoxDecoration(
  //               gradient: LinearGradient(
  //                 begin: Alignment.centerRight,
  //                 end: Alignment.centerLeft,
  //                 colors: [
  //                   const Color(0x662F2C47),
  //                   const Color(0x662F2C47)
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //       Center(
  //         child: IconButton(
  //             padding: EdgeInsets.only(
  //                 top: videoHeight / 2 - 30,
  //                 bottom: videoHeight / 2 - 30),
  //             icon: controller.value.isPlaying
  //                 ? Icon(Icons.pause,
  //                 color: ColorRefer.kRedColor, size: 60.0)
  //                 : Icon(Icons.play_arrow,
  //                 color: ColorRefer.kRedColor, size: 60.0),
  //             onPressed: () {
  //               setState(() {
  //                 if (VideoTools.videoLoad == true) {
  //                   if (controller.value.isPlaying) {
  //                     controller.pause();
  //                   } else {
  //                     if (controller.value.position ==
  //                         controller.metadata.duration) {
  //                       controller.seekTo(Duration.zero);
  //                       controller.play();
  //                     } else {
  //                       controller.play();
  //                     }
  //                   }
  //                   if (controller.value.isPlaying == true) {
  //                     if (call == false) {
  //                       startTimer(3);
  //                     }
  //                   } else {
  //                     call = false;
  //                   }
  //                 }
  //               });
  //             }),
  //       ),
  //       Container(
  //         margin: EdgeInsets.only(left: videoWidth + videoMargin - 48),
  //         child: IconButton(
  //             icon: Icon(
  //               Icons.settings,
  //               size: 20.0,
  //               color: Colors.white,
  //             ),
  //             onPressed: () {
  //               position = controller.value.position.inSeconds;
  //               _seek = true;
  //               controller.pause();
  //               _settingModalBottomSheet(context);
  //               setState(() {});
  //             }),
  //       ),
  //       Container(
  //         margin:
  //         EdgeInsets.only(top: videoHeight - 26, left: videoMargin),
  //         child: _videoOverlaySlider(),
  //       )
  //     ],
  //   )
  //       : Center(
  //     child: Container(
  //       height: 5,
  //       width: videoWidth,
  //       margin: EdgeInsets.only(top: videoHeight - 5),
  //       child: VideoProgressIndicator(
  //         controller,
  //         allowScrubbing: false,
  //         colors: VideoProgressColors(
  //           playedColor: ColorRefer.kRedColor,
  //           backgroundColor: Color(0x5515162B),
  //           bufferedColor: Color(0x5583D8F7),
  //         ),
  //         padding: EdgeInsets.only(top: 2),
  //       ),
  //     ),
  //   );
  // }

  //=================== video overlay Slider ===================//

  // Widget _videoOverlaySlider() {
  //   return Container();
  //   // return ValueListenableBuilder(
  //   //   valueListenable: controller,
  //   //   builder: (context, VideoPlayerValue value, child) {
  //   //     if (!value.hasError && value.isInitialized) {
  //   //       return Row(
  //   //         children: <Widget>[
  //   //           Container(
  //   //             width: 33,
  //   //             alignment: Alignment.centerRight,
  //   //             child: Text(
  //   //               value.position.inMinutes.toString() +
  //   //                   ':' +
  //   //                   (value.position.inSeconds - value.position.inMinutes * 60)
  //   //                       .toString(),
  //   //               style: TextStyle(
  //   //                 fontSize: 12,
  //   //                 color: Colors.white,
  //   //               ),
  //   //             ),
  //   //           ),
  //   //           Container(
  //   //             padding: EdgeInsets.only(left: 3, right: 3),
  //   //             child: Text(
  //   //               '/',
  //   //               style: TextStyle(
  //   //                 fontSize: 12,
  //   //                 color: Colors.white,
  //   //               ),
  //   //             ),
  //   //           ),
  //   //           Container(
  //   //             width: 35,
  //   //             alignment: Alignment.centerLeft,
  //   //             child: Text(
  //   //               value.duration.inMinutes.toString() +
  //   //                   ':' +
  //   //                   (value.duration.inSeconds - value.duration.inMinutes * 60)
  //   //                       .toString(),
  //   //               style: TextStyle(
  //   //                 fontSize: 12,
  //   //                 color: Colors.white,
  //   //               ),
  //   //             ),
  //   //           ),
  //   //           Container(
  //   //             height: 20,
  //   //             width: videoWidth - 110,
  //   //             child: VideoProgressIndicator(
  //   //               controller,
  //   //               allowScrubbing: false,
  //   //               colors: VideoProgressColors(
  //   //                 playedColor: ColorRefer.kRedColor,
  //   //                 backgroundColor: Color(0x5515162B),
  //   //                 bufferedColor: Color(0x5583D8F7),
  //   //               ),
  //   //               padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
  //   //             ),
  //   //           ),
  //   //           Container(
  //   //             width: 30,
  //   //             child: InkWell(
  //   //                 onTap: () async {
  //   //                   setState(() {
  //   //                     controller.pause();
  //   //                   });
  //   //                   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //   //                     position = await Navigator.push(
  //   //                         context,
  //   //                         PageRouteBuilder(
  //   //                             opaque: false,
  //   //                             pageBuilder: (BuildContext context, _, __) =>
  //   //                                 FullscreenVimeoPlayer(
  //   //                                     id: widget.videoID,
  //   //                                     autoPlay: true,
  //   //                                     controller: controller,
  //   //                                     position:
  //   //                                     controller.value.position.inSeconds,
  //   //                                     initFuture: initFuture,
  //   //                                     qualityValue: _qualityValue),
  //   //                             transitionsBuilder: (___,
  //   //                                 Animation<double> animation,
  //   //                                 ____,
  //   //                                 Widget child) {
  //   //                               return FadeTransition(
  //   //                                 opacity: animation,
  //   //                                 child: ScaleTransition(
  //   //                                     scale: animation, child: child),
  //   //                               );
  //   //                             }));
  //   //                     setState(() {
  //   //                       controller.play();
  //   //                       _seek = true;
  //   //                     });
  //   //                   });
  //   //                 },
  //   //                 child: Icon(
  //   //                   Icons.fullscreen,
  //   //                   size: 20.0,
  //   //                   color: Colors.white,
  //   //                 )),
  //   //           ),
  //   //         ],
  //   //       );
  //   //     } else {
  //   //       return Container();
  //   //     }
  //   //   },
  //   // );
  // }

  // void _settingModalBottomSheet(context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         final children = <Widget>[];
  //         _qualityValues.forEach((elem, value) {
  //           if (elem.toString().contains('240p') == true) {
  //           } else {
  //             children.add(
  //               new ListTile(
  //                   title: new Text(" ${elem.toString()} fps"),
  //                   onTap: () => {
  //                     setState(() {
  //                       _qualityValue = value;
  //                       // controller =
  //                       //     VideoPlayerController.network(_qualityValue);
  //                       // controller.setLooping(true);
  //                       _seek = true;
  //                       controller.play();
  //                       dismissOverlay();
  //                       WidgetsBinding.instance.addPostFrameCallback((_) {
  //                         Navigator.pop(context);
  //                       });
  //                     }),
  //                   }),
  //             );
  //           }
  //         });
  //         return Container(
  //           child: Wrap(
  //             children: children,
  //           ),
  //         );
  //       });
  // }
}


