import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../business/assembly.dart';

class AssemblyPage extends StatelessWidget {
  Widget build(context) {
    return GetBuilder<AssemblyController>(
      init: AssemblyController(),
      builder: (AssemblyController val) {
        return Scaffold(
          body: Column(children: columnCards(val)),
        );
      },
    );
  }
}

List<Widget> columnCards(AssemblyController control) {
  List<Widget> children = [];
  children.add(
    Container(
      height: 100,
      child: NeumorphicText('Assembly',
          textStyle: NeumorphicTextStyle(
              fontFamily: GoogleFonts.oswald().fontFamily, fontSize: 48),
          style: NeumorphicStyle(color: Colors.white)),
      alignment: Alignment.center,
    ),
  );
  var i = 0;
  for (var unit in control.model.fetchAll()) {
    children.add(cardBuilder('', '', [], unit, control, i));
    i++;
  }
  return children;
}

Container cardBuilder(
    [String title,
    String subtitle,
    List<String> lyrics,
    AssemblyUnit unit,
    AssemblyController controller,
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
                  onPressed: () {
                    unit.play();
                    controller.setPlaying(index, true);
                  }),
              IconButton(
                  icon: Icon(Icons.stop),
                  onPressed: () {
                    controller.model.player.stop();
                    controller.setPlaying(index, false);
                  }),
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
