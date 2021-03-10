import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SeekingProgressBar extends StatefulWidget {
  final AudioPlayer player;

  const SeekingProgressBar(this.player);

  @override
  _SeekingProgressBarState createState() {
    return _SeekingProgressBarState();
  }
}

class _SeekingProgressBarState extends State<SeekingProgressBar> {
  Timer _progressTimer;

  AudioPlayer get audioPlayer => widget.player;

  Duration get totalTime => audioPlayer.duration;

  Duration get timePassed => audioPlayer.position;

  @override
  void initState() {
    _resumeProgressTimer();
    super.initState();
  }

  void _resumeProgressTimer() {
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
    return SfSlider(
      value: ((timePassed?.inMilliseconds) ?? 0) /
          ((totalTime?.inMilliseconds) ?? 1),
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
