import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'screens/assembly.dart';
import 'screens/home.dart';
import 'screens/song.dart';

void main() => runApp(ProviderScope(child: BalviharApp()));

class BalviharApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
      routerDelegate: BeamerRouterDelegate(
        beamLocations: [
          HomeLocation(),
          AssemblyLocation(),
          BhajanLocation(),
          ShlokamLocation()
        ],
      ),
      routeInformationParser: BeamerRouteInformationParser(),
    );
  }
}

class HomeLocation extends BeamLocation {

  @override
  List<BeamPage> pagesBuilder(BuildContext context) {
    return [BeamPage(key: ValueKey('home'), child: HomePage())];
  }

  @override
  List<String> get pathBlueprints => ['/'];
}

class AssemblyLocation extends BeamLocation {
  @override
  List<BeamPage> pagesBuilder(BuildContext context) {
    return [...HomeLocation().pagesBuilder(context), BeamPage(key: ValueKey('assembly'), child: AssemblyPage())];
  }

  @override
  List<String> get pathBlueprints => ['/assembly'];
}

class BhajanLocation extends BeamLocation {
  @override
  List<BeamPage> pagesBuilder(BuildContext context) {
    return [...HomeLocation().pagesBuilder(context), BeamPage(key: ValueKey('bhajans'), child: SongPage(SongType.bhajans))];
  }

  @override
  List<String> get pathBlueprints => ['/bhajans'];
}

class ShlokamLocation extends BeamLocation {
  @override
  List<BeamPage> pagesBuilder(BuildContext context) {
    return [...HomeLocation().pagesBuilder(context), BeamPage(key: ValueKey('shlokams'), child: SongPage(SongType.shlokams))];
  }
  @override
  List<String> get pathBlueprints => ['/shlokams'];
}

