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
    var lyrics = song[SongInfo.lyrics];
    var prefix = song[SongInfo.prefix];
    print(
        'https://balvihar.s3-us-west-1.amazonaws.com/bhajans/${prefix}/${prefix}_${1}.m4a');
    var subunits = List.generate(
      lyrics.length,
      (i) => SinglePageUnit(
          '$key.${i + 1}',
          'Verse ${i + 1}',
          'https://balvihar.s3-us-west-1.amazonaws.com/bhajans/${prefix}/${prefix}_${i + 1}.m4a',
          null,
          lyrics[i],
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
  MultiPageUnit(
      String key,
      String name,
      String imageUrl,
      List<SinglePageUnit> lyrics,
      String desc,
      String author,
      String date,
      Model model)
      : super(key, name, null, imageUrl, lyrics, desc, author, date, model);
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
  Mode _mode;
  int pgIndex = 0;
  MultiPageController parent;
  bool _playing = false;

  bool get isPlaying => _playing;

  Mode get mode => _mode;

  void set mode(Mode newMode) {
    _mode = newMode;
    update();
  }

  @override
  MultiPageModel get model => _model;

  SinglePageSongController(this._model, this.base, this.parent) {
    mode = Mode.all;
    model.player.pause();
    model.player.load(ConcatenatingAudioSource(
      children: List.generate(base.lyrics.length,
              (int i) => ProgressiveAudioSource(Uri.parse(base.lyrics[i].music))),
    ));
  }

  void flipPage(Direction direction) {
    if (mode != Mode.verse)
      throw StateError('All mode does not support pg. flips');
    if (direction == Direction.forward) {
      pgIndex++;
    } else {
      pgIndex--;
    }
    update();
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
  }
}

enum Direction { forward, backward }

enum Mode { all, verse }
