import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../business/general.dart';
import '../business/multipage.dart';
import 'builders/songs/songPage.dart';

class SongPage extends StatelessWidget {
  final SongType type;

  SongPage(this.type);

  Widget build(context) {
    MultiPageController control =
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
