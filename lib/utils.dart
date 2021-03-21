/*
 * @Copyright (c) 2017 amazon.com. All rights reserved.
 *
 */

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:peninsulabalvihar/business/multipage.dart';
import 'package:peninsulabalvihar/screens/assembly.dart';
import 'package:peninsulabalvihar/screens/builders/songs/children/build_song.dart';
import 'package:peninsulabalvihar/screens/home.dart';
import 'package:peninsulabalvihar/screens/song.dart';

class Screen {
  static double marginX(BuildContext context) => width(context) / 24;

  static double bottomButtonMargin(BuildContext context) => width(context) / 25;

  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double get borderRadius => 7;
}

class Nav {
  static final router = FluroRouter();

  static void init() {
    var home = Handler(handlerFunc: (_, _2) {
      return HomePage();
    });
    var assembly = Handler(handlerFunc: (_, _2) {
      return AssemblyPage();
    });
    var bhajans = Handler(handlerFunc: (_, _2) {
      return SongPage(SongType.bhajans);
    });
    var childSong = Handler(handlerFunc: (context, _) {
      final args = context.arguments as List<dynamic>;
      return ChildSongScaffold(args[0] as MultiPageUnit, args[1] as MultiPageController);
    });

    router
      ..define('/', handler: home)
      ..define('/assembly', handler: assembly, transitionType: TransitionType.cupertinoFullScreenDialog)
      ..define('/bhajans', handler: bhajans, transitionType: TransitionType.cupertinoFullScreenDialog)
      ..define('/child', handler: childSong, transitionType: TransitionType.cupertinoFullScreenDialog);
  }
}
