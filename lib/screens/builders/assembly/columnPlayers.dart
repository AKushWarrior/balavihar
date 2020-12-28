import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:peninsulabalvihar/screens/builders/title.dart';

import '../../../business/general.dart';
import 'cardPlayer.dart';

List<Widget> columnCards(String title, Controller control) {
  List<Widget> children = [];
  children.add(
    buildTitle(title, 48),
  );
  var i = 0;
  for (var unit in control.model.fetchAll()) {
    children.add(cardBuilder('', '', [], unit, control, i));
    i++;
  }
  return children;
}
