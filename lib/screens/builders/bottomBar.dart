import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peninsulabalvihar/business/page.dart';

Widget bottomBarBuilder(SinglePageController controller) {
  return Container(
    width: Get.width,
    height: Get.height / 10,
    alignment: Alignment.bottomCenter,
    padding: null,
    child: Center(
      child: ButtonBar(
        children: [
          NeumorphicButton(
            style: NeumorphicStyle(
              color: Colors.white,
            ),
            child: Text(
              'Play All',
              style: TextStyle(
                fontSize: 20,
                fontFamily: GoogleFonts.oswald().fontFamily,
                color: Colors.black,
              ),
            ),
            pressed: controller.playing.contains(true) || controller.playingAll
                ? true
                : null,
            onPressed: controller.playAll,
          ),
          NeumorphicButton(
            style: NeumorphicStyle(
              color: Colors.white,
            ),
            child: Text(
              'Pause All',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: GoogleFonts.oswald().fontFamily,
                  color: Colors.black),
            ),
            pressed: controller.playingAll ? null : true,
            onPressed: controller.pauseAll,
          ),
          NeumorphicButton(
            style: NeumorphicStyle(
              color: Colors.white,
            ),
            child: Text(
              'Restart All',
              style: TextStyle(
                fontSize: 20,
                fontFamily: GoogleFonts.oswald().fontFamily,
                color: Colors.black,
              ),
            ),
            pressed: controller.playingAll ? null : true,
            onPressed: controller.restartAll,
          ),
        ],
      ),
    ),
  );
}
