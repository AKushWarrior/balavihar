import 'package:get/get.dart';

import 'data/setup.dart';
import 'data/shlokams.dart' as data;
import 'general.dart';

class ShlokamModel extends Model {
  @override
  List<String> fetchKeys() => data.songData.keys;

  @override
  ShlokamUnit findByKey(String key) {
    var song = data.songData[key];
    var lyrics = song[SongInfo.lyrics];
    var subunits = List.generate(
        lyrics.length,
        (i) => SubUnit('$key.${i + 1}', lyrics[i][SubSongInfo.lyric],
            lyrics[i][SubSongInfo.music]));
    return ShlokamUnit(
      key,
      song[SongInfo.name],
      song[SongInfo.music],
      song[SongInfo.image],
      subunits,
      song[SongInfo.desc],
      song[SongInfo.author],
      song[SongInfo.date],
    );
  }
}

class ShlokamUnit extends Unit<SubUnit> {
  ShlokamUnit(String key, String name, String musicUrl, String imageUrl,
      List<SubUnit> lyrics, String desc, String author, String date)
      : super(key, name, musicUrl, imageUrl, lyrics, desc, author, date);
}

class ShlokamController extends Controller {
  Model _model = ShlokamModel();

  static Controller get to => Get.find();

  @override
  Model get model => _model;

  @override
  void onInit() {}

  @override
  void onClose() {}
}
