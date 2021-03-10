import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peninsulabalvihar/business/multipage.dart';
import 'package:peninsulabalvihar/screens/builders/songs/children/seekbar.dart';

import '../../../../utils.dart';

class SongBottomBar extends HookWidget {
  final StateNotifierProvider<SongNotifier> provider;

  SongBottomBar(this.provider);

  @override
  Widget build(BuildContext context) {
    var notifier = useProvider(provider);
    var controller = notifier.read;
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(
          vertical: 15.0, horizontal: Screen.marginX(context)),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Screen.borderRadius)),
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          height: 175,
          child: Column(children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Playing: Verse #${controller.currentVerse}',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: GoogleFonts.oswald().fontFamily,
                    fontSize: 16),
              ),
            ),
            SeekingProgressBar(controller.model.player),
            Container(
              margin:
                  EdgeInsets.symmetric(vertical: Screen.height(context) / 75),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: controller.model.player.hasPrevious
                        ? controller.model.player.seekToPrevious
                        : null,
                    child: Container(
                      color: Colors.white,
                      //depth: controller.model.player.hasPrevious ? null : 0,
                      padding: const EdgeInsets.symmetric(
                          vertical: 11, horizontal: 25),
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
                    ),
                  ),
                  OutlinedButton(
                    onPressed:
                        controller.isPlaying ? notifier.pause : notifier.play,
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 25),
                      child: Text(
                        controller.isPlaying ? 'Pause' : 'Play',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: GoogleFonts.oswald().fontFamily,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: controller.model.player.hasNext
                        ? controller.model.player.seekToNext
                        : null,
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 25),
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
                    ),
                  ),
                ],
              ),
            ),
          ])),
    );
  }
}
