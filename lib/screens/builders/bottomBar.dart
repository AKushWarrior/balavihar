import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peninsulabalvihar/business/page.dart';

Widget bottomBarBuilder(SinglePageController controller) {
  return BottomAppBar(
    child: Container(
      margin: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NeumorphicButton(
            style: NeumorphicStyle(
              color: Colors.white,
              depth:
                  !controller.playing.contains(true) && !controller.playingAll
                      ? null
                      : 0,
            ),
            child: Text(
              'Play All',
              style: TextStyle(
                fontSize: 20,
                fontFamily: GoogleFonts.oswald().fontFamily,
                color:
                    controller.playing.contains(true) || controller.playingAll
                        ? Colors.grey[300]
                        : Colors.black,
              ),
            ),
            onPressed:
                controller.playing.contains(true) || controller.playingAll
                    ? null
                    : controller.playAll,
          ),
          NeumorphicButton(
            style: NeumorphicStyle(
              color: Colors.white,
              depth: controller.playingAll ? null : 0,
            ),
            child: Text(
              'Pause All',
              style: TextStyle(
                fontSize: 20,
                fontFamily: GoogleFonts.oswald().fontFamily,
                color: controller.playingAll ? Colors.black : Colors.grey[300],
              ),
            ),
            onPressed: controller.playingAll ? controller.pauseAll : null,
          ),
          NeumorphicButton(
            style: NeumorphicStyle(
              color: Colors.white,
              depth: controller.playingAll || controller.pausedAll ? null : 0,
            ),
            child: Text(
              'Restart All',
              style: TextStyle(
                fontSize: 20,
                fontFamily: GoogleFonts.oswald().fontFamily,
                color: controller.playingAll || controller.pausedAll
                    ? Colors.black
                    : Colors.grey[300],
              ),
            ),
            onPressed: controller.playingAll || controller.pausedAll
                ? controller.restartAll
                : null,
          ),
        ],
      ),
    ),
  );
}
