import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peninsulabalvihar/business/multipage.dart';

Widget bodyBuilder(SinglePageSongController controller) {
  return Expanded(
      child: Neumorphic(
    style: NeumorphicStyle(color: Colors.white),
    margin: EdgeInsets.symmetric(horizontal: 15.0),
    padding: EdgeInsets.all(10.0),
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10.0)),
    child: fullSongView(controller),
  ));
}

Widget fullSongView(SinglePageSongController control) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        child: Text(
          'Lyrics',
          style: TextStyle(
            color: Colors.red[700],
            fontFamily: GoogleFonts.oswald().fontFamily,
            fontSize: 24,
          ),
        ),
      ),
      Divider(),
      Expanded(
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: ListView.builder(
            padding: EdgeInsets.only(top: 5.0),
            itemBuilder: (BuildContext ctxt, int i) {
              if (i == 0)
                print(control.base.verses[i].lyrics.join("\n") + "\n");
              return Text(
                control.base.verses[i].lyrics.join("\n") + "\n",
                style: TextStyle(color: Colors.black, fontSize: 16),
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
