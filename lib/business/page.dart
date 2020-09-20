import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import 'data/setup.dart';
import 'general.dart';

class SinglePageModel extends Model {
  @override
  List<String> fetchKeys() => songData.keys.toList();

  @override
  SinglePageUnit findByKey(String key) {
    var song = songData[key];
    return SinglePageUnit(
      key,
      song[SongInfo.name],
      song[SongInfo.music],
      song[SongInfo.image],
      song[SongInfo.lyrics],
      song[SongInfo.desc],
      song[SongInfo.author],
      song[SongInfo.date],
      this,
    );
  }
}

class SinglePageUnit extends Unit<String> {
  SinglePageUnit(String key, String name, String music, String imageUrl,
      List<String> lyrics, String desc, String author, String date, Model model)
      : super(key, name, music, imageUrl, lyrics, desc, author, date, model);
}

class SinglePageController extends Controller {
  final Model _model = SinglePageModel();
  List<bool> expanded;
  List<bool> playing;
  int autoExpand;

  bool playingAll;
  bool pausedAll;
  bool restartableAll;

  StreamSubscription streamSub;

  static Controller get to => Get.find();

  @override
  Model get model => _model;

  @override
  void onInit() {
    _model.player = AudioPlayer();
    playingAll = false;
    pausedAll = false;
    restartableAll = false;
    expanded = List.generate(20, (i) => false);
    playing = List.generate(20, (i) => false);
    streamSub = _model.player.playbackEventStream.listen((PlaybackEvent event) {
      if (event.processingState == ProcessingState.completed) {
        playingAll = false;
        expanded = List.generate(20, (i) => false);
        playing = List.generate(20, (i) => false);
        autoExpand = null;
        update();
      }
      if (event.currentIndex != null && event.currentIndex != this.autoExpand) {
        autoExpand = event.currentIndex;
        update();
      }
    });
  }

  @override
  void onClose() {
    _model.player.stop();
    streamSub.cancel();
    _model.player.dispose();
    super.onClose();
  }

  void setExpanded(index, newVal) {
    expanded[index] = newVal;
    update();
  }

  void setPlaying(index, newVal) {
    playing = List.generate(20, (i) => false);
    playing[index] = newVal;
    autoExpand = index;
    update();
  }

  void playAll() {
    playingAll = true;
    if (!pausedAll) {
      model.player.load(
        ConcatenatingAudioSource(
            children: List.generate(
                model.songData.length,
                    (int i) =>
                    ProgressiveAudioSource(Uri.parse(
                        model.songData.values.toList()[i][SongInfo.music])))),
      );
    }
    pausedAll = false;
    model.player.play();
    update();
  }

  void pauseAll() {
    playingAll = false;
    model.player.pause();
    pausedAll = true;
    update();
  }

  void restartAll() {
    pausedAll = false;
    playAll();
    update();
  }
}
