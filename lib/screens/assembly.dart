import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

import '../business/assembly.dart';

class AssemblyPage extends StatelessWidget {
  Widget build(context) {
    return GetBuilder<AssemblyController>(
      init: controller,
      builder: (AssemblyController val) {
        return Scaffold(
          body: columnCards(val),
        );
      },
    );
  }
}

final AssemblyController controller = AssemblyController();

Widget columnCards (AssemblyController control) {
  List<Widget> children = [];
  for (var unit in control.model.fetchAll()) {
    children.add(cardBuilder('', '', [], unit, control));
  }
  return Column(children: children);
}

Container cardBuilder([String title, String subtitle, List<String> lyrics, AssemblyUnit unit, AssemblyController controller]) {
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
        trailing: (unit != null && controller.model.isPlaying(unit.music)) ? Icon(Icons.play_circle_filled) : Icon(Icons.pause_circle_filled),
        onExpansionChanged: (b) {
          if (b) {
            if (unit != null) unit.play();
            print('expanded/playing');
          } else {
            if (unit != null) unit.pause();
            print('contracted/pausing');
          }
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
