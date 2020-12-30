import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:peninsulabalvihar/business/page.dart';

import 'data/setup.dart';
import 'data/shlokams.dart' as shlokams;
import 'data/bhajans/bhajans.dart' as bhajans;
import 'general.dart';

class MultiPageModel extends Model {
  String type;

  MultiPageModel(this.type);

  @override
  Map<String, Map<SongInfo, dynamic>> get songData =>
      type == 'Shlokams' ? shlokams.songData : bhajans.songData;

  @override
  List<String> fetchKeys() => songData.keys.toList();

  @override
  MultiPageUnit findByKey(String key) {
    var song = songData[key];
    var verses = song[SongInfo.verses];
    var prefix = song[SongInfo.prefix];
    print(
        'https://balvihar.s3-us-west-1.amazonaws.com/bhajans/${prefix}/${prefix}_${1}.m4a');
    var subunits = List.generate(
      verses.length,
      (i) => SinglePageUnit(
          '$key.${i + 1}',
          'Verse ${i + 1}',
          'https://balvihar.s3-us-west-1.amazonaws.com/bhajans/${prefix}/${prefix}_${i + 1}.m4a',
          null,
          verses[i],
          null,
          null,
          null,
          this),
    );
    return MultiPageUnit(
      key,
      song[SongInfo.name],
      song[SongInfo.image],
      subunits,
      song[SongInfo.desc],
      song[SongInfo.author],
      song[SongInfo.date],
      this,
    );
  }
}

class MultiPageUnit extends Unit<SinglePageUnit> {
  List<SinglePageUnit> get verses => super.lyrics;

  MultiPageUnit(
      String key,
      String name,
      String imageUrl,
      List<SinglePageUnit> verses,
      String desc,
      String author,
      String date,
      Model model)
      : super(key, name, null, imageUrl, verses, desc, author, date, model);
}

abstract class MultiPageController extends Controller {
  @override
  MultiPageModel get model;

  MultiPageUnit _current;

  MultiPageUnit get selected => _current;

  void set selected(MultiPageUnit newUnit) {
    _current = newUnit;
    model.player ??= new AudioPlayer();
    update();
  }

  static Controller get to => Get.find();

  @override
  void onInit() {
    model.player ??= new AudioPlayer();
    super.onInit();
  }

  @override
  void onClose() {
    model.player?.dispose();
    super.onClose();
  }
}

class ShlokamController extends MultiPageController {
  final MultiPageModel _model = MultiPageModel('Shlokams');

  @override
  MultiPageModel get model => _model;
}

class BhajanController extends MultiPageController {
  final MultiPageModel _model = MultiPageModel('Bhajans');

  @override
  MultiPageModel get model => _model;
}

class SinglePageSongController extends Controller {
  MultiPageModel _model;
  MultiPageUnit base;
  MultiPageController parent;
  bool _playing = false;
  int currentVerse = 1;
  StreamSubscription sub;

  bool get isPlaying => _playing;

  @override
  MultiPageModel get model => _model;

  SinglePageSongController(this._model, this.base, this.parent) {
    model.player.pause();
    model.player.setAudioSource(
      ConcatenatingAudioSource(
        children: List.generate(
          base.lyrics.length,
          (int i) => AudioSource.uri(
            Uri.parse(base.lyrics[i].music),
          ),
        ),
      ),
    );
    sub = model.player.currentIndexStream.listen((int event) {
      if (event != null) currentVerse = event + 1;
      update();
    });
  }

  void play() {
    model.player.play();
    _playing = true;
    update();
  }

  void pause() {
    model.player.pause();
    _playing = false;
    update();
  }

  @override
  void onClose() {
    model.player.pause();
    sub.cancel();
  }
}
