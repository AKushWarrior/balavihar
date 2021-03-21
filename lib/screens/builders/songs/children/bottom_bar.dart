import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peninsulabalvihar/business/multipage.dart';
import 'package:peninsulabalvihar/screens/builders/bottomButton.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                child: SeekingProgressBar(controller.model.player, controller)),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  createBottomButton(
                    context: context,
                    content: 'Prev.',
                    swatch: Colors.red,
                    isActive: controller.model.player.hasPrevious,
                    onPressed: controller.model.player.hasPrevious
                        ? controller.model.player.seekToPrevious
                        : null,
                  ),
                  createBottomButton(
                    context: context,
                    content: controller.isPlaying ? 'Pause' : 'Play',
                    swatch: Colors.red,
                    isActive: true,
                    onPressed: controller.isPlaying ? notifier.pause : notifier.play,
                  ),
                  createBottomButton(
                    context: context,
                    content: 'Next',
                    swatch: Colors.red,
                    isActive: controller.model.player.hasNext,
                    onPressed: controller.model.player.hasNext
                        ? controller.model.player.seekToNext
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
