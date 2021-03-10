import 'package:flutter/material.dart';
import '../business/multipage.dart';
import 'builders/songs/parent/song_page.dart';

class SongPage extends StatelessWidget {
  final SongType type;

  const SongPage(this.type);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red[700],
        body: Theme(
          data: Theme.of(context).copyWith(accentColor: Colors.red[700]),
          child: type == SongType.bhajans
              ? SongParent('Bhajans', bhajanProvider)
              : null,
        ),
      );
  }
}

enum SongType { bhajans, shlokams }
