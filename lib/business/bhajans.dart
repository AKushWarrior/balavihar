import 'package:get/get.dart';

import 'data/bhajans.dart' as data;
import 'data/setup.dart';
import 'general.dart';

class BhajanModel extends Model {
  @override
  List<String> fetchKeys() => data.songData.keys;

  @override
  BhajanUnit findByKey(String key) {
    var song = data.songData[key];
    var lyrics = song[SongInfo.lyrics];
    var subunits = List.generate(
        lyrics.length,
        (i) => SubUnit('$key.${i + 1}', lyrics[i][SubSongInfo.lyric],
            lyrics[i][SubSongInfo.music]));
    return BhajanUnit(
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

class BhajanUnit extends Unit<SubUnit> {
  BhajanUnit(String key, String name, String musicUrl, String imageUrl,
      List<SubUnit> lyrics, String desc, String author, String date)
      : super(key, name, musicUrl, imageUrl, lyrics, desc, author, date);
}

class BhajanController extends Controller {
  Model _model = BhajanModel();

  static Controller get to => Get.find();

  @override
  Model get model => _model;

  @override
  void onInit() {}

  @override
  void onClose() {}
}
