import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peninsulabalvihar/business/multipage.dart';

import '../../../../utils.dart';

class SongBody extends StatelessWidget {
  final SongController childControl;

  SongBody(this.childControl);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: Screen.marginX(context)),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Screen.borderRadius)),
      child: Container(
          padding: const EdgeInsets.all(10.0),
          child: fullSongView(childControl)),
    ));
  }
}

Widget fullSongView(SongController control) {
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
            itemBuilder: (_, int i) {
              return Text(
                '\n' + control.base.verses[i].lyrics.join('\n') + '\n',
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
