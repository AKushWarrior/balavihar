import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peninsulabalvihar/screens/builders/songs/buildSong.dart';
import 'package:peninsulabalvihar/screens/builders/title.dart';

import '../../../business/multipage.dart';

List<Widget> songParent(String title, MultiPageController control) {
  List<Widget> children = [];
  children.add(
    buildTitle(title, 48),
  );
  for (var key in control.model.fetchKeys()) {
    var unit = control.model.findByKey(key);
    children.add(
        Neumorphic(
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10.0)),
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          style: NeumorphicStyle(
            color: Colors.white,
          ),
          child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
            title: Text(
              unit.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: GoogleFonts.oswald().fontFamily,
                  fontSize: 20,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              control.selected = control.model.findByKey(key);
              Get.to(childSongScaffold(unit, control));
            },
          ),
        ));
  }
  return children;
}