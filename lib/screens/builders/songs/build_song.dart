import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:peninsulabalvihar/business/multipage.dart';
import 'package:peninsulabalvihar/screens/builders/songs/body_builder.dart';
/**/
import 'package:peninsulabalvihar/screens/builders/title.dart';

import 'bottom_bar.dart';

Widget childSongScaffold(MultiPageUnit unit, MultiPageController control) {
  final childControl =
      SinglePageSongController(control.model, control.selected, control);
  return GetBuilder(
    init: childControl,
    builder: (SinglePageSongController val) => Scaffold(
      body: Theme(
        data: Get.theme.copyWith(accentColor: Colors.red[700]),
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: _buildMain(unit, val),
        ),
      ),
      backgroundColor: Colors.red[700],
      bottomNavigationBar: bottomBarBuilder(val),
    ),
  );
}

Widget _buildMain(MultiPageUnit unit, SinglePageSongController control) {
  return Column(
    children: [
      buildTitle(unit.name, 32),
      bodyBuilder(control),
    ],
  );
}
