import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peninsulabalvihar/screens/utils.dart';

Widget buildTitle(String title, double fontSize) {
  return Container(
    height: 100,
    margin: EdgeInsets.fromLTRB(marginX, 10, marginX, 0),
    alignment: Alignment.center,
    child: Row(children: [
      IconButton(
        icon: NeumorphicIcon(
          Icons.arrow_back_ios,
          size: 36,
          style: const NeumorphicStyle(color: Colors.white),
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
            style: const NeumorphicStyle(color: Colors.white),
          )),
    ]),
  );
}
