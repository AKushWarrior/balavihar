import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils.dart';

OutlinedButton createBottomButton(
    {BuildContext context,
    String content,
    Color swatch,
    bool isActive,
    Function() onPressed}) {
  Widget base = Container(
    padding: EdgeInsets.symmetric(
      vertical: 10,
      horizontal: Screen.bottomButtonMargin(context),
    ),
    child: Text(
      content,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
        fontFamily: GoogleFonts.oswald().fontFamily,
        color: isActive ? Colors.black : Colors.grey[300],
      ),
    ),
  );
  return OutlinedButton(
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(primary: swatch),
    child: base,
  );
}
