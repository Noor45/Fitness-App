library vimeoplayer;

import 'package:flutter/material.dart';
import 'package:t_fit/utils/colors.dart';
import 'package:t_fit/utils/constants.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'quality_links.dart';
import 'dart:async';

class FullscreenVimeoPlayer extends StatefulWidget {
  final String id;
  final bool autoPlay;
  final bool looping;
  final VideoPlayerController controller;
  final position;
  final Future<void> initFuture;
  final String qualityValue;
  final Function endFunction;

  FullscreenVimeoPlayer({
    @required this.id,
    this.autoPlay,
    this.looping,
    this.controller,
    this.position,
    this.initFuture,
    this.endFunction,
    this.qualityValue,
    Key key,
  }) : super(key: key);

  @override
  _FullscreenVimeoPlayerState createState() => _FullscreenVimeoPlayerState(
      id, autoPlay, looping, controller, position, initFuture, qualityValue);
}

class _FullscreenVimeoPlayerState extends State<FullscreenVimeoPlayer> {
  String _id;
  bool autoPlay = false;
  bool looping = false;
  bool _overlay = true;
  bool fullScreen = true;

  VideoPlayerController controller;
  VideoPlayerController _controller;
  int position;
  Future<void> initFuture;
  var qualityValue;

  _FullscreenVimeoPlayerState(this._id, this.autoPlay, this.looping,
      this.controller, this.position, this.initFuture, this.qualityValue);

  QualityLinks _quality;
  Map _qualityValues;

  bool _seek = true;

  double videoHeight;
  double videoWidth;
  double videoMargin;

  double doubleTapRMarginFS = 36;
  double doubleTapRWidthFS = 700;
  double doubleTapRHeightFS = 300;
  double doubleTapLMarginFS = 10;
  double doubleTapLWidthFS = 700;
  double doubleTapLHeightFS = 400;

  @override
  void initState() {
    _controller = controller;
    if (autoPlay) _controller.play();

    _quality = QualityLinks(_id);
    _quality.getQualitiesSync().then((value) {
      _qualityValues = value;
    });

    setState(() {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
    });

    super.initState();
  }

  Future<bool> _onWillPop() {
    setState(() {
      _controller.pause();
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
      SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    });
    Navigator.pop(context, _controller.value.position.inSeconds);
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            body: Center(
                child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            GestureDetector(
              child: FutureBuilder(
                  future: initFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      double delta = MediaQuery.of(context).size.width -
                          MediaQuery.of(context).size.height *
                              _controller.value.aspectRatio;
                      if (MediaQuery.of(context).orientation ==
                              Orientation.portrait ||
                          delta < 0) {
                        videoHeight = MediaQuery.of(context).size.width /
                            _controller.value.aspectRatio;
                        videoWidth = MediaQuery.of(context).size.width;
                        videoMargin = 0;
                      } else {
                        videoHeight = MediaQuery.of(context).size.height;
                        videoWidth =
                            videoHeight * _controller.value.aspectRatio;
                        videoMargin =
                            (MediaQuery.of(context).size.width - videoWidth) /
                                2;
                      }
                      doubleTapRWidthFS = videoWidth;
                      doubleTapRHeightFS = videoHeight - 36;
                      doubleTapLWidthFS = videoWidth;
                      doubleTapLHeightFS = videoHeight;

                      if (_seek && fullScreen) {
                        _controller.seekTo(Duration(seconds: position));
                        _seek = false;
                      }

                      if (_seek && _controller.value.duration.inSeconds > 2) {
                        _controller.seekTo(Duration(seconds: position));
                        _seek = false;
                      }
                      SystemChrome.setEnabledSystemUIMode(
                          SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
                      return Stack(
                        children: <Widget>[
                          Container(
                            height: videoHeight,
                            width: videoWidth,
                            margin: EdgeInsets.only(left: videoMargin),
                            child: VideoPlayer(_controller),
                          ),
                          _videoOverlay(),
                        ],
                      );
                    } else {
                      return Center(
                          heightFactor: 6,
                          child: CircularProgressIndicator(
                            strokeWidth: 4,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF22A3D2)),
                          ));
                    }
                  }),
              onTap: () {
                setState(() {
                  _overlay = !_overlay;
                  if (_overlay) {
                    doubleTapRHeightFS = videoHeight - 36;
                    doubleTapLHeightFS = videoHeight - 10;
                    doubleTapRMarginFS = 36;
                    doubleTapLMarginFS = 10;
                  } else if (!_overlay) {
                    doubleTapRHeightFS = videoHeight + 36;
                    doubleTapLHeightFS = videoHeight;
                    doubleTapRMarginFS = 0;
                    doubleTapLMarginFS = 0;
                  }
                });
              },
            ),
            GestureDetector(
                child: Container(
                  width: doubleTapLWidthFS / 2 - 30,
                  height: doubleTapLHeightFS - 44,
                  margin:
                      EdgeInsets.fromLTRB(0, 0, doubleTapLWidthFS / 2 + 30, 40),
                ),
                onTap: () {
                  setState(() {
                    _overlay = !_overlay;
                    if (_overlay) {
                      doubleTapRHeightFS = videoHeight - 36;
                      doubleTapLHeightFS = videoHeight - 10;
                      doubleTapRMarginFS = 36;
                      doubleTapLMarginFS = 10;
                    } else if (!_overlay) {
                      doubleTapRHeightFS = videoHeight + 36;
                      doubleTapLHeightFS = videoHeight;
                      doubleTapRMarginFS = 0;
                      doubleTapLMarginFS = 0;
                    }
                  });
                },
                onDoubleTap: () {
                  setState(() {
                    _controller.seekTo(Duration(
                        seconds: _controller.value.position.inSeconds - 10));
                  });
                }),
            GestureDetector(
                child: Container(
                  width: doubleTapRWidthFS / 2 - 45,
                  height: doubleTapRHeightFS - 80,
                  margin: EdgeInsets.fromLTRB(doubleTapRWidthFS / 2 + 45, 0, 0,
                      doubleTapLMarginFS + 20),
                ),
                onTap: () {
                  setState(() {
                    _overlay = !_overlay;
                    if (_overlay) {
                      doubleTapRHeightFS = videoHeight - 36;
                      doubleTapLHeightFS = videoHeight - 10;
                      doubleTapRMarginFS = 36;
                      doubleTapLMarginFS = 10;
                    } else if (!_overlay) {
                      doubleTapRHeightFS = videoHeight + 36;
                      doubleTapLHeightFS = videoHeight;
                      doubleTapRMarginFS = 0;
                      doubleTapLMarginFS = 0;
                    }
                  });
                },
                onDoubleTap: () {
                  setState(() {
                    _controller.seekTo(Duration(
                        seconds: _controller.value.position.inSeconds + 10));
                  });
                }),
          ],
        ))));
  }

  //================================ Quality ================================//
  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          final children = <Widget>[];
          _qualityValues.forEach((elem, value) => (children.add(new ListTile(
              title: new Text(" ${elem.toString()} fps"),
              onTap: () => {
                    setState(() {
                      _controller.pause();
                      _controller = VideoPlayerController.network(value);
                      _controller.setLooping(true);
                      _seek = true;
                      initFuture = _controller.initialize();
                      _controller.play();
                    }),
                  }))));

          return Container(
            height: videoHeight,
            child: ListView(
              children: children,
            ),
          );
        });
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
                      top: videoHeight / 2 - 50,
                      bottom: videoHeight / 2 - 30,
                    ),
                    icon: _controller.value.isPlaying
                        ? Icon(Icons.pause, size: 60.0)
                        : Icon(Icons.play_arrow, size: 60.0),
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    }),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: videoHeight - 80, left: videoWidth + videoMargin - 50),
                child: IconButton(
                    alignment: AlignmentDirectional.center,
                    icon: Icon(Icons.fullscreen_exit_sharp, size: 30.0),
                    onPressed: () {
                      setState(() {
                        _controller.pause();
                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.portraitDown,
                          DeviceOrientation.portraitUp
                        ]);
                        SystemChrome.setEnabledSystemUIMode(
                            SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
                      });
                      Navigator.pop(
                          context, _controller.value.position.inSeconds);
                    }),
              ),
              Container(
                margin: EdgeInsets.only(left: videoWidth + videoMargin - 48),
                child: IconButton(
                    icon: Icon(Icons.settings, size: 26.0),
                    onPressed: () {
                      position = _controller.value.position.inSeconds;
                      _seek = true;
                      _settingModalBottomSheet(context);
                      setState(() {});
                    }),
              ),
              Container(
                //===== Ползунок =====//
                margin: EdgeInsets.only(
                    top: videoHeight - 40, left: videoMargin), //CHECK IT
                child: _videoOverlaySlider(),
              )
            ],
          )
        : Center();
  }

  //=================== ПОЛЗУНОК ===================//
  Widget _videoOverlaySlider() {
    return ValueListenableBuilder(
      valueListenable: _controller,
      builder: (context, VideoPlayerValue value, child) {
        if (!value.hasError && value.isInitialized) {
          return Row(
            children: <Widget>[
              Container(
                width: 46,
                alignment: Alignment(0, 0),
                child: Text(value.position.inMinutes.toString() +
                    ':' +
                    (value.position.inSeconds - value.position.inMinutes * 60)
                        .toString()),
              ),
              Container(
                height: 20,
                width: videoWidth - 92,
                child: VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    playedColor: Color(0xFF22A3D2),
                    backgroundColor: Color(0x5515162B),
                    bufferedColor: Color(0x5583D8F7),
                  ),
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                ),
              ),
              Container(
                width: 46,
                alignment: Alignment(0, 0),
                child: Text(value.duration.inMinutes.toString() +
                    ':' +
                    (value.duration.inSeconds - value.duration.inMinutes * 60)
                        .toString()),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class FullscreenSimplePlayer extends StatefulWidget {
  final bool looping;
  final VideoPlayerController controller;
  final bool autoPlay;
  final position;
  final Future<void> initFuture;

  FullscreenSimplePlayer({
    this.autoPlay,
    this.looping,
    this.controller,
    this.position,
    this.initFuture,
    Key key,
  }) : super(key: key);

  @override
  _FullscreenSimplePlayerState createState() => _FullscreenSimplePlayerState(
      autoPlay, looping, controller, position, initFuture);
}

class _FullscreenSimplePlayerState extends State<FullscreenSimplePlayer> {
  int position;
  bool autoPlay = false;
  bool looping = false;
  bool _overlay = true;
  bool fullScreen = true;
  VideoPlayerController controller;
  VideoPlayerController _controller;
  Future<void> initFuture;
  _FullscreenSimplePlayerState(this.autoPlay, this.looping, this.controller,
      this.position, this.initFuture);
  bool _seek = true;
  double videoHeight;
  double videoWidth;
  double videoMargin;
  double doubleTapRMarginFS = 36;
  double doubleTapRWidthFS = 700;
  double doubleTapRHeightFS = 300;
  double doubleTapLMarginFS = 10;
  double doubleTapLWidthFS = 700;
  double doubleTapLHeightFS = 400;

  @override
  void initState() {
    _controller = controller;
    _controller.addListener(() {
      try {
        setState(() {
          if (_controller.value.position == _controller.value.duration) {
            _overlay = true;
          }
        });
      } catch (e) {
        print(e);
      }
    });
    setState(() {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
    });
    super.initState();
  }

  Future<bool> _onWillPop() {
    setState(() {
      _controller.pause();
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
      SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    });
    Navigator.pop(context, _controller.value.position.inSeconds);
    return Future.value(true);
  }

  @override
  void dispose() {
    super.dispose();
    Constants.fullScreen = false;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            body: Center(
                child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            GestureDetector(
              child: FutureBuilder(
                  future: initFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      double delta = MediaQuery.of(context).size.width -
                          MediaQuery.of(context).size.height *
                              _controller.value.aspectRatio;
                      if (MediaQuery.of(context).orientation ==
                              Orientation.portrait ||
                          delta < 0) {
                        videoHeight = MediaQuery.of(context).size.width /
                            _controller.value.aspectRatio;
                        videoWidth = MediaQuery.of(context).size.width;
                        videoMargin = 0;
                      } else {
                        videoHeight = MediaQuery.of(context).size.height;
                        videoWidth =
                            videoHeight * _controller.value.aspectRatio;
                        videoMargin =
                            (MediaQuery.of(context).size.width - videoWidth) /
                                2;
                      }
                      doubleTapRWidthFS = videoWidth;
                      doubleTapRHeightFS = videoHeight - 36;
                      doubleTapLWidthFS = videoWidth;
                      doubleTapLHeightFS = videoHeight;

                      if (_seek && fullScreen) {
                        _controller.seekTo(Duration(seconds: position));
                        _seek = false;
                      }

                      if (_seek && _controller.value.duration.inSeconds > 2) {
                        _controller.seekTo(Duration(seconds: position));
                        _seek = false;
                      }
                      SystemChrome.setEnabledSystemUIMode(
                          SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
                      return Stack(
                        children: <Widget>[
                          Container(
                            height: videoHeight,
                            width: videoWidth,
                            margin: EdgeInsets.only(left: videoMargin),
                            child: VideoPlayer(_controller),
                          ),
                          _videoOverlay(),
                        ],
                      );
                    } else {
                      return Center(
                          heightFactor: 6,
                          child: CircularProgressIndicator(
                            strokeWidth: 4,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF22A3D2)),
                          ));
                    }
                  }),
              onTap: () {
                setState(() {
                  _overlay = !_overlay;
                  if (_overlay) {
                    doubleTapRHeightFS = videoHeight - 36;
                    doubleTapLHeightFS = videoHeight - 10;
                    doubleTapRMarginFS = 36;
                    doubleTapLMarginFS = 10;
                  } else if (!_overlay) {
                    doubleTapRHeightFS = videoHeight + 36;
                    doubleTapLHeightFS = videoHeight;
                    doubleTapRMarginFS = 0;
                    doubleTapLMarginFS = 0;
                  }
                });
              },
            ),
            GestureDetector(
                child: Container(
                  width: doubleTapLWidthFS / 2 - 30,
                  height: doubleTapLHeightFS - 44,
                  margin:
                      EdgeInsets.fromLTRB(0, 0, doubleTapLWidthFS / 2 + 30, 40),
                ),
                onTap: () {
                  setState(() {
                    _overlay = !_overlay;
                    if (_overlay) {
                      doubleTapRHeightFS = videoHeight - 36;
                      doubleTapLHeightFS = videoHeight - 10;
                      doubleTapRMarginFS = 36;
                      doubleTapLMarginFS = 10;
                    } else if (!_overlay) {
                      doubleTapRHeightFS = videoHeight + 36;
                      doubleTapLHeightFS = videoHeight;
                      doubleTapRMarginFS = 0;
                      doubleTapLMarginFS = 0;
                    }
                  });
                },
                onDoubleTap: () {
                  setState(() {
                    _controller.seekTo(Duration(
                        seconds: _controller.value.position.inSeconds - 10));
                  });
                }),
            GestureDetector(
                child: Container(
                  width: doubleTapRWidthFS / 2 - 45,
                  height: doubleTapRHeightFS - 80,
                  margin: EdgeInsets.fromLTRB(doubleTapRWidthFS / 2 + 45, 0, 0,
                      doubleTapLMarginFS + 20),
                ),
                onTap: () {
                  setState(() {
                    _overlay = !_overlay;
                    if (_overlay) {
                      doubleTapRHeightFS = videoHeight - 36;
                      doubleTapLHeightFS = videoHeight - 10;
                      doubleTapRMarginFS = 36;
                      doubleTapLMarginFS = 10;
                    } else if (!_overlay) {
                      doubleTapRHeightFS = videoHeight + 36;
                      doubleTapLHeightFS = videoHeight;
                      doubleTapRMarginFS = 0;
                      doubleTapLMarginFS = 0;
                    }
                  });
                },
                onDoubleTap: () {
                  setState(() {
                    _controller.seekTo(Duration(
                        seconds: _controller.value.position.inSeconds + 10));
                  });
                }),
          ],
        ))));
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
                      top: videoHeight / 2 - 50,
                      bottom: videoHeight / 2 - 30,
                    ),
                    icon: _controller.value.isPlaying
                        ? Icon(Icons.pause, size: 60.0)
                        : Icon(Icons.play_arrow, size: 60.0),
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    }),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: videoHeight - 80, left: videoWidth + videoMargin - 50),
                child: IconButton(
                    alignment: AlignmentDirectional.center,
                    icon: Icon(Icons.fullscreen_exit_sharp, size: 30.0),
                    onPressed: () {
                      setState(() {
                        _controller.pause();
                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.portraitDown,
                          DeviceOrientation.portraitUp
                        ]);
                        SystemChrome.setEnabledSystemUIMode(
                            SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
                      });
                      Navigator.pop(
                          context, _controller.value.position.inSeconds);
                    }),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: videoHeight - 40, left: videoMargin),
                child: _videoOverlaySlider(),
              )
            ],
          )
        : Center();
  }

  Widget _videoOverlaySlider() {
    return ValueListenableBuilder(
      valueListenable: _controller,
      builder: (context, VideoPlayerValue value, child) {
        if (!value.hasError && value.isInitialized) {
          return Row(
            children: <Widget>[
              Container(
                width: 46,
                alignment: Alignment(0, 0),
                child: Text(value.position.inMinutes.toString() +
                    ':' +
                    (value.position.inSeconds - value.position.inMinutes * 60)
                        .toString()),
              ),
              Container(
                height: 20,
                width: videoWidth - 92,
                child: VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    playedColor: Color(0xFF22A3D2),
                    backgroundColor: Color(0x5515162B),
                    bufferedColor: Color(0x5583D8F7),
                  ),
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                ),
              ),
              Container(
                width: 46,
                alignment: Alignment(0, 0),
                child: Text(value.duration.inMinutes.toString() +
                    ':' +
                    (value.duration.inSeconds - value.duration.inMinutes * 60)
                        .toString()),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class FullscreenYoutubePlayer extends StatefulWidget {
  final YoutubePlayerController controller;
  final Function endFunction;
  final bool autoPlay;
  final position;

  FullscreenYoutubePlayer({
    this.controller,
    this.endFunction,
    this.autoPlay,
    this.position,
    Key key,
  }) : super(key: key);

  @override
  _FullscreenYoutubePlayerState createState() => _FullscreenYoutubePlayerState(endFunction, controller, autoPlay,position);
}

class _FullscreenYoutubePlayerState extends State<FullscreenYoutubePlayer> {
  Function endFunction;
  YoutubePlayerController controller;
  bool autoPlay;
  int position;

  _FullscreenYoutubePlayerState(this.endFunction, this.controller,this.autoPlay, this.position);
  @override
  void initState() {
    setState(() {
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
    });
    super.initState();
  }

  Future<bool> _onWillPop() {
    setState(() {
      widget.controller.pause();
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    });
    Navigator.pop(context, widget.controller.value.position.inSeconds);
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            body: Center(
                child: YoutubePlayer(
                  controller: widget.controller,
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
                    widget.endFunction.call();
                  },
                )
            )
        )
    );
  }
}
