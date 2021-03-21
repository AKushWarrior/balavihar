import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peninsulabalvihar/utils.dart';

import 'screens/assembly.dart';
import 'screens/home.dart';
import 'screens/song.dart';

void main() => runApp(ProviderScope(child: BalviharApp()));

class BalviharApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Nav.init();
    return MaterialApp(
      title: 'Balvihar Demo',
      theme: ThemeData.light().copyWith(
        textTheme: GoogleFonts.oswaldTextTheme().copyWith(
          bodyText1: GoogleFonts.merriweather(),
          bodyText2: GoogleFonts.merriweather(),
          subtitle1: GoogleFonts.merriweather(),
          subtitle2: GoogleFonts.merriweather(),
        ),
        backgroundColor: Colors.white,
        splashColor: Colors.transparent,
      ),
      onGenerateRoute: Nav.router.generator,
    );
  }
}
