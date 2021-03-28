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

  Widget _buttonList(
      BuildContext context, SongController controller, SongNotifier notifier) {
    if (controller.base.verses.length == 1) {
      return createBottomButton(
        context: context,
        content: controller.isPlaying ? 'Pause' : 'Play',
        swatch: Colors.red,
        isActive: true,
        onPressed: controller.isPlaying ? notifier.pause : notifier.play,
        expand: true,
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
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
      );
    }
  }

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
        padding: EdgeInsets.symmetric(horizontal: Screen.marginX(context)),
        height: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SeekingProgressBar(controller.model.player, controller),
            _buttonList(context, controller, notifier),
          ],
        ),
      ),
    );
  }
}
