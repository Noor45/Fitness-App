import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:t_fit/database/local_storage_function.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerCard extends StatefulWidget {
  AudioPlayerCard({this.id, this.file});
  final String file;
  final String id;
  @override
  _AudioPlayerCardState createState() => _AudioPlayerCardState();
}

class _AudioPlayerCardState extends State<AudioPlayerCard>  {
  Duration _position = Duration();
  Duration _totalDuration = Duration();
  bool _isLoading = false;
  bool _showDuration = false;
  PlayerState _state = PlayerState.STOPPED;
  AudioPlayer _audioPlayer = AudioPlayer();
  String _path = '';
  final Dio dio = new Dio();

  Future<void> setDirectory() async {
    final dir = await getApplicationDocumentsDirectory();
    _path =
    "${dir.path}/audio/${DateTime.now().microsecondsSinceEpoch}${'.mp3'}";
  }

  Future<void> _downloadFile() async {
    try {
      final download = await dio.download(widget.file, _path);
      print(download);
      DatabaseHelper database = DatabaseHelper.instance;
      database.insertPath(_path, widget.id);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getPathFromLocalDatabase() async {
    DatabaseHelper database = DatabaseHelper.instance;
    List<Map<String, dynamic>> data = [];
    data = await database.queryPath(widget.id);
    if (data.isEmpty) {
      await setDirectory();
      await _downloadFile();
      return;
    }
    _path = data[0]['LocalPath'];
    if (FileSystemEntity.typeSync(_path) == FileSystemEntityType.notFound) {
      await database.deletePathFromDb(widget.id);
      await setDirectory();
      await _downloadFile();
      return;
    }
    setState(() {});
    _initAudioPlayer();
  }

  // Format audio duration
  String _setDurationToStringFormat(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  Future<void> _initAudioPlayer() async {
    await _audioPlayer.setUrl(_path, isLocal: true);
    if (Platform.isIOS) {
      final duration = await _audioPlayer.getDuration();
      Duration total = Duration(milliseconds: duration);
      setState(() {
        _totalDuration = total;
        _showDuration = true;
      });
    }

    if (Platform.isAndroid) {
      _audioPlayer.onDurationChanged.listen((event) {
        if (mounted)
        setState(() {
          _totalDuration = event;
          _showDuration = true;
        });
      });
    }


    _audioPlayer.onPlayerStateChanged.listen((event) {
      if (mounted)
        setState(() {
          _state = event;
        });
    });

    _audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        _position = Duration();
      });
      _audioPlayer.stop();
    });

    print('Audio player initialized');

    _audioPlayer.onAudioPositionChanged.listen((event) {
      if (mounted)
        setState(() {
          _position = event;
        });
    });
  }

  void _playingAudio() async {
    if (_state == PlayerState.COMPLETED || _state == PlayerState.STOPPED) {
      _playLocal();
    }
    if (_state == PlayerState.PAUSED) _resume();
    if (_state == PlayerState.PLAYING) _pause();
  }

  Future<void> _disposeAudioPlayer() async {
    if(_audioPlayer != null)
    await _audioPlayer.dispose();
  }

  Future<void> _playLocal() async {
    await _audioPlayer.play(_path);
  }

  Future<void> _pause() async {
    await _audioPlayer.pause();
  }

  Future<void> _resume() async {
    await _audioPlayer.resume();
  }

  @override
  void initState() {
    getPathFromLocalDatabase();
    super.initState();
  }

  @override
  void dispose() {
    _disposeAudioPlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_isLoading);
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0xffD5D7DA),
      ),
      child:  Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Visibility(
              visible: FileSystemEntity.typeSync(_path) != FileSystemEntityType.notFound && !_isLoading,
              child: GestureDetector(
                child: Icon(
                  _state == PlayerState.PLAYING ? Icons.pause : Icons.play_arrow,
                  color: Colors.black54,
                  size: 35,
                ),
                onTap: () {
                  _playingAudio();
                },
              ),
            ),
            SizedBox(width: 5),
            Visibility(
              visible: _showDuration,
              child: Text(
                !_isLoading
                    ? _setDurationToStringFormat(_position) + '/' + _setDurationToStringFormat(_totalDuration)
                    : "Loading...",
                style: TextStyle(color: Colors.black, fontSize: 10),
              ),
            ),
            SliderTheme(
              data: SliderThemeData(
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7)),
              child: Slider(
                value: _position.inSeconds.toDouble(),
                min: 0,
                max: _totalDuration.inSeconds.toDouble(),
                onChanged: (double newVal) {
                  setState(() {
                    _position = Duration(seconds:  newVal.toInt());
                    _audioPlayer.seek(_position);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
