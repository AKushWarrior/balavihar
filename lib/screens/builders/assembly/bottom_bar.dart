import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peninsulabalvihar/business/page.dart';
import 'package:peninsulabalvihar/utils.dart';

class AssemblyBottomBar extends HookWidget {
  AssemblyBottomBar();

  @override
  Widget build(BuildContext context) {
    var notifier = useProvider(assemblyProvider);
    var controller = useProvider(assemblyProvider.state);
    return Container(height: 145, child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Divider(
          color: Colors.black,
          thickness: 1,
          height: 1,
        ),
        Card(
          margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: Screen.marginX(context)),
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Screen.borderRadius)),
          child: Container(
            height: 100,
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                    //depth: controller.playingAll || !controller.playing.contains(true) ? null : 0,
                  onPressed:
                  controller.playingAll || !controller.playing.contains(true)
                      ? (controller.playingAll
                      ? notifier.pauseAll
                      : notifier.playAll)
                      : null,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                  ),),
                ),
                OutlinedButton(
                  onPressed: controller.restartableAll ? notifier.restartAll : null,
                  style: OutlinedButton.styleFrom(primary: Colors.orange),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
