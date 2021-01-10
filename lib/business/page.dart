import 'dart:async';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import 'data/setup.dart';
import 'general.dart';

class SinglePageModel extends Model {
  @override
  List<String> fetchKeys() => (songData as Map<String, dynamic>).keys.toList();

  @override
  SinglePageUnit findByKey(String key) {
    dynamic song = (songData as Map<String, dynamic>)[key];
    return SinglePageUnit(
      key,
      song[SongInfo.name] as String,
      song[SongInfo.music] as String,
      song[SongInfo.image] as String,
      song[SongInfo.lyrics] as List<String>,
      song[SongInfo.desc] as String,
      song[SongInfo.author] as String,
      song[SongInfo.date] as String,
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
  final _model = SinglePageModel();
  List<bool> expanded;
  List<bool> playing;
  int highlighted;

  bool playingAll;
  bool pausedAll;
  bool restartableAll;
  Timer _timer;

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
        highlighted = null;
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

  void setExpanded(int index, bool newVal) {
    expanded[index] = newVal;
    update();
  }

  void setPlaying(int index, bool newVal) {
    playing = List.generate(20, (i) => false);
    restartableAll = false;
    playing[index] = newVal;
    update();
  }

  void playAll() {
    playingAll = true;
    playing = List.generate(20, (i) => false);
    restartableAll = true;
    if (!pausedAll) {
      model.player.setAudioSource(
        ConcatenatingAudioSource(
            children: List.generate(
                (model.songData as Map).length,
                (int i) => AudioSource.uri(Uri.parse(model.songData.values
                    .toList()[i][SongInfo.music] as String)))),
      );
    }
    pausedAll = false;
    model.player.currentIndexStream.listen((event) {
      highlighted = event;
      update();
    });
    model.player.play();
    update();
  }

  void pauseAll() {
    playingAll = false;
    highlighted = null;
    restartableAll = true;
    playing = List.generate(20, (i) => false);
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
