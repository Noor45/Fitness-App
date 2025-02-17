import 'dart:async';
import '../utils/constants.dart';
import '../utils/colors.dart';
import 'fullscreen_player.dart';
import 'quality_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VimeoVideoPlayer extends StatefulWidget {
  VimeoVideoPlayer({this.videoID, @required this.videoEndFunction, Key key})
      : super(key: key);
  final Function videoEndFunction;
  final String videoID;
  @override
  _VimeoVideoPlayerState createState() => _VimeoVideoPlayerState();
}

class _VimeoVideoPlayerState extends State<VimeoVideoPlayer> {
  Future<void> initFuture;
  double volume = 1.0;
  VideoPlayerController controller;
  int secs = 0;
  bool call = false;
  bool timer = false;
  bool autoPlay = false;
  bool looping = false;
  bool _overlay = true;
  QualityLinks _quality;
  Map _qualityValues;
  var _qualityValue;
  int position = 0;
  double videoHeight;
  double videoWidth;
  double videoMargin;
  bool _seek = false;
  double doubleTapRMargin = 36;
  double doubleTapRWidth = 400;
  double doubleTapRHeight = 160;
  double doubleTapLMargin = 10;
  double doubleTapLWidth = 400;
  double doubleTapLHeight = 160;
  void initState() {
    if (controller != null) {
      controller.pause();
    }
    VideoTools.videoLoad = false;
    _quality = QualityLinks(widget.videoID);
    _quality.getQualitiesAsync().then((value) {
      if (value != null) {
        _qualityValues = value;
        _qualityValue = value[value.lastKey()];
        controller = VideoPlayerController.network(_qualityValue);
        controller.addListener(videoEnd);
        controller.setLooping(looping);
      }
      if (autoPlay) controller.play();
      initFuture = controller.initialize();
      if (mounted) {
        setState(() {
          SystemChrome.setPreferredOrientations(
              [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
        });
      }
    });
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.initState();
  }

  dismissOverlay() {
    setState(() {
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          _overlay = false;
        });
      });
    });
  }

  void startTimer(int sec) {
    setState(() {
      call = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(Duration(seconds: 1), () {
          if (mounted) {
            setState(() {
              if (sec <= 0) {
                _overlay = false;
                call = false;
                return;
              } else {
                if (controller.value.isPlaying) {
                  sec--;
                  startTimer(sec);
                }
              }
            });
          }
        });
      });
    });
  }

  Future<void> _disposeVideoPlayer() async {
    controller.pause();
    await controller.dispose();
  }

  @override
  void dispose() {
    _disposeVideoPlayer();
    super.dispose();
  }

  videoEnd() {
    if(VideoTools.videoLoad == true){
      if (controller.value.position == controller.value.duration) {
        widget.videoEndFunction.call();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.black,
          child: Column(
            children: [
              GestureDetector(
                child: FutureBuilder(
                    future: initFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        VideoTools.videoLoad = true;
                        double delta = MediaQuery.of(context).size.width -
                            MediaQuery.of(context).size.height *
                                controller.value.aspectRatio;
                        if (MediaQuery.of(context).orientation ==
                                Orientation.portrait ||
                            delta < 0) {
                          videoHeight = MediaQuery.of(context).size.width /
                              controller.value.aspectRatio;
                          videoWidth = MediaQuery.of(context).size.width;
                          videoMargin = 0;
                        } else {
                          videoHeight = MediaQuery.of(context).size.height;
                          videoWidth =
                              videoHeight * controller.value.aspectRatio;
                          videoMargin =
                              (MediaQuery.of(context).size.width - videoWidth) /
                                  2;
                        }
                        if (_seek && controller.value.duration.inSeconds > 2) {
                          controller.seekTo(Duration(seconds: position));
                          _seek = false;
                        }
                        return Stack(
                          children: <Widget>[
                            Container(
                              height: videoHeight,
                              width: videoWidth,
                              margin: EdgeInsets.only(left: videoMargin),
                              child: VideoPlayer(controller),
                            ),
                            _videoOverlay(),
                          ],
                        );
                      } else {
                        return Center(
                            heightFactor: 6,
                            child: CircularProgressIndicator(
                              backgroundColor: ColorRefer.kRedColor,
                              strokeWidth: 4,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.grey),
                            ));
                      }
                    }),
                onTap: () {
                  setState(() {
                    _overlay = !_overlay;
                    if (_overlay) {
                      if (controller.value.isPlaying == true) {
                        if (call == false) {
                          startTimer(3);
                        }
                      } else {
                        call = false;
                      }
                      doubleTapRHeight = videoHeight - 36;
                      doubleTapLHeight = videoHeight - 10;
                      doubleTapRMargin = 36;
                      doubleTapLMargin = 10;
                    } else if (!_overlay) {
                      doubleTapRHeight = videoHeight + 36;
                      doubleTapLHeight = videoHeight + 16;
                      doubleTapRMargin = 0;
                      doubleTapLMargin = 0;
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  //================================ OVERLAY ================================//

  Widget _videoOverlay() {
    return _overlay
        ? Stack(
            children: <Widget>[
              GestureDetector(
                child: Center(
                  child: Container(
                    width: videoWidth,
                    height: videoHeight,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          const Color(0x662F2C47),
                          const Color(0x662F2C47)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: IconButton(
                    padding: EdgeInsets.only(
                        top: videoHeight / 2 - 30,
                        bottom: videoHeight / 2 - 30),
                    icon: controller.value.isPlaying
                        ? Icon(Icons.pause,
                            color: ColorRefer.kRedColor, size: 60.0)
                        : Icon(Icons.play_arrow,
                            color: ColorRefer.kRedColor, size: 60.0),
                    onPressed: () {
                      setState(() {
                        if (VideoTools.videoLoad == true) {
                          if (controller.value.isPlaying) {
                            controller.pause();
                          } else {
                            if (controller.value.position ==
                                controller.value.duration) {
                              controller.seekTo(Duration.zero);
                              controller.play();
                            } else {
                              controller.play();
                            }
                          }
                          if (controller.value.isPlaying == true) {
                            if (call == false) {
                              startTimer(3);
                            }
                          } else {
                            call = false;
                          }
                        }
                      });
                    }),
              ),
              Container(
                margin: EdgeInsets.only(left: videoWidth + videoMargin - 48),
                child: IconButton(
                    icon: Icon(
                      Icons.settings,
                      size: 20.0,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      position = controller.value.position.inSeconds;
                      _seek = true;
                      controller.pause();
                      _settingModalBottomSheet(context);
                      setState(() {});
                    }),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: videoHeight - 26, left: videoMargin),
                child: _videoOverlaySlider(),
              )
            ],
          )
        : Center(
            child: Container(
              height: 5,
              width: videoWidth,
              margin: EdgeInsets.only(top: videoHeight - 5),
              child: VideoProgressIndicator(
                controller,
                allowScrubbing: false,
                colors: VideoProgressColors(
                  playedColor: ColorRefer.kRedColor,
                  backgroundColor: Color(0x5515162B),
                  bufferedColor: Color(0x5583D8F7),
                ),
                padding: EdgeInsets.only(top: 2),
              ),
            ),
          );
  }

  //=================== video overlay Slider ===================//

  Widget _videoOverlaySlider() {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, VideoPlayerValue value, child) {
        if (!value.hasError && value.isInitialized) {
          return Row(
            children: <Widget>[
              Container(
                width: 33,
                alignment: Alignment.centerRight,
                child: Text(
                  value.position.inMinutes.toString() +
                      ':' +
                      (value.position.inSeconds - value.position.inMinutes * 60)
                          .toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 3, right: 3),
                child: Text(
                  '/',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width: 35,
                alignment: Alignment.centerLeft,
                child: Text(
                  value.duration.inMinutes.toString() +
                      ':' +
                      (value.duration.inSeconds - value.duration.inMinutes * 60)
                          .toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                height: 20,
                width: videoWidth - 110,
                child: VideoProgressIndicator(
                  controller,
                  allowScrubbing: false,
                  colors: VideoProgressColors(
                    playedColor: ColorRefer.kRedColor,
                    backgroundColor: Color(0x5515162B),
                    bufferedColor: Color(0x5583D8F7),
                  ),
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                ),
              ),
              Container(
                width: 30,
                child: InkWell(
                    onTap: () async {
                      setState(() {
                        controller.pause();
                      });
                      WidgetsBinding.instance.addPostFrameCallback((_) async {
                        position = await Navigator.push(
                            context,
                            PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (BuildContext context, _, __) =>
                                    FullscreenVimeoPlayer(
                                        id: widget.videoID,
                                        autoPlay: true,
                                        controller: controller,
                                        position:
                                            controller.value.position.inSeconds,
                                        initFuture: initFuture,
                                        qualityValue: _qualityValue),
                                transitionsBuilder: (___,
                                    Animation<double> animation,
                                    ____,
                                    Widget child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: ScaleTransition(
                                        scale: animation, child: child),
                                  );
                                }));
                        setState(() {
                          controller.play();
                          _seek = true;
                        });
                      });
                    },
                    child: Icon(
                      Icons.fullscreen,
                      size: 20.0,
                      color: Colors.white,
                    )),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          final children = <Widget>[];
          _qualityValues.forEach((elem, value) {
            if (elem.toString().contains('240p') == true) {
            } else {
              children.add(
                new ListTile(
                    title: new Text(" ${elem.toString()} fps"),
                    onTap: () => {
                          setState(() {
                            _qualityValue = value;
                            controller =
                                VideoPlayerController.network(_qualityValue);
                            controller.setLooping(true);
                            _seek = true;
                            initFuture = controller.initialize();
                            controller.play();
                            dismissOverlay();
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.pop(context);
                            });
                          }),
                        }),
              );
            }
          });
          return Container(
            child: Wrap(
              children: children,
            ),
          );
        });
  }
}
