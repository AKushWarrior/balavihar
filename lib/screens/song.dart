import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../business/general.dart';
import '../business/multipage.dart';
import 'builders/songs/song_page.dart';

class SongPage extends StatelessWidget {
  final SongType type;

  const SongPage(this.type);

  @override
  Widget build(BuildContext context) {
    final MultiPageController control =
        type == SongType.bhajans ? BhajanController() : ShlokamController();
    return Scaffold(
        backgroundColor: Colors.red[700],
        body: GetBuilder<Controller>(
            init: control,
            builder: (Controller val) {
              if (type == SongType.bhajans) {
                return ListView(
                    children:
                        songParent('Bhajans', val as MultiPageController));
              }
              return null;
            }));
  }
}

enum SongType { bhajans, shlokams }
