import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import 'data/setup.dart';
import 'data/shlokams.dart' as data;
import 'general.dart';

class MultiPageModel extends Model {
  @override
  List<String> fetchKeys() => data.songData.keys.toList();

  @override
  MultiPageUnit findByKey(String key) {
    var song = data.songData[key];
    var lyrics = song[SongInfo.lyrics];
    var subunits = List.generate(
        lyrics.length,
        (i) => SubUnit('$key.${i + 1}', lyrics[i][SubSongInfo.lyric],
            lyrics[i][SubSongInfo.music], this));
    return MultiPageUnit(
      key,
      song[SongInfo.name],
      song[SongInfo.music],
      song[SongInfo.image],
      subunits,
      song[SongInfo.desc],
      song[SongInfo.author],
      song[SongInfo.date],
      this,
    );
  }
}

class MultiPageUnit extends Unit<SubUnit> {
  MultiPageUnit(String key, String name, String musicUrl, String imageUrl,
      List<SubUnit> lyrics, String desc, String author, String date, Model model)
      : super(key, name, musicUrl, imageUrl, lyrics, desc, author, date, model);
}

class MultiPageController extends Controller {
  final Model _model = MultiPageModel();

  static Controller get to => Get.find();

  @override
  Model get model => _model;

  @override
  void onInit() {
    _model.player = new AudioPlayer();
  }

  @override
  void onClose() {
    _model.player.dispose();
    super.dispose();
  }
}