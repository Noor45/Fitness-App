import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:t_fit/utils/colors.dart';
import 'package:t_fit/utils/style.dart';
import 'package:provider/provider.dart';
import 'package:t_fit/services/theme_model.dart';
import 'package:t_fit/models/mental_health_model/mental_health_model.dart';


class PlaySoundScreen extends StatefulWidget {
  static String ID = "/play_sound_screen";
  @override
  _PlaySoundScreenState createState() => _PlaySoundScreenState();
}

class _PlaySoundScreenState extends State<PlaySoundScreen> {
  MentalHealthModel detail = MentalHealthModel();
  Duration _position = Duration();
  Duration _totalDuration = Duration();
  PlayerState _state = PlayerState.STOPPED;
  AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _initAudioPlayer() async {
    await _audioPlayer.setUrl(detail.fileUrl, isLocal: false);
    if (Platform.isIOS) {
      final duration = await _audioPlayer.getDuration();
      Duration total = Duration(milliseconds: duration);
      setState(() {
        _totalDuration = total;
      });
    }

    if (Platform.isAndroid) {
      _audioPlayer.onDurationChanged.listen((event) {
        if (mounted)
          setState(() {
            _totalDuration = event;
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
    await _audioPlayer.play(detail.fileUrl);
  }

  Future<void> _pause() async {
    await _audioPlayer.pause();
  }

  Future<void> _resume() async {
    await _audioPlayer.resume();
  }

  bool isPlaying = false;
  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    _disposeAudioPlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    detail =  ModalRoute.of(context).settings.arguments;
    _initAudioPlayer();
    return Scaffold(
      backgroundColor: theme.lightTheme == true ? Colors.white : ColorRefer.kBackgroundColor,
      appBar: AppBar(
        elevation: theme.lightTheme == true ? 3 : 0,
        iconTheme: IconThemeData(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor),
        systemOverlayStyle: theme.lightTheme == true ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
        centerTitle: true,
        title: Text(
          detail.title,
          style: StyleRefer.kTextStyle.copyWith(color: theme.lightTheme == true ? ColorRefer.kDarkGreyColor : ColorRefer.kGreyColor, fontSize: 14),
        ),
      ),
      body: SafeArea(
          child: Container(
            width: width,
            height: height,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: width/1.5,
                  height: width,
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:  theme.lightTheme == true ? ColorRefer.kLightGreyColor: ColorRefer.kBoxColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/player.svg',
                    color: ColorRefer.kPinkColor,
                    fit: BoxFit.contain,
                    width: width/2.5,
                    height: width/2.5,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: songProgress(context),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CircleAvatar(
                            child: Center(
                              child: IconButton(
                                  icon: Icon(
                                    Icons.skip_previous,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => _audioPlayer.seek(Duration(seconds: _position.inSeconds <= 5 ? 0 : -5))),
                            ),
                            backgroundColor: Colors.cyan.withOpacity(0.3),
                          ),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.cyan.withOpacity(0.3),
                            child: Center(
                              child: IconButton(
                                onPressed: () async {
                                  _playingAudio();
                                },
                                padding: EdgeInsets.all(0.0),
                                icon: Icon(
                                  _state  == PlayerState.PLAYING
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.cyan.withOpacity(0.3),
                            child: Center(
                              child: IconButton(
                                  icon: Icon(
                                    Icons.skip_next,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => _audioPlayer.seek(Duration(seconds: 5))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]
            )
          ),
      ),
    );
  }
  Widget songProgress(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          _formatDuration(_position),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 2,
                  thumbColor: ColorRefer.kPinkColor,
                  overlayColor: Colors.blue,
                  thumbShape: RoundSliderThumbShape(
                    disabledThumbRadius: 5,
                    enabledThumbRadius: 5,
                  ),
                  overlayShape: RoundSliderOverlayShape(
                    overlayRadius: 10,
                  ),
                  activeTrackColor: ColorRefer.kPinkColor,
                  inactiveTrackColor: Colors.grey,
                ),
                child: Slider(
                  value: _position.inSeconds.toDouble() ?? 0,
                  min: 0,
                  max: _totalDuration.inSeconds.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      _position = Duration(seconds:  value.toInt());
                      _audioPlayer.seek(_position);
                    });
                  },
                )),
          ),
        ),
        Text(
          _formatDuration(_totalDuration),
        ),
      ],
    );
  }

  String _formatDuration(Duration d) {
    if (d == null) return "--:--";
    int minute = d.inMinutes;
    int second = (d.inSeconds > 60) ? (d.inSeconds % 60) : d.inSeconds;
    String format = ((minute < 10) ? "0$minute" : "$minute") +
        ":" +
        ((second < 10) ? "0$second" : "$second");
    return format;
  }
}
