import 'package:get/get.dart';

import 'data/assembly.dart' as global;
import 'data/setup.dart';
import 'general.dart';

class AssemblyModel extends Model {
  @override
  List<String> fetchKeys() => global.songData.keys;

  @override
  AssemblyUnit findByKey(String key) {
    var song = global.songData[key];
    return AssemblyUnit(
      key,
      song[SongInfo.name],
      song[SongInfo.music],
      song[SongInfo.image],
      song[SongInfo.lyrics],
      song[SongInfo.desc],
      song[SongInfo.author],
      song[SongInfo.date],
    );
  }
}

class AssemblyUnit extends Unit<String> {
  AssemblyUnit(String key, String name, String music, String imageUrl,
      List<String> lyrics, String desc, String author, String date)
      : super(key, name, music, imageUrl, lyrics, desc, author, date);
}

class AssemblyController extends Controller {
  Model _model = AssemblyModel();

  static Controller get to => Get.find();

  @override
  Model get model => _model;

  @override
  void onInit() {}

  @override
  void onClose() {}
}
