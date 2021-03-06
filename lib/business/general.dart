import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';

abstract class Model {
  List<String> _keys;
  dynamic songData;

  List<String> get keys {
    _keys ??= fetchKeys();
    return _keys;
  }

  List<String> fetchKeys();

  Unit findByKey(String key);

  List<Unit> fetchAll() =>
      List.generate(keys.length, (i) => findByKey(keys[i]));

  AudioPlayer player;

  bool isPlaying(String music) => player.icyMetadata.info.url == music;
}

abstract class Unit<T> {
  String key;
  String name;
  String music;
  String imageUrl;

  List<T> lyrics;

  String desc;
  String author;
  String date;
  Model parent;

  Unit(this.key, this.name, this.music, this.imageUrl, this.lyrics, this.desc,
      this.author, this.date, this.parent);

  Future<void> play() async {
    await parent.player.setUrl(music);
    await parent.player.play();
  }

  Future<void> restart() async {
    await parent.player.setUrl(music);
    await parent.player.seek(const Duration(microseconds: 1));
    await parent.player.play();
  }

  Future<void> pause() async {
    await parent.player.pause();
  }
}

abstract class Controller {
  List _keys = <String>['Loading...'];

  List get keys => _keys;
  Model get model;

  void _processKeys() async {
    _keys = model.keys;
  }
}
