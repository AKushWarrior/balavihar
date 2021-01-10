import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peninsulabalvihar/business/data/assembly.dart' as data;
import 'package:peninsulabalvihar/screens/builders/assembly/bottom_bar.dart';

import '../business/page.dart';
import 'builders/assembly/column_players.dart';

class AssemblyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = SinglePageController();
    controller.model.songData = data.songData;
    return Scaffold(
      backgroundColor: Colors.orange[800],
      body: GetBuilder<SinglePageController>(
        init: controller,
        builder: (SinglePageController val) {
          return Theme(
            data: Get.theme.copyWith(accentColor: Colors.orange[800]),
            child: Container(
              color: Colors.orange[800],
              child: ListView(
                children: columnCards('Assembly', val),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: GetBuilder(
          init: controller,
          builder: (SinglePageController val) => bottomBarBuilder(val)),
    );
  }
}
