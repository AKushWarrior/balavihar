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

  static final AudioPlayer player = AudioPlayer();
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

  Unit(this.key, this.name, this.music, this.imageUrl, this.lyrics, this.desc,
      this.author, this.date);

  Future<void> play() async {
    if (!(Model.player.icyMetadata.info.url == music)) {
      await Model.player.setUrl(music);
    }

    Model.player.play();
  }

  Future<void> restart() async {
    if (!(Model.player.icyMetadata.info.url == music)) {
      await Model.player.setUrl(music);
    }

    await Model.player.seek(Duration(microseconds: 1));
    Model.player.play();
  }

  Future<void> pause() async {
    if ((Model.player.icyMetadata.info.url == music)) {
      await Model.player.pause();
    }
  }
}

class SubUnit {
  String lyric;
  String music;
  String key;

  SubUnit(this.key, this.lyric, this.music);

  @override
  String toString() => lyric.toString();

  Future<void> play() async {
    if (!(Model.player.icyMetadata.info.url == music)) {
      await Model.player.setUrl(music);
    }

    Model.player.play();
  }

  Future<void> restart() async {
    if (!(Model.player.icyMetadata.info.url == music)) {
      await Model.player.setUrl(music);
    }

    await Model.player.seek(Duration(microseconds: 1));
    Model.player.play();
  }

  Future<void> pause() async {
    if ((Model.player.icyMetadata.info.url == music)) {
      await Model.player.pause();
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
    _keys = await model.keys;
  }
}
