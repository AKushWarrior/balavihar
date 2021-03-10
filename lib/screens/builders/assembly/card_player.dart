import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:peninsulabalvihar/business/page.dart';
import 'package:peninsulabalvihar/utils.dart';

class AssemblyCard extends HookWidget {
  final AssemblyNotifier notifier;
  final AssemblyController controller;
  final SinglePageUnit unit;
  final int index;

  AssemblyCard(this.notifier, this.controller, this.unit, this.index);

  @override
  Widget build(BuildContext context) {
    var controller = notifier.read;

    var title = '${unit.key}: ${unit.lyrics[0]}';
    var lyrics = unit.lyrics;
    final childrenList = <Widget>[];
    for (final txt in lyrics) {
      childrenList.add(Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Text(txt, style: const TextStyle(color: Colors.black))));
    }
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Screen.borderRadius)),
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: Screen.marginX(context)),
      color: Colors.white,
      child: Container(
        child: ExpansionTile(
          maintainState: false,
          key: PageStorageKey<String>('$index'),
          tilePadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 7.5),
          initiallyExpanded: controller.expanded[index],
          leading: controller.expanded[index]
              ? const Icon(Icons.arrow_drop_down)
              : const Icon(Icons.arrow_right),
          trailing: Container(
            width: 90,
            child:
            IconButton(
              icon: controller.playing[index]
                  ? const Icon(Icons.pause)
                  : const Icon(Icons.play_arrow),
              onPressed: controller.playingAll
                  ? null
                  : controller.playing[index]
                  ? () {
                controller.model.player.stop();
                notifier.setPlaying(index, false);
                controller.highlighted = null;
              }
                  : () {
                unit.play();
                notifier.setPlaying(index, true);
                controller.highlighted = index;
              },
              color:
              controller.playingAll ? Colors.grey[100] : Colors.grey[600],
            ),
          ),
          onExpansionChanged: (b) {
            if (b) {
              notifier.setExpanded(index, true);
            } else {
              notifier.setExpanded(index, false);
            }
          },
          title: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: controller.highlighted != index
                  ? Colors.black
                  : Colors.orange[800],
              decorationColor: Colors.orange,
            ),
          ),
          //subtitle: Text(subtitle),
          children: childrenList,
        ),
      ),
    );
  }
}