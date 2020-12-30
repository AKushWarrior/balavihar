import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:peninsulabalvihar/business/multipage.dart';
import 'package:peninsulabalvihar/screens/builders/songs/bodyBuilder.dart';
/**/
import 'package:peninsulabalvihar/screens/builders/title.dart';

import 'bottomBar.dart';

Widget childSongScaffold(MultiPageUnit unit, MultiPageController control) {
  var childControl =
      SinglePageSongController(control.model, control.selected, control);
  return GetBuilder(
    init: childControl,
    builder: (SinglePageSongController val) => Scaffold(
      body: Theme(
        data: Get.theme.copyWith(accentColor: Colors.red[700]),
        child: Container(
          child: _buildMain(unit, val),
          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
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
