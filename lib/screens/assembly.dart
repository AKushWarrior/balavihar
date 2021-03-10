import 'package:flutter/material.dart';
import 'package:peninsulabalvihar/business/data/assembly.dart' as data;
import 'package:peninsulabalvihar/screens/builders/assembly/bottom_bar.dart';

import '../business/page.dart';
import 'builders/assembly/column_players.dart';

class AssemblyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = AssemblyController();
    controller.model.songData = data.songData;
    var provider = generateAssemblyProvider(controller);
    return Scaffold(
      backgroundColor: Colors.orange[800],
      body: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.orange[800]),
            child: Container(
              color: Colors.orange[800],
              child: AssemblyCardColumn(provider, 'Assembly'),
            ),
      ),
      bottomNavigationBar: AssemblyBottomBar(provider),
    );
  }
}
