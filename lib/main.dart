import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/about.dart';
import 'screens/assembly.dart';
import 'screens/home.dart';
import 'screens/song.dart';

void main() => runApp(BalviharApp());

class BalviharApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Balvihar Demo',
      theme: ThemeData.light().copyWith(
        textTheme: GoogleFonts.oswaldTextTheme().copyWith(
          bodyText1: GoogleFonts.merriweather(),
          bodyText2: GoogleFonts.merriweather(),
          subtitle1: GoogleFonts.merriweather(),
          subtitle2: GoogleFonts.merriweather(),
        ),
        backgroundColor: Colors.white,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: "/", page: () => HomePage()),
        GetPage(name: "/assembly", page: () => AssemblyPage()),
        GetPage(name: "/bhajans", page: () => SongPage(SongType.bhajans)),
        GetPage(name: "/shlokams", page: () => SongPage(SongType.shlokams)),
        GetPage(name: "/aboutus", page: () => AboutPage()),
      ],
    );
  }
}
