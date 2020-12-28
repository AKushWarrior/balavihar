import 'dart:async';

import 'package:flutter/material.dart';
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
    return SeekBar(
      barColor: Colors.grey,
      progressColor: Colors.red[700],
      thumbColor: Colors.black,
      value: (timePassed?.inMilliseconds ?? 0) / totalTime.inMilliseconds,
      secondValue: 0,
      onStartTrackingTouch: () {
        if (!_done) {
          _progressTimer?.cancel();
        }
      },
      onProgressChanged: (value) {
        audioPlayer.seek(
          Duration(
            milliseconds: (totalTime?.inMilliseconds ?? 0 * value).round(),
          ),
        );
      },
      onStopTrackingTouch: () {
        if (!_done) {
          _resumeProgressTimer();
        }
      },
    );
  }
}
