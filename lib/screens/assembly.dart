import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peninsulabalvihar/screens/builders/bottomBar.dart';

import '../business/page.dart';
import 'builders/columnPlayers.dart';
import 'package:peninsulabalvihar/business/data/assembly.dart' as data;

class AssemblyPage extends StatelessWidget {
  Widget build(context) {
    var controller = SinglePageController();
    controller.model.songData = data.songData;
    return Scaffold(
      body: GetBuilder<SinglePageController>(
        init: controller,
        builder: (SinglePageController val) {
          return Container(
            color: Colors.orange[800],
            child: ListView(
              children: columnCards('Assembly', val),
            ),
          );
        },
      ),
      bottomNavigationBar: GetBuilder(init: controller, builder: (val) => bottomBarBuilder(val)),
    );
  }
}
