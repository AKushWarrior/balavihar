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
      ),
      initialRoute: '/',
      namedRoutes: {
        '/': GetRoute(page: HomePage()),
        '/assembly': GetRoute(page: AssemblyPage()),
        '/bhajans': GetRoute(page: SongPage('Bhajans')),
        '/shlokams': GetRoute(page: SongPage('Shlokams')),
        '/patriotic': GetRoute(page: SongPage('Patriotic')),
        '/aboutus': GetRoute(page: AboutPage()),
      },
    );
  }
}
