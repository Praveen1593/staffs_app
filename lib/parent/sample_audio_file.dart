import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_projects/parent/themes/app_styles.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:math';
import 'package:rxdart/rxdart.dart' as rx;

import '../common/const/colors.dart';
import '../common/widgets/common_widgets.dart';


class SampleAudioPlayer extends StatefulWidget {
  const SampleAudioPlayer({Key? key, required this.voiceTodayData})
      : super(key: key);
  final dynamic voiceTodayData;

  @override
  SampleAudioPlayerState createState() => SampleAudioPlayerState();
}

class SampleAudioPlayerState extends State<SampleAudioPlayer>
    with WidgetsBindingObserver {
  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    ambiguate(WidgetsBinding.instance)!.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    _player.playbackEventStream
        .listen((event) {}, onError: (Object e, StackTrace stackTrace) {});
    try {
      await _player.setAudioSource(
          AudioSource.uri(Uri.parse(widget.voiceTodayData.voiceMsgFile ?? "")));
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  @override
  void dispose() {
    ambiguate(WidgetsBinding.instance)!.removeObserver(this);
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _player.stop();
    }
  }

  /// Collects the data useful for displaying in a seek bar, using a handy
  /// feature of rx_dart to combine the 3 streams of interest into one.
  Stream<PositionData> get _positionDataStream {
    return rx.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _player.positionStream,
        _player.bufferedPositionStream,
        _player.durationStream,
            (position, bufferedPosition, duration) =>
            PositionData(
                position, bufferedPosition, duration ?? Duration.zero));
  }

  var width = MediaQuery
      .of(Get.context!)
      .size
      .width;
  var height = MediaQuery
      .of(Get.context!)
      .size
      .height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFFF5F5F5),
        appBar: smsAppbar("Audio Player"),
        body: SafeArea(
            child: SizedBox(
              width: width,
              height: height,
              child: Stack(
                children: [

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 50, horizontal: 20),
                      child: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        color: Color(0XFFF2F5FA),
                                        shape: BoxShape.circle
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: SMSImageAsset(
                                            image: "assets/campuseasy/voice_image.png",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 7),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Container(
                                              width: 200,
                                              child: Text(
                                                  widget.voiceTodayData.title ??
                                                      "",
                                                  style:
                                                  AppStyles.PoppinsRegular
                                                      .copyWith(
                                                    fontSize: 15,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    color: Color(0XFF252525),
                                                  )),
                                            ),
                                            SizedBox(height: 5,),
                                            Text(
                                                "",
                                                style:
                                                AppStyles.PoppinsRegular
                                                    .copyWith(
                                                  fontSize: 12,
                                                  color: Color(0XFF93A0A7),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  Center(
                      child: Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: SMSImageAsset(
                          image: "assets/campuseasy/audio_player_image.png",
                        ),
                      )
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: StreamBuilder<PositionData>(
                          stream: _positionDataStream,
                          builder: (context, snapshot) {
                            final positionData = snapshot.data;
                            return SeekBar(
                              duration: positionData?.duration ?? Duration.zero,
                              position: positionData?.position ?? Duration.zero,
                              bufferedPosition:
                              positionData?.bufferedPosition ?? Duration.zero,
                              onChangeEnd: _player.seek,
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 80),
                        child: ControlButtons(_player),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}

/// Displays the play/pause button and volume/speed sliders.
class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            showSliderDialog(
              context: context,
              title: "Adjust volume",
              divisions: 10,
              min: 0.0,
              max: 1.0,
              value: player.volume,
              stream: player.volumeStream,
              onChanged: player.setVolume,
            );
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0XFFECECEC)
            ),
            child: Center(child: Icon(Icons.volume_up, color: Color(0XFF253238),)),
          ),
        ),
        SizedBox(width: 10,),
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                width: 50.0,
                height: 50.0,
                child: const CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return InkWell(
                onTap: () {
                  player.play;
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0XFF253238)
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.play_arrow,color: Colors.white,),
                    iconSize: 30.0,
                    onPressed: player.play,
                  ),
                ),
              );
            } else if (processingState != ProcessingState.completed) {
              return InkWell(
                onTap: () {
                  player.pause;
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0XFF253238)
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.pause,color: Colors.white,),
                    iconSize: 30.0,
                    onPressed: player.pause,
                  ),
                ),
              );
            } else {
              return InkWell(
                onTap: () {
                  player.seek(Duration.zero);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0XFF253238)
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.replay,color: Colors.white,),
                    iconSize: 30.0,
                    onPressed: () => player.seek(Duration.zero),
                  )
                ),
              );
            }
          },
        ),
        SizedBox(width: 10,),
        StreamBuilder<double>(
          stream: player.speedStream,
          builder: (context, snapshot) =>
              InkWell(
                onTap: () {
                  showSliderDialog(
                    context: context,
                    title: "Adjust speed",
                    divisions: 10,
                    min: 0.5,
                    max: 1.5,
                    value: player.speed,
                    stream: player.speedStream,
                    onChanged: player.setSpeed,
                  );
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0XFFECECEC)
                  ),
                  child: Center(child: Text("${snapshot.data?.toStringAsFixed(1)}x",
                      style: const TextStyle(fontWeight: FontWeight.bold))),
                ),
              ),

             /* IconButton(
                icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () {
                  showSliderDialog(
                    context: context,
                    title: "Adjust speed",
                    divisions: 10,
                    min: 0.5,
                    max: 1.5,
                    value: player.speed,
                    stream: player.speedStream,
                    onChanged: player.setSpeed,
                  );
                },
              ),*/

        ),
      ],
    );
  }
}

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  const SeekBar({
    Key? key,
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
  }) : super(key: key);

  @override
  SeekBarState createState() => SeekBarState();
}

class SeekBarState extends State<SeekBar> {
  double? _dragValue;
  late SliderThemeData _sliderThemeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _sliderThemeData = SliderTheme.of(context).copyWith(
      trackHeight: 2.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SliderTheme(
          data: _sliderThemeData.copyWith(
            thumbShape: HiddenThumbComponentShape(),
            activeTrackColor: Colors.blue.shade100,
            inactiveTrackColor: Colors.grey.shade300,
          ),
          child: ExcludeSemantics(
            child: Slider(
              min: 0.0,
              max: widget.duration.inMilliseconds.toDouble(),
              value: min(widget.bufferedPosition.inMilliseconds.toDouble(),
                  widget.duration.inMilliseconds.toDouble()),
              onChanged: (value) {
                setState(() {
                  _dragValue = value;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(Duration(milliseconds: value.round()));
                }
              },
              onChangeEnd: (value) {
                if (widget.onChangeEnd != null) {
                  widget.onChangeEnd!(Duration(milliseconds: value.round()));
                }
                _dragValue = null;
              },
            ),
          ),
        ),
        SliderTheme(
          data: _sliderThemeData.copyWith(
            inactiveTrackColor: Colors.transparent,
          ),
          child: Slider(
            min: 0.0,
            max: widget.duration.inMilliseconds.toDouble(),
            value: min(_dragValue ?? widget.position.inMilliseconds.toDouble(),
                widget.duration.inMilliseconds.toDouble()),
            onChanged: (value) {
              setState(() {
                _dragValue = value;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(Duration(milliseconds: value.round()));
              }
            },
            onChangeEnd: (value) {
              if (widget.onChangeEnd != null) {
                widget.onChangeEnd!(Duration(milliseconds: value.round()));
              }
              _dragValue = null;
            },
          ),
        ),
        Positioned(
          right: 24.0,
          bottom: 0.0,
          child: Text(
              RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                  .firstMatch("$_remaining")
                  ?.group(1) ??
                  '$_remaining',
              style: Theme
                  .of(context)
                  .textTheme
                  .caption),
        ),
      ],
    );
  }

  Duration get _remaining => widget.duration - widget.position;
}

class HiddenThumbComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.zero;

  @override
  void paint(PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {}
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}

void showSliderDialog({
  required BuildContext context,
  required String title,
  required int divisions,
  required double min,
  required double max,
  String valueSuffix = '',
  // TODO: Replace these two by ValueStream.
  required double value,
  required Stream<double> stream,
  required ValueChanged<double> onChanged,
}) {
  showDialog<void>(
    context: context,
    builder: (context) =>
        AlertDialog(
          title: Text(title, textAlign: TextAlign.center),
          content: StreamBuilder<double>(
            stream: stream,
            builder: (context, snapshot) =>
                SizedBox(
                  height: 100.0,
                  child: Column(
                    children: [
                      Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                          style: const TextStyle(
                              fontFamily: 'Fixed',
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0)),
                      Slider(
                        divisions: divisions,
                        min: min,
                        max: max,
                        value: snapshot.data ?? value,
                        onChanged: onChanged,
                      ),
                    ],
                  ),
                ),
          ),
        ),
  );
}

T? ambiguate<T>(T? value) => value;
