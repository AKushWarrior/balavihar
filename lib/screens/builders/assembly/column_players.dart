import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peninsulabalvihar/business/page.dart';
import 'package:peninsulabalvihar/screens/builders/title.dart';

import 'card_player.dart';

class AssemblyCardColumn extends HookWidget {
  final StateNotifierProvider<AssemblyNotifier> provider;
  final String title;

  AssemblyCardColumn(this.provider, this.title);

  @override
  Widget build(BuildContext context) {
    var notifier = useProvider(provider);
    var controller = notifier.read;
    final children = <Widget>[];
    children.add(
      PageTitle(title, 48),
    );
    var i = 0;
    for (final unit in controller.model.fetchAll()) {
      children.add(AssemblyCard(
        notifier,
        controller,
        unit as SinglePageUnit,
        i,
      ));
      i++;
    }
    return ListView(children: children);
  }
}

List<Widget> columnCards(String title, AssemblyController control) {

}
