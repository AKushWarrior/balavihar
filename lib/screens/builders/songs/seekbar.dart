import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:seekbar/seekbar.dart';
import 'package:just_audio/just_audio.dart';

class SeekingProgressBar extends StatefulWidget {
  final AudioPlayer player;

  SeekingProgressBar(this.player);

  @override
  _SeekingProgressBarState createState() {
    return _SeekingProgressBarState();
  }
}

class _SeekingProgressBarState extends State<SeekingProgressBar> {
  Timer _progressTimer;

  bool _done = false;

  AudioPlayer get audioPlayer => this.widget.player;

  Duration get totalTime => audioPlayer.duration;

  Duration get timePassed => audioPlayer.position;

  @override
  void initState() {
    _resumeProgressTimer();
    super.initState();
  }

  _resumeProgressTimer() {
    _progressTimer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _progressTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicSlider(
      height: 10,
      style: SliderStyle(
        accent: Colors.red[800],
        variant: Colors.red[800],
      ),
      value: ((timePassed?.inMilliseconds) ?? 0) / ((totalTime?.inMilliseconds) ?? 1),
      min: 0,
      max: 1,
      onChanged: (value) {
        audioPlayer.seek(
          Duration(
            milliseconds: ((totalTime?.inMilliseconds ?? 0) * value).round(),
          ),
        );
      },
    );
  }


}
