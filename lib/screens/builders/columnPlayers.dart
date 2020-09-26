import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../business/general.dart';
import 'cardPlayer.dart';

List<Widget> columnCards(String title, Controller control) {
  List<Widget> children = [];
  children.add(
    Container(
      height: 100,
      margin: EdgeInsets.fromLTRB(5, 10, 10, 0),
      child: Row(/*mainAxisAlignment: MainAxisAlignment.spaceBetween,*/ children: [
        IconButton(
          icon: NeumorphicIcon(
            Icons.arrow_back_ios,
            size: 36,
            style: NeumorphicStyle(color: Colors.white),
            //color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
        Container(width: Get.width/50),
        Container(
            alignment: Alignment.center,
            child: NeumorphicText(
              title,
              textStyle: NeumorphicTextStyle(
                fontFamily: GoogleFonts.oswald().fontFamily,
                fontSize: 48,
              ),
              style: NeumorphicStyle(color: Colors.white),
            )),
      ]),
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
