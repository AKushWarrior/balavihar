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
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10.0)),
    child: Container(
        height: 145,
        child: Column(children: [
          Container(
          child: Text(
            'Playing: Verse #${controller.currentVerse}',
            style: TextStyle(
                color: Colors.black,
                fontFamily: GoogleFonts.oswald().fontFamily,
                fontSize: 16),
          ), margin: EdgeInsets.symmetric(vertical: 10.0),),
          SeekingProgressBar(controller.model.player),
          Container(
            margin: EdgeInsets.symmetric(vertical: Get.height / 75),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NeumorphicButton(
                  style: NeumorphicStyle(
                    color: Colors.white,
                    depth: controller.model.player.hasPrevious ? null : 0,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  margin: EdgeInsets.zero,
                  child: Text(
                    'Prev.',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: GoogleFonts.oswald().fontFamily,
                      color: controller.model.player.hasPrevious
                          ? Colors.black
                          : Colors.grey[300],
                    ),
                  ),
                  onPressed: controller.model.player.hasPrevious
                      ? controller.model.player.seekToPrevious
                      : null,
                ),
                NeumorphicButton(
                  style: NeumorphicStyle(
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  margin: EdgeInsets.zero,
                  child: Text(
                    controller.isPlaying ? 'Pause' : 'Play',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: GoogleFonts.oswald().fontFamily,
                      color: Colors.black,
                    ),
                  ),
                  onPressed:
                      controller.isPlaying ? controller.pause : controller.play,
                ),
                NeumorphicButton(
                  style: NeumorphicStyle(
                    color: Colors.white,
                    depth: controller.model.player.hasNext ? null : 0,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  margin: EdgeInsets.zero,
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: GoogleFonts.oswald().fontFamily,
                      color: controller.model.player.hasNext
                          ? Colors.black
                          : Colors.grey[300],
                    ),
                  ),
                  onPressed: controller.model.player.hasNext
                      ? controller.model.player.seekToNext
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