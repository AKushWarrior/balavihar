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
    var controller = useProvider(provider.state);
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(
          vertical: 15.0, horizontal: Screen.marginX(context)),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Screen.borderRadius)),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 160,
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Container(
                child: SeekingProgressBar(controller.model.player, controller)),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: controller.model.player.hasPrevious
                        ? controller.model.player.seekToPrevious
                        : null,
                    child: Container(
                      //depth: controller.model.player.hasPrevious ? null : 0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
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
                      margin: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
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
                      margin: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
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
