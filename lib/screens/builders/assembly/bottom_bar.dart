import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peninsulabalvihar/business/page.dart';
import 'package:peninsulabalvihar/screens/utils.dart';

Widget bottomBarBuilder(SinglePageController controller) {
  return Container(height: 145, child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const Divider(
        color: Colors.black,
        thickness: 1,
        height: 1,
      ),
      Neumorphic(
        margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: marginX),
        style: const NeumorphicStyle(color: Colors.white),
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10.0)),
        child: Container(
          height: 100,
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
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
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                margin: EdgeInsets.zero,
                onPressed:
                    controller.playingAll || !controller.playing.contains(true)
                        ? (controller.playingAll
                            ? controller.pauseAll
                            : controller.playAll)
                        : null,
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
              ),
              NeumorphicButton(
                style: NeumorphicStyle(
                  color: Colors.white,
                  depth: controller.restartableAll ? null : 0,
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                margin: EdgeInsets.zero,
                onPressed:
                    controller.restartableAll ? controller.restartAll : null,
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
              ),
            ],
          ),
        ),
      ),
    ],
  ));
}
