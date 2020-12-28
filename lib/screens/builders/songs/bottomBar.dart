import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peninsulabalvihar/business/multipage.dart';
import 'dart:io' show Platform;

import 'package:peninsulabalvihar/screens/builders/songs/seekbar.dart';

Widget bottomBarBuilder(SinglePageSongController controller) {
  return Neumorphic(
    style: NeumorphicStyle(color: Colors.white),
    margin: EdgeInsets.all(15.0),
    padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10.0)),
    child: Container(
        height: 110,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SeekingProgressBar(controller.model.player),
          Container(
            margin: EdgeInsets.symmetric(vertical: Get.height/75),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NeumorphicButton(
                  style: NeumorphicStyle(
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  margin: EdgeInsets.zero,
                  child: Text(
                    controller.isPlaying ? 'Pause': 'Play',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: GoogleFonts.oswald().fontFamily,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: controller.isPlaying
                      ? controller.pause
                      : controller.play,
                ),
                NeumorphicButton(
                  // TODO: Fix restart logic
                  style: NeumorphicStyle(
                    color: Colors.white,
                    depth: controller.isPlaying ? null : 0,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  margin: EdgeInsets.zero,
                  child: Text(
                    'Restart',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: GoogleFonts.oswald().fontFamily,
                      color: controller.isPlaying
                          ? Colors.black
                          : Colors.grey[300],
                    ),
                  ),
                  onPressed: controller.isPlaying
                      ? () => controller.model.player.seek(Duration.zero)
                      : null,
                ),
              ],
            ),
          ),
        ])),
  );
}

double get iosAdj => Platform.isIOS ? 10 : 0;

double zeroIfNegative(double base) => base < 0 ? 0 : base;
