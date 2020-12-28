import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildTitle(String title, double fontSize) {
  return Container(
    height: 100,
    margin: EdgeInsets.fromLTRB(5, 10, 10, 0),
    child: Row(children: [
      IconButton(
        icon: NeumorphicIcon(
          Icons.arrow_back_ios,
          size: 36,
          style: NeumorphicStyle(color: Colors.white),
          //color: Colors.white,
        ),
        onPressed: () => Get.back(),
      ),
      Container(width: Get.width / 50),
      Container(
          alignment: Alignment.center,
          child: NeumorphicText(
            title,
            textStyle: NeumorphicTextStyle(
              fontFamily: GoogleFonts.oswald().fontFamily,
              fontSize: fontSize,
            ),
            style: NeumorphicStyle(color: Colors.white),
          )),
    ]),
    alignment: Alignment.center,
  );
}
