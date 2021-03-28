import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils.dart';

class PageTitle extends StatelessWidget {
  final String title;
  final double fontSize;

  PageTitle(this.title, this.fontSize);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.fromLTRB(
          Screen.marginX(context), 10, Screen.marginX(context), 0),
      alignment: Alignment.center,
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        IconButton(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          icon: Icon(
            Icons.arrow_back_ios,
            size: 36,
            color: Colors.white,
            //color: Colors.white,
          ),
          onPressed: () => Nav.router.pop(context),
        ),
        Container(width: Screen.width(context) / 50),
        Container(
            child: Text(
          title,
          style: TextStyle(
            fontFamily: GoogleFonts.oswald().fontFamily,
            fontSize: fontSize,
            color: Colors.white,
          ),
        )),
      ]),
    );
  }
}
