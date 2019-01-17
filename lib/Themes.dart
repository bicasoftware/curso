import 'package:flutter/material.dart';

class Themes {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.red,
      primaryColor: Colors.red,
      accentColor: Colors.red,
      fontFamily: "FiraSans",
      brightness: Brightness.light,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primarySwatch: Colors.deepPurple,
      primaryColor: Colors.deepPurple,
      accentColor: Colors.deepPurple,
      fontFamily: "FiraSans",
      brightness: Brightness.dark,
    );
  }
}
