import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peninsulabalvihar/screens/builders/bottomBar.dart';

import '../business/page.dart';
import 'builders/columnPlayers.dart';

class AssemblyPage extends StatelessWidget {
  Widget build(context) {
    return GetBuilder<SinglePageController>(
      init: SinglePageController(),
      builder: (SinglePageController val) {
        return Scaffold(
          body: Column(children: columnCards('Assembly', val)),
          bottomNavigationBar: bottomBarBuilder(val),
        );
      },
    );
  }
}
