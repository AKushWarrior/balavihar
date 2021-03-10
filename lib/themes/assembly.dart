import 'package:flutter/material.dart';

ThemeData assemblyTheme(BuildContext context) {
  return ThemeData.from(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange),
          textTheme: Theme.of(context).textTheme)
      .copyWith(
    accentColor: Colors.orange[800],
    buttonTheme: ButtonThemeData(
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: Colors.orange),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(primary: Colors.orange),
    ),
  );
}
