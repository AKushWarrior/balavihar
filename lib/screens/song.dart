import 'package:flutter/material.dart';
import '../business/multipage.dart';
import 'builders/songs/song_page.dart';

class SongPage extends StatelessWidget {
  final SongType type;

  const SongPage(this.type);

  @override
  Widget build(BuildContext context) {
    final MultiPageController control =
        type == SongType.bhajans ? BhajanController() : ShlokamController();
    final provider = generateMultipageProvider(control);
    return Scaffold(
      backgroundColor: Colors.red[700],
      body: type == SongType.bhajans
          ? SongParent('Bhajans', provider)
          : null,
    );
  }
}

enum SongType { bhajans, shlokams }
