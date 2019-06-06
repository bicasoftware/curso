import 'package:flutter/material.dart';

class CustomThemes {
  static ThemeData get transparedBackgroundTheme {
    return ThemeData(
      primarySwatch: Colors.indigo,
      primaryColor: Colors.indigo,
      accentColor: Colors.pink,
      fontFamily: "FiraSans",
      brightness: Brightness.light,
      splashColor: Colors.lightBlue[50],
      highlightColor: Colors.lightBlue[50],
      canvasColor: Colors.transparent,
    );
  }

  static ThemeData get lightTheme {
    return transparedBackgroundTheme.copyWith(
      canvasColor: ThemeData.light().canvasColor,
      cardColor: ThemeData.light().cardColor,
    );
  }

  static ThemeData get primaryColorThemeData {
    return transparedBackgroundTheme.copyWith(
      brightness: Brightness.dark,
      canvasColor: transparedBackgroundTheme.primaryColor,
      textTheme: ThemeData.dark().textTheme,
    );
  }

  static TextStyle get lightTextButton {
    return lightTheme.textTheme.button.copyWith(color: Colors.white);
  }
}
