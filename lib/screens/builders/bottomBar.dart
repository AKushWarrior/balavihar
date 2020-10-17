import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peninsulabalvihar/business/page.dart';

Widget bottomBarBuilder(SinglePageController controller) {
  return Container(
    height: Get.height * 0.15,
    alignment: Alignment.center,
    child: BottomAppBar(
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Divider(
          color: Colors.black,
          height: 1,
          thickness: 1,
        ),
        Container(
          margin: EdgeInsets.all(10.0),
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
                onPressed:
                    controller.playingAll || !controller.playing.contains(true)
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
      ]),
    ),
  );
}
