import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:peninsulabalvihar/screens/builders/assembly/bottom_bar.dart';
import 'package:peninsulabalvihar/themes/assembly.dart';

import 'builders/assembly/column_players.dart';

class AssemblyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      child: Scaffold(
          backgroundColor: Colors.orange[800],
          body: Theme(
            data: assemblyTheme(context),
            child: Container(
              color: Colors.orange[800],
              child: AssemblyCardColumn('Assembly'),
            ),
          ),
          bottomNavigationBar: AssemblyBottomBar(),
        ),
      );
  }
}
