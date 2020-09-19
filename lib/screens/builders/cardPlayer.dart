import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:peninsulabalvihar/business/page.dart';

import '../../business/general.dart';

Container cardBuilder(
    [String title,
      String subtitle,
      List<String> lyrics,
      SinglePageUnit unit,
      SinglePageController controller,
      int index]) {
  if (unit != null) {
    title = unit.lyrics[0];
    subtitle = unit.key + ': ' + unit.name;
    lyrics = unit.lyrics;
  }
  List<Widget> childrenList = [];
  for (var txt in lyrics) {
    childrenList.add(Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Text(txt, style: TextStyle(color: Colors.black))));
  }
  return Container(
    child: Neumorphic(
      style: NeumorphicStyle(color: Colors.white),
      child: ExpansionTile(
        leading: controller.expanded[index]
            ? Icon(Icons.arrow_drop_down)
            : Icon(Icons.arrow_right),
        trailing: Container(
            width: 125,
            child: ButtonBar(children: [
              IconButton(
                  icon: controller.playing[index]
                      ? Icon(Icons.refresh)
                      : Icon(Icons.play_arrow),
                  onPressed: controller.playingAll ? null : () {
                    unit.play();
                    controller.setPlaying(index, true);
                  },
                  disabledColor: Colors.grey,
              ),
              IconButton(
                  icon: Icon(Icons.pause),
                  onPressed: controller.playingAll ? null : () {
                    controller.model.player.stop();
                    controller.setPlaying(index, false);
                  },
                disabledColor: Colors.grey,
                  ),
            ])),
        onExpansionChanged: (b) {
          if (b)
            controller.setExpanded(index, true);
          else
            controller.setExpanded(index, false);
        },
        title: Text(
          title,
          style: TextStyle(color: Colors.black, decorationColor: Colors.orange),
        ),
        subtitle: Text(subtitle),
        children: childrenList,
      ),
    ),
  );
}