import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:peninsulabalvihar/business/page.dart';

import 'data/setup.dart';
import 'data/shlokams/shlokams.dart' as shlokams;
import 'data/bhajans/bhajans.dart' as bhajans;
import 'general.dart';

class MultiPageModel extends Model {
  String type;

  MultiPageModel(this.type);

  @override
  List<Map<SongInfo, dynamic>> get songData =>
      type == 'Shlokams' ? shlokams.songData : bhajans.songData;

  @override
  List<String> fetchKeys() => List.generate(songData.length, (index) => '$index');

  @override
  MultiPageUnit findByKey(String key) {
    var song = songData[int.parse(key)];
    List<List<String>> verses = song[SongInfo.verses] as List<List<String>>;
    var prefix = song[SongInfo.prefix] as String;
    print(
        'https://balvihar.s3-us-west-1.amazonaws.com/bhajans/${prefix}/${prefix}_${1}.m4a');
    var subunits = List.generate(
      verses.length,
      (i) => SinglePageUnit(
          '$key.${i + 1}',
          'Verse ${i + 1}',
          'https://balvihar.s3-us-west-1.amazonaws.com/bhajans/${prefix}/${prefix}_${i + 1}.m4a',
          null,
          verses[i],
          null,
          null,
          null,
          this),
    );
    return MultiPageUnit(
      key,
      song[SongInfo.name] as String,
      song[SongInfo.image] as String,
      subunits,
      song[SongInfo.desc] as String,
      song[SongInfo.author] as String,
      song[SongInfo.date] as String,
      this,
    );
  }
}

class MultiPageUnit extends Unit<SinglePageUnit> {
  List<SinglePageUnit> get verses => super.lyrics;

  MultiPageUnit(
      String key,
      String name,
      String imageUrl,
      List<SinglePageUnit> verses,
      String desc,
      String author,
      String date,
      Model model)
      : super(key, name, null, imageUrl, verses, desc, author, date, model);
}

abstract class MultiPageController extends Controller {
  @override
  MultiPageModel get model;

  MultiPageUnit _current;

  MultiPageUnit get selected => _current;
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

class SongController extends Controller {
  MultiPageModel _model;
  MultiPageUnit base;
  MultiPageController parent;
  bool _playing = false;
  int currentVerse = 1;
  StreamSubscription sub;

  bool get isPlaying => _playing;

  @override
  MultiPageModel get model => _model;

  SongController(this._model, this.base, this.parent);
}

class MultiPageNotifier extends StateNotifier<MultiPageController> {
  MultiPageNotifier(MultiPageController control) : super(control) {
    state = state..model.player = AudioPlayer();
  }

  void set selected(MultiPageUnit newUnit) {
    state._current = newUnit;
    state = state..model.player ??= AudioPlayer();
  }

  void onClose() {
    state.model.player?.dispose();
  }

  MultiPageController get read => state;
}

class SongNotifier extends StateNotifier<SongController> {
  SongNotifier(SongController control) : super(control) {
    state.model.player.pause();
    state = state..model.player.setAudioSource(
      ConcatenatingAudioSource(
        children: List.generate(
          state.base.lyrics.length,
              (int i) => AudioSource.uri(
            Uri.parse(state.base.lyrics[i].music),
          ),
        ),
      ),
    );
    state.sub = state.model.player.currentIndexStream.listen((int event) {
      if (event != null) state = state..currentVerse = event + 1;
    });
  }

  void play() {
    state.model.player.play();
    state = state.._playing = true;
  }

  void pause() {
    state.model.player.pause();
    state = state.._playing = false;
  }

  void onClose() {
    state.model.player.pause();
    state = state..sub.cancel();
  }

  SongController get read => state;
}

StateNotifierProvider<MultiPageNotifier> generateMultipageProvider(MultiPageController control) {
  return StateNotifierProvider<MultiPageNotifier>((ref) {
    var notifier = MultiPageNotifier(control);
    ref.onDispose(() => notifier.onClose());
    return notifier;
  });
}

StateNotifierProvider<SongNotifier> generateSongProvider(SongController control) {
  return StateNotifierProvider<SongNotifier>((ref) {
    var notifier = SongNotifier(control);
    ref.onDispose(() => notifier.onClose());
    return notifier;
  });
}

final bhajanProvider = generateMultipageProvider(BhajanController());
final shlokamProvider = generateMultipageProvider(ShlokamController());