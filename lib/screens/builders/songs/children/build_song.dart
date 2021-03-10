import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:peninsulabalvihar/business/multipage.dart';
import 'package:peninsulabalvihar/screens/builders/songs/children/body_builder.dart';
/**/
import 'package:peninsulabalvihar/screens/builders/title.dart';

import 'bottom_bar.dart';

class ChildSongScaffold extends StatelessWidget {
  final MultiPageUnit unit;
  final MultiPageController control;

  ChildSongScaffold(this.unit, this.control);

  @override
  Widget build(BuildContext context) {
    final childControl = SongController(control.model, control.selected, control);
    final childProvider = generateSongProvider(childControl);
    return ZoomIn(child: Scaffold(
      body: Theme(
        data: Theme.of(context).copyWith(accentColor: Colors.red[700]),
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: Column(
            children: [
              PageTitle(unit.name, 32),
              SongBody(childControl),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.red[700],
      bottomNavigationBar: SongBottomBar(childProvider),
    ));
  }
}
