import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import 'data/setup.dart';
import 'general.dart';

import 'data/assembly.dart';

class AssemblyModel extends Model {
  @override
  List<String> fetchKeys() => (songData).keys.toList();

  @override
  SinglePageUnit findByKey(String key) {
    dynamic song = (songData)[key];
    return SinglePageUnit(
      key,
      song[SongInfo.name] as String,
      song[SongInfo.music] as String,
      song[SongInfo.image] as String,
      song[SongInfo.lyrics] as List<String>,
      song[SongInfo.desc] as String,
      song[SongInfo.author] as String,
      song[SongInfo.date] as String,
      this,
    );
  }
}

class SinglePageUnit extends Unit<String> {
  SinglePageUnit(String key, String name, String music, String imageUrl,
      List<String> lyrics, String desc, String author, String date, Model model)
      : super(key, name, music, imageUrl, lyrics, desc, author, date, model);
}

class AssemblyController extends Controller {
  AssemblyModel _model = AssemblyModel();
  List<bool> expanded;
  List<bool> playing;
  int highlighted;

  bool playingAll;
  bool pausedAll;
  bool restartableAll;
  Timer _timer;

  StreamSubscription streamSub;

  @override
  Model get model => _model;

  AssemblyController clone() {
    return AssemblyController()
      .._model = _model
      ..expanded = expanded
      ..playing = playing
      ..highlighted = highlighted
      ..playingAll = playingAll
      ..pausedAll = pausedAll
      ..restartableAll = restartableAll
      .._timer = _timer
      ..streamSub = streamSub;
  }
}

class AssemblyNotifier extends StateNotifier<AssemblyController> {
  AssemblyNotifier(AssemblyController control) : super(control) {
    state._model.player = AudioPlayer();
    state.playingAll = false;
    state.pausedAll = false;
    state.restartableAll = false;
    state.expanded = List.generate(20, (i) => false);
    state = state.clone()..playing = List.generate(20, (i) => false);
    state.streamSub =
        state._model.player.playbackEventStream.listen((PlaybackEvent event) {
      if (event.processingState == ProcessingState.completed) {
        state.playingAll = false;
        state.expanded = List.generate(20, (i) => false);
        state.playing = List.generate(20, (i) => false);
        state = state.clone()..highlighted = null;
      }
    });
  }

  void onClose() {
    state._model.player.stop();
    state.streamSub.cancel();
    state = state.clone().._model.player.dispose();
  }

  void setExpanded(int index, bool newVal) {
    state = state.clone()..expanded[index] = newVal;
  }

  void setPlaying(int index, bool newVal) {
    state.playing = List.generate(20, (i) => false);
    state.restartableAll = false;
    state = state.clone()..playing[index] = newVal;
  }

  void playAll() {
    state.playingAll = true;
    state.playing = List.generate(20, (i) => false);
    state = state.clone()..restartableAll = true;
    if (!state.pausedAll) {
      state.model.player.setAudioSource(
        ConcatenatingAudioSource(
            children: List.generate(
                songData.length,
                (int i) => AudioSource.uri(Uri.parse(
                    songData.values.toList()[i][SongInfo.music] as String)))),
      );
    }
    state.pausedAll = false;
    state.model.player.currentIndexStream.listen((event) {
      state.highlighted = event;
    });
    state = state.clone()..model.player.play();
  }

  void pauseAll() {
    state.playingAll = false;
    state.highlighted = null;
    state.restartableAll = true;
    state.playing = List.generate(20, (i) => false);
    state.model.player.pause();
    state = state.clone()..pausedAll = true;
  }

  void restartAll() {
    state = state.clone()..pausedAll = false;
    playAll();
  }

  AssemblyController get read => state;
}

StateNotifierProvider<AssemblyNotifier> generateAssemblyProvider(
    AssemblyController control) {
  return StateNotifierProvider<AssemblyNotifier>((ref) {
    var notifier = AssemblyNotifier(control);
    ref.onDispose(() => notifier.onClose());
    return notifier;
  });
}

StateNotifierProvider<AssemblyNotifier> assemblyProvider =
    generateAssemblyProvider(AssemblyController());
