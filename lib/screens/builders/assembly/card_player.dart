import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:peninsulabalvihar/business/page.dart';

Widget cardBuilder(
    [String title,
    String subtitle,
    List<String> lyrics,
    SinglePageUnit unit,
    SinglePageController controller,
    int index]) {
  if (unit != null) {
    title = '${unit.key}: ${unit.lyrics[0]}';
    subtitle = unit.desc;
    lyrics = unit.lyrics;
  }
  final List<Widget> childrenList = [];
  for (final txt in lyrics) {
    childrenList.add(Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Text(txt, style: const TextStyle(color: Colors.black))));
  }
  return Neumorphic(
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10.0)),
    margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    style: const NeumorphicStyle(
      color: Colors.white,
    ),
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
                            controller.setPlaying(index, false);
                            controller.highlighted = null;
                          }
                        : () {
                            unit.play();
                            controller.setPlaying(index, true);
                            controller.highlighted = index;
                          },
                color:
                    controller.playingAll ? Colors.grey[100] : Colors.grey[600],
              ),
            ),
        onExpansionChanged: (b) {
          if (b) {
            controller.setExpanded(index, true);
          } else {
            controller.setExpanded(index, false);
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
