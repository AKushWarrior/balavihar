import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../business/general.dart';
import 'cardPlayer.dart';

List<Widget> columnCards(String title, Controller control) {
  List<Widget> children = [];
  children.add(
    Container(
      height: 100,
      margin: EdgeInsets.all(10.0),
      child: NeumorphicText(
        title,
        textStyle: NeumorphicTextStyle(
          fontFamily: GoogleFonts.oswald().fontFamily,
          fontSize: 48,
        ),
        style: NeumorphicStyle(color: Colors.white),
      ),
      alignment: Alignment.center,
    ),
  );
  var i = 0;
  for (var unit in control.model.fetchAll()) {
    children.add(cardBuilder('', '', [], unit, control, i));
    i++;
  }
  return children;
}
