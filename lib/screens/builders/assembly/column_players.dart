import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:peninsulabalvihar/business/page.dart';
import 'package:peninsulabalvihar/screens/builders/title.dart';

import 'card_player.dart';

List<Widget> columnCards(String title, SinglePageController control) {
  final List<Widget> children = [];
  children.add(
    buildTitle(title, 48),
  );
  var i = 0;
  for (final unit in control.model.fetchAll()) {
    children.add(cardBuilder(
      '',
      '',
      [],
      unit as SinglePageUnit,
      control,
      i,
    ));
    i++;
  }
  return children;
}
