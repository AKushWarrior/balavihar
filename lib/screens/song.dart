import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../business/bhajans.dart';
import '../business/general.dart';
import '../business/patriotic.dart';
import '../business/shlokams.dart';

class SongPage extends StatelessWidget {
  final SongType type;

  SongPage(this.type);

  Widget build(context) {
    Controller control = mapTypes[type];
    return GetBuilder<Controller>(init: control, builder: (Controller val) {

    });
  }
}

enum SongType { patriotic, bhajan, shlokam }

final Map<SongType, Controller> mapTypes = {
  SongType.shlokam: shlokamController,
  SongType.bhajan: bhajanController,
  SongType.patriotic: patrioticController,
};

final shlokamController = ShlokamController();
final bhajanController = BhajanController();
final patrioticController = PatrioticController();