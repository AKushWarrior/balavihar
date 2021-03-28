import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import '../../../../business/multipage.dart';

class SeekingProgressBar extends StatefulWidget {
  final AudioPlayer player;
  final SongController controller;

  const SeekingProgressBar(this.player, this.controller);

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
    return FluidSlider(
      start: Container(),
      end: PlayingText(widget.controller),
      min: 0.0,
      max: totalTime?.inMilliseconds?.toDouble() ?? 1.0,
      value: timePassed?.inMilliseconds?.toDouble() ?? 0.0,
      thumbDiameter: 50.0,
      sliderColor: Colors.grey[100],
      valueTextStyle: TextStyle(fontSize: 12, color: Colors.black),
      mapValueToString: (double value) {
        var duration = Duration(milliseconds: value.round());
        if (duration.inHours > 0) {
          var minutes = '${duration.inMinutes % 60}';
          if (minutes.length == 1) {
            minutes = '0' + minutes;
          }
          return '${duration.inHours}:$minutes';
        } else {
          var seconds = '${duration.inSeconds % 60}';
          if (seconds.length == 1) {
            seconds = '0' + seconds;
          }
          return '${duration.inMinutes}:$seconds';
        }
      },
      onChanged: (value) {
        audioPlayer.seek(
          Duration(
            milliseconds: (value).round(),
          ),
        );
      },
    );
  }
}

class PlayingText extends StatelessWidget {
  final SongController controller;

  PlayingText(this.controller);

  @override
  Widget build(BuildContext context) {
    var content = controller.base.verses.length == 1
        ? 'Full Song'
        : 'Verse ${controller.currentVerse}';
    return Text(
      content,
      style: TextStyle(
        color: Colors.grey[500],
        fontFamily: GoogleFonts.oswald().fontFamily,
      ),
    );
  }
}
