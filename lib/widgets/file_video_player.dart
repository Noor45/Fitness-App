import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../database/local_storage_function.dart';
import 'package:t_fit/utils/constants.dart';
import 'package:t_fit/widgets/fullscreen_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FileVideoPlayer extends StatefulWidget {
  FileVideoPlayer(
      {this.width,
      this.height,
      this.file,
      this.loaderPadding,
      this.messageId,
      this.buttonPadding,
      Key key})
      : super(key: key);
  final double width;
  final double height;
  final String file;
  final String messageId;
  final EdgeInsetsGeometry loaderPadding;
  final EdgeInsetsGeometry buttonPadding;

  @override
  _FileVideoPlayerState createState() => _FileVideoPlayerState();
}

class _FileVideoPlayerState extends State<FileVideoPlayer>
    with TickerProviderStateMixin {
  final Dio dio = new Dio();
  AnimationController animationController;
  Future<void> initFuture;
  double volume = 1.0;
  VideoPlayerController controller;
  int secs = 0;
  bool call = false;
  bool timer = false;
  bool autoPlay = false;
  bool looping = false;
  bool _overlay = true;
  int position = 0;
  String path = '';

  Future<void> setDirectory() async {
    final dir = await getApplicationDocumentsDirectory();
    path =
        "${dir.path}/video/${DateTime.now().microsecondsSinceEpoch}${'.mp4'}";
  }

  // checks if file is already downloaded then it will give the path from local storage and if not,
  // it will download the file first and save it to local storage with created local path
  Future<void> getPathFromLocalDatabase() async {
    DatabaseHelper database = DatabaseHelper.instance;
    List<Map<String, dynamic>> data = [];
    data = await database.queryPath(widget.messageId);
    if (data.isEmpty) {
      await setDirectory();
      await _downloadFile();
      return;
    }
    path = data[0]['LocalPath'];
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      await database.deletePathFromDb(widget.messageId);
      await setDirectory();
      await _downloadFile();
      return;
    }
    if (Constants.fullScreen == false) setState(() {});

    await initializePlayer();
  }

  Future<void> initializePlayer() async {
    File videoFile = File(path);
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    controller = VideoPlayerController.file(videoFile);
    if (controller != null) {
      controller.pause();
      initFuture = controller.initialize();
      controller.addListener(() {
        if (VideoTools.videoLoad == true) {
          try {
            setState(() {
              if (controller.value.position == controller.value.duration) {
                _overlay = true;
              }
            });
          } catch (e) {
            print(e);
          }
        }
      });
    }
    VideoTools.videoLoad = false;
  }

  Future<void> _downloadFile() async {
    try {
      print(widget.file);
      print(path);
      final download = await dio.download(widget.file, path);
      print(download);
      DatabaseHelper database = DatabaseHelper.instance;
      database.insertPath(path, widget.messageId);
      await initializePlayer();
    } catch (e) {
      print(e);
    }
  }


  @override
  void initState() {
    getPathFromLocalDatabase();
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

  Future<void> _disposeVideoPlayer() async {
    if (Constants.fullScreen == false) {
      if (animationController != null) animationController.dispose();
      if (controller != null) {
        controller.pause();
        await controller.dispose();
      }
      Constants.fullScreen = false;
    }
  }

  @override
  void dispose() {
    _disposeVideoPlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: GestureDetector(
        child: FutureBuilder(
          future: initFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              VideoTools.videoLoad = true;
            }
            return Stack(
              children: <Widget>[
                Container(
                  width: widget.width,
                  height: widget.height,
                  child: FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound
                      ? SpinKitThreeBounce(
                          color: Colors.white,
                          size: 20,
                          controller: animationController,
                        )
                      : VideoPlayer(controller),
                ),
                Container(
                    child: FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound
                        ? Container(
                            width: widget.width,
                            height: widget.height,
                          )
                        : _videoOverlay()),
              ],
            );
          },
        ),
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
            }
          });
        },
      ),
    );
  }

  //================================ OVERLAY ================================//

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

  Widget _videoOverlay() {
    return _overlay
        ? Stack(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  width: widget.width,
                  height: widget.height,
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
              IconButton(
                  padding: widget.buttonPadding,
                  icon: controller.value.isPlaying
                      ? Icon(Icons.pause, size: 35, color: Colors.white)
                      : Icon(Icons.play_arrow, size: 35, color: Colors.white),
                  onPressed: () {
                    setState(() {
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
                    });
                  }),
              Container(
                width: widget.width,
                margin: EdgeInsets.only(top: widget.height - 26),
                child: _videoOverlaySlider(widget.width),
              ),
            ],
          )
        : Container(
            height: 5,
            width: widget.width,
            margin: EdgeInsets.only(top: widget.height),
            child: VideoProgressIndicator(
              controller,
              allowScrubbing: false,
              colors: VideoProgressColors(
                playedColor: Colors.white,
                backgroundColor: Color(0x5515162B),
                bufferedColor: Color(0x5583D8F7),
              ),
              padding: EdgeInsets.only(top: 2),
            ),
          );
  }

  //=================== video overlay Slider ===================//

  Widget _videoOverlaySlider(double width) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, VideoPlayerValue value, child) {
        if (!value.hasError && value.isInitialized) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerRight,
                    child: Text(
                      value.position.inMinutes.toString() +
                          ':' +
                          (value.position.inSeconds -
                                  value.position.inMinutes * 60)
                              .toString(),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 3, right: 3),
                    child: Text(
                      '/',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      value.duration.inMinutes.toString() +
                          ':' +
                          (value.duration.inSeconds -
                                  value.duration.inMinutes * 60)
                              .toString(),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 20,
                width: widget.width / 1.9,
                padding: EdgeInsets.only(left: 5, right: 5),
                child: VideoProgressIndicator(
                  controller,
                  allowScrubbing: false,
                  colors: VideoProgressColors(
                    playedColor: Colors.white,
                    backgroundColor: Color(0x5515162B),
                    bufferedColor: Color(0x5583D8F7),
                  ),
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10),
                child: InkWell(
                    onTap: () async {
                      setState(() {
                        Constants.fullScreen = true;
                        controller.pause();
                        print(Constants.fullScreen);
                      });
                      WidgetsBinding.instance.addPostFrameCallback((_) async {
                        position = await Navigator.push(
                            context,
                            PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (BuildContext context, _, __) =>
                                    FullscreenSimplePlayer(
                                      autoPlay: true,
                                      controller: controller,
                                      position:
                                          controller.value.position.inSeconds,
                                      initFuture: initFuture,
                                    ),
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
                        controller.play();
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
}
