import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peninsulabalvihar/utils.dart';

class PageTitle extends StatelessWidget {
  final String title;
  final double fontSize;

  PageTitle(this.title, this.fontSize);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.fromLTRB(Screen.marginX(context), 10, Screen.marginX(context), 0),
      alignment: Alignment.center,
      child: Row(children: [
        IconButton(
          icon: NeumorphicIcon(
            Icons.arrow_back_ios,
            size: 36,
            style: const NeumorphicStyle(color: Colors.white),
            //color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        Container(width: Screen.width(context) / 50),
        Container(
            alignment: Alignment.center,
            child: NeumorphicText(
              title,
              textStyle: NeumorphicTextStyle(
                fontFamily: GoogleFonts.oswald().fontFamily,
                fontSize: fontSize,
              ),
              style: const NeumorphicStyle(color: Colors.white),
            )),
      ]),
    );
  }
}
