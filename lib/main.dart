import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/assembly.dart';
import 'screens/about.dart';
import 'screens/song.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home.dart';

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
        GetPage(name: "/bhajans", page: () => SongPage('Bhajans')),
        GetPage(name: "/shlokams", page: () => SongPage('Shlokams')),
        GetPage(name: "/patriotic", page: () => SongPage('Patriotic')),
        GetPage(name: "/aboutus", page: () => AboutPage()),
      ],
    );
  }
}
