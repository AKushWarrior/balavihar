import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peninsulabalvihar/business/multipage.dart';

Widget bodyBuilder(SinglePageSongController controller) {
  return Expanded(
      child: Neumorphic(
    style: const NeumorphicStyle(color: Colors.white),
    margin: const EdgeInsets.symmetric(horizontal: 15.0),
    padding: const EdgeInsets.all(10.0),
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10.0)),
    child: fullSongView(controller),
  ));
}

Widget fullSongView(SinglePageSongController control) {
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        child: Text(
          'Lyrics',
          style: TextStyle(
            color: Colors.red[700],
            fontFamily: GoogleFonts.oswald().fontFamily,
            fontSize: 24,
          ),
        ),
      ),
      const Divider(),
      Expanded(
        child: Container(
          margin: const EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 5.0),
            itemBuilder: (BuildContext ctxt, int i) {
              return Text(
                "\n" + control.base.verses[i].lyrics.join("\n") + "\n",
                style: const TextStyle(color: Colors.black, fontSize: 16),
                textAlign: TextAlign.center,
              );
            },
            itemCount: control.base.verses.length,
          ),
        ),
      ),
    ],
  );
}
