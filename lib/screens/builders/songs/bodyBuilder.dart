import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peninsulabalvihar/business/multipage.dart';
import 'dart:io' show Platform;

Widget bodyBuilder(SinglePageSongController controller) {
  return Expanded(
      child: Neumorphic(
    style: NeumorphicStyle(color: Colors.white),
    margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
    padding: EdgeInsets.all(10.0),
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10.0)),
    child: controller.mode == Mode.verse
        ? verseSongView(controller)
        : fullSongView(controller),
  ));
}

Widget fullSongView(SinglePageSongController control) {
  return Column(
    children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Lyrics Mode:      ',
          style: TextStyle(
            color: Colors.red[700],
            fontFamily: GoogleFonts.oswald().fontFamily,
            fontSize: 18,
          ),
        ),
        DropdownButton(
          value: 'Scroll',
          items: ['Scroll', 'Verse-by-Verse']
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (String value) {
            if (value == 'Scroll') {
              control.mode = Mode.all;
            } else if (value == 'Verse-by-Verse') {
              control.mode = Mode.verse;
            }
          },
          style: TextStyle(
            color: Colors.red[800],
            fontFamily: GoogleFonts.oswald().fontFamily,
            fontSize: 18,
          ),
        ),
      ]),
      Divider(),
      Expanded(
        child: ListView.builder(
          itemBuilder: (BuildContext ctxt, int i) {
            return Text(
              control.base.verses[i].lyrics.join("\n") + "\n",
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
            );
          },
          itemCount: control.base.verses.length,
        ),
      ),
    ],
  );
}

Widget verseSongView(SinglePageSongController control) {
  return Expanded(
    child: Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Lyrics Mode:      ',
            style: TextStyle(
              color: Colors.red[700],
              fontFamily: GoogleFonts.oswald().fontFamily,
              fontSize: 18,
            ),
          ),
          DropdownButton(
            value: 'Verse-by-Verse',
            items: ['Scroll', 'Verse-by-Verse']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (String value) {
              if (value == 'Scroll') {
                control.mode = Mode.all;
              } else if (value == 'Verse-by-Verse') {
                control.mode = Mode.verse;
              }
            },
            style: TextStyle(
              color: Colors.red[800],
              fontFamily: GoogleFonts.oswald().fontFamily,
              fontSize: 18,
            ),
          ),
          Divider(),
        ])
      ],
    ),
  );
}
