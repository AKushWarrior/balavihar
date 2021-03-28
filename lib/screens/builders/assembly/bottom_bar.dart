import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peninsulabalvihar/business/page.dart';
import 'package:peninsulabalvihar/screens/builders/bottomButton.dart';
import 'package:peninsulabalvihar/utils.dart';

class AssemblyBottomBar extends HookWidget {
  AssemblyBottomBar();

  @override
  Widget build(BuildContext context) {
    var notifier = useProvider(assemblyProvider);
    var controller = useProvider(assemblyProvider.state);
    return Container(
        height: 145,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Divider(
              color: Colors.black,
              thickness: 1,
              height: 1,
            ),
            Card(
              margin: EdgeInsets.symmetric(
                  vertical: 20.0, horizontal: Screen.marginX(context)),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Screen.borderRadius)),
              child: Container(
                height: 100,
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    createBottomButton(
                      context: context,
                      content: controller.playingAll ? 'Pause All' : 'Play All',
                      swatch: Colors.orange,
                      isActive: controller.playingAll ||
                          !controller.playing.contains(true),
                      onPressed: controller.playingAll ||
                              !controller.playing.contains(true)
                          ? (controller.playingAll
                              ? notifier.pauseAll
                              : notifier.playAll)
                          : null,
                    ),
                    createBottomButton(
                      context: context,
                      content: 'Restart All',
                      swatch: Colors.orange,
                      isActive: controller.restartableAll,
                      onPressed: controller.restartableAll
                          ? notifier.restartAll
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
