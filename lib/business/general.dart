import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

abstract class Model {
  List<String> _keys;

  List<String> get keys {
    if (_keys == null) {
      _keys = fetchKeys();
    }
    return _keys;
  }

  List<String> fetchKeys();

  Unit findByKey(String key);

  List<Unit> fetchAll() => List.generate(keys.length, (i) => findByKey(keys[i]));

  AudioPlayer player;

  bool isPlaying (String music) => player.icyMetadata.info.url == music;
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
    if (!(parent.player.icyMetadata.info.url == music)) {
      await parent.player.setUrl(music);
    }

    parent.player.play();
  }

  Future<void> restart() async {
    if (!(parent.player.icyMetadata.info.url == music)) {
      await parent.player.setUrl(music);
    }

    await parent.player.seek(Duration(microseconds: 1));
    parent.player.play();
  }

  Future<void> pause() async {
    if ((parent.player.icyMetadata.info.url == music)) {
      await parent.player.pause();
    }
  }
}

class SubUnit {
  String lyric;
  String music;
  String key;
  Model grandparent;

  SubUnit(this.key, this.lyric, this.music, this.grandparent);

  @override
  String toString() => lyric.toString();

  Future<void> play() async {
    if (!(grandparent.player.icyMetadata.info.url == music)) {
      await grandparent.player.setUrl(music);
    }

    grandparent.player.play();
  }

  Future<void> restart() async {
    if (!(grandparent.player.icyMetadata.info.url == music)) {
      await grandparent.player.setUrl(music);
    }

    await grandparent.player.seek(Duration(microseconds: 1));
    grandparent.player.play();
  }

  Future<void> pause() async {
    if ((grandparent.player.icyMetadata.info.url == music)) {
      await grandparent.player.pause();
    }
  }
}

abstract class Controller extends GetController {
  List _keys = ['Loading...'];

  List get keys => _keys;
  Model get model;

  @override
  void onInit() {
    _processKeys();
  }

  @override
  void onClose() {
    super.dispose();
  }

  void _processKeys() async {
    _keys = model.keys;
  }
}
