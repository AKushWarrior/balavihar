import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:peninsulabalvihar/business/page.dart';
import 'package:peninsulabalvihar/screens/builders/title.dart';

import '../../../business/general.dart';
import 'cardPlayer.dart';

List<Widget> columnCards(String title, SinglePageController control) {
  List<Widget> children = [];
  children.add(
    buildTitle(title, 48),
  );
  var i = 0;
  for (Unit unit in control.model.fetchAll()) {
    children.add(cardBuilder(
      '',
      '',
      [],
      unit as SinglePageUnit,
      control as SinglePageController,
      i,
    ));
    i++;
  }
  return children;
}
