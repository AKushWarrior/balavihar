import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peninsulabalvihar/screens/builders/songs/build_song.dart';
import 'package:peninsulabalvihar/screens/builders/title.dart';

import '../../../business/multipage.dart';
import '../../../utils.dart';

class SongParent extends HookWidget {
  final String title;
  final StateNotifierProvider<MultiPageNotifier> provider;
  
  SongParent(this.title, this.provider);
  
  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    children.add(
      PageTitle(title, 48),
    );
    var control = useProvider(provider);

    for (var key in control.read.model.fetchKeys()) {
      var unit = control.read.model.findByKey(key);
      children.add(Neumorphic(
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10.0)),
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: Screen.marginX(context)),
        style: const NeumorphicStyle(
          color: Colors.white,
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
          title: Text(
            unit.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontFamily: GoogleFonts.oswald().fontFamily,
              fontSize: 20,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            control.selected = control.read.model.findByKey(key);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return ChildSongScaffold(unit, control.read);
              }
            ));
          },
        ),
      ));
    }
    return ListView(children: children);
  }
  
}

List<Widget> songParent(String title, StateNotifierProvider<MultiPageNotifier> provider, BuildContext ctxt) {
  
}
