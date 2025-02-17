// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:get/get.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:wandy_app/models/audio_controller.dart';
// import '../database/database_helper.dart';
// import 'custom_slider.dart';
//
// class CustomAudioPlayer extends StatefulWidget {
//   final String url;
//   final String messageId;
//   final String fileExtension;
//
//   const CustomAudioPlayer(this.url, this.messageId, this.fileExtension);
//
//   @override
//   _CustomPlayerState createState() => _CustomPlayerState();
// }
//
// class _CustomPlayerState extends State<CustomAudioPlayer> {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   final PlayerController playerController = Get.put(PlayerController());
//
//   final Dio _dio = new Dio();
//   Duration _position = Duration();
//   Duration _totalDuration = Duration();
//   bool _isLoading = false;
//   bool _showDuration = false;
//   String _path = '';
//   PlayerState _state = PlayerState.STOPPED;
//
//   // final sampleUrl =
//   //     'https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_700KB.mp3';
//
// // Create local storage directory in which audio file is going to save
//   Future<void> _setDirectory() async {
//     final dir = await getApplicationDocumentsDirectory();
//     _path = "${dir.path}/audio/${DateTime.now().microsecondsSinceEpoch}${widget.fileExtension}";
//   }
//
//   // checks if file is already downloaded then it will give the path from local storage and if note,
//   // it will download the file first and save it to local storage with created local path
//   Future<void> _getPathFromLocalDatabase() async {
//     DatabaseHelper database = DatabaseHelper.instance;
//     List<Map<String, dynamic>> data = [];
//     data = await database.queryPath(widget.messageId);
//     if (data.isEmpty) {
//       print("Data: $data");
//       _setDirectory();
//       return;
//     }
//     _path = data[0]['LocalPath'];
//     // print("Audio Path: $_path");
//     if (FileSystemEntity.typeSync(_path) == FileSystemEntityType.notFound) {
//       await database.deletePathFromDb(widget.messageId);
//       _setDirectory();
//       return;
//     }
//     print("file exist: ${FileSystemEntity.typeSync(_path) != FileSystemEntityType.notFound}");
//     setState(() {});
//     _initAudioPlayer();
//   }
//
//   // It will download the file to the created local path and save the local path in local database
//   Future<void> _downloadFile() async {
//     try {
//       setState(() {
//         _isLoading = true;
//       });
//       await _dio.download(widget.url, _path);
//     } on DioError catch (e) {
//       print(e);
//       setState(() {
//         _isLoading = false;
//       });
//     }
//     DatabaseHelper database = DatabaseHelper.instance;
//     await database.insert(_path, widget.messageId);
//     await _initAudioPlayer();
//     setState(() {
//       _showDuration = true;
//       _isLoading = false;
//     });
//     print("Download completed");
//   }
//
//   // Format audio duration
//   String _setDurationToStringFormat(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, "0");
//     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
//     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
//     return "$twoDigitMinutes:$twoDigitSeconds";
//   }
//
//   // initialized audio player
//   // handles position, state, total duration
//   Future<void> _initAudioPlayer() async {
//     print('Audio player before initialized');
//     await _audioPlayer.setUrl(_path, isLocal: true);
//     print('Audio player after initialized: $_path');
//
//     if (Platform.isIOS) {
//       final duration = await _audioPlayer.getDuration();
//       Duration total = Duration(milliseconds: duration);
//       setState(() {
//         _totalDuration = total;
//         _showDuration = true;
//       });
//     }
//
//     if (Platform.isAndroid) {
//       _audioPlayer.onDurationChanged.listen((event) {
//         setState(() {
//           _totalDuration = event;
//           _showDuration = true;
//         });
//         print("Durations: $event");
//       });
//     }
//
//     print("total Duration: $_totalDuration");
//
//     _audioPlayer.onPlayerStateChanged.listen((event) {
//       if (mounted)
//         setState(() {
//           _state = event;
//         });
//       print("Chat Audio State: $_state");
//     });
//
//     _audioPlayer.onPlayerCompletion.listen((event) {
//       setState(() {
//         _position = Duration();
//       });
//       _audioPlayer.stop();
//     });
//
//     print('Audio player initialized');
//
//     _audioPlayer.onAudioPositionChanged.listen((event) {
//       if (mounted)
//         setState(() {
//           _position = event;
//         });
//     });
//   }
//
//   void _playingAudio() async {
//     playerController.setCurrentPlayerId(RxString(widget.messageId));
//     print("Player path: $_path");
//     if (_state == PlayerState.COMPLETED || _state == PlayerState.STOPPED) {
//       _playLocal();
//     }
//     if (_state == PlayerState.PAUSED) _resume();
//     if (_state == PlayerState.PLAYING) _pause();
//   }
//
//   Future<void> _disposeAudioPlayer() async {
//     await _audioPlayer.dispose();
//   }
//
//   Future<void> _playLocal() async {
//     await _audioPlayer.play(_path);
//   }
//
//   Future<void> _pause() async {
//     await _audioPlayer.pause();
//   }
//
//   Future<void> _resume() async {
//     await _audioPlayer.resume();
//   }
//
//   Future<void> _stop() async {
//     await _audioPlayer.stop();
//   }
//
//   @override
//   void initState() {
//     _getPathFromLocalDatabase();
//     super.initState();
//   }
//
//   // destroy audio player once screen is popped or destroyed
//   @override
//   void dispose() {
//     _disposeAudioPlayer();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.black.withOpacity(0.6),
//       ),
//       child: Row(
//         children: [
//           Obx(() {
//             if (playerController.songId.isNotEmpty &&
//                 playerController.songId.value != widget.messageId &&
//                 _state != PlayerState.STOPPED) {
//               _stop();
//               _position = Duration();
//             }
//             return Container();
//           }),
//           SizedBox(width: 5),
//           if (_isLoading)
//             SpinKitFadingCircle(
//               color: Colors.white,
//               size: 27,
//             ),
//           if (_isLoading) SizedBox(width: 8.0),
//           Visibility(
//             visible: FileSystemEntity.typeSync(_path) == FileSystemEntityType.notFound && !_isLoading,
//             child: GestureDetector(
//               child: Icon(
//                 Icons.download_sharp,
//                 color: Colors.white,
//                 size: 35,
//               ),
//               onTap: () {
//                 _downloadFile();
//               },
//             ),
//           ),
//           Visibility(
//             visible: FileSystemEntity.typeSync(_path) != FileSystemEntityType.notFound && !_isLoading,
//             child: GestureDetector(
//               child: Icon(
//                 _state == PlayerState.PLAYING ? Icons.pause : Icons.play_arrow,
//                 color: Colors.white,
//                 size: 35,
//               ),
//               onTap: () {
//                 _playingAudio();
//               },
//             ),
//           ),
//           SizedBox(width: 8),
//           Expanded(
//             child: CustomSlider(
//               thumbSize: 7,
//               overlayRadius: 0,
//               slider: new Slider(
//                 value: _position.inSeconds.toDouble(),
//                 min: 0,
//                 max: _totalDuration.inSeconds.toDouble(),
//                 onChanged: (double newVal) {
//                   print(newVal);
//                   setState(() {
//                     _position = Duration(seconds:  newVal.toInt());
//                     _audioPlayer.seek(_position);
//                   });
//                 },
//               ),
//             ),
//           ),
//           Visibility(
//             visible: _showDuration,
//             child: Padding(
//               padding: const EdgeInsets.only(right: 8.0),
//               child: Text(
//                 !_isLoading
//                     ? _setDurationToStringFormat(_position) + '/' + _setDurationToStringFormat(_totalDuration)
//                     : "Loading...",
//                 style: TextStyle(color: Colors.white, fontSize: 10),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }