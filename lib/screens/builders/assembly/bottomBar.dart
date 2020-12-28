import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peninsulabalvihar/business/page.dart';
import 'dart:io' show Platform;

Widget bottomBarBuilder(SinglePageController controller) {
  return Neumorphic(
    style: NeumorphicStyle(color: Colors.white),
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10.0)),
    child: Container(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Divider(
            color: Colors.black,
            height: 1,
            thickness: 1,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: Get.height / 75),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NeumorphicButton(
                  style: NeumorphicStyle(
                    color: Colors.white,
                    depth: controller.playingAll ||
                            !controller.playing.contains(true)
                        ? null
                        : 0,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  margin: EdgeInsets.zero,
                  child: Text(
                    controller.playingAll ? 'Pause All' : 'Play All',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: GoogleFonts.oswald().fontFamily,
                      color: controller.playingAll ||
                              !controller.playing.contains(true)
                          ? Colors.black
                          : Colors.grey[300],
                    ),
                  ),
                  onPressed: controller.playingAll ||
                          !controller.playing.contains(true)
                      ? (controller.playingAll
                          ? controller.pauseAll
                          : controller.playAll)
                      : null,
                ),
                NeumorphicButton(
                  style: NeumorphicStyle(
                    color: Colors.white,
                    depth: controller.restartableAll ? null : 0,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  margin: EdgeInsets.zero,
                  child: Text(
                    'Restart All',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: GoogleFonts.oswald().fontFamily,
                      color: controller.restartableAll
                          ? Colors.black
                          : Colors.grey[300],
                    ),
                  ),
                  onPressed:
                      controller.restartableAll ? controller.restartAll : null,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

double get iosAdj => Platform.isIOS ? 10 : 0;

double zeroIfNegative(double base) => base < 0 ? 0 : base;
