import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peninsulabalavihar/screens/about.dart';
import 'package:peninsulabalavihar/screens/song.dart';

import 'screens/home.dart';

void main() => runApp(BalaviharApp());

class BalaviharApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Balavihar Demo',
      initialRoute: '/',
      namedRoutes: {
        '/': GetRoute(page: HomePage()),
        '/assembly': GetRoute(page: SongPage(SongType.assembly)),
        '/bhajans': GetRoute(page: SongPage(SongType.bhajan)),
        '/shlokams': GetRoute(page: SongPage(SongType.shlokam)),
        '/patriotic': GetRoute(page: SongPage(SongType.patriotic)),
        '/aboutus': GetRoute(page: AboutPage()),
      },
    );
  }
}
