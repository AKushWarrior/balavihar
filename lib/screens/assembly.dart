import 'package:flutter/material.dart';
import 'package:peninsulabalvihar/screens/builders/assembly/bottom_bar.dart';

import 'builders/assembly/column_players.dart';

class AssemblyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[800],
      body: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.orange[800]),
            child: Container(
              color: Colors.orange[800],
              child: AssemblyCardColumn('Assembly'),
            ),
      ),
      bottomNavigationBar: AssemblyBottomBar(),
    );
  }
}
