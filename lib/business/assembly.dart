import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import 'data/assembly.dart' as global;
import 'data/setup.dart';
import 'general.dart';

class AssemblyModel extends Model {
  @override
  List<String> fetchKeys() => global.songData.keys.toList();

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
      this,
    );
  }
}

class AssemblyUnit extends Unit<String> {
  AssemblyUnit(String key, String name, String music, String imageUrl,
      List<String> lyrics, String desc, String author, String date, Model model)
      : super(key, name, music, imageUrl, lyrics, desc, author, date, model);
}

class AssemblyController extends Controller {
  final Model _model = AssemblyModel();
  List<bool> expanded;
  List<bool> playing;

  static Controller get to => Get.find();

  @override
  Model get model => _model;

  @override
  void onInit() {
    _model.player = AudioPlayer();
    expanded = List.generate(20, (i) => false);
    playing = List.generate(20, (i) => false);
  }

  @override
  void onClose() {
    _model.player.dispose();
    super.dispose();
  }

  void setExpanded(index, newVal) {
    expanded[index] = newVal;
    update(this);
  }

  void setPlaying(index, newVal) {
    playing = List.generate(20, (i) => false);
    playing[index] = newVal;
    update(this);
  }
}
