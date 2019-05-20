import 'package:flutter/material.dart';

class CustomThemes {
  static ThemeData get transparedBackgroundTheme {
    return ThemeData(
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
      fontFamily: "FiraSans",
      brightness: Brightness.light,
      splashColor: Colors.lightBlue[50],
      highlightColor: Colors.lightBlue[50],
      canvasColor: Colors.transparent,
    );
  }

  static ThemeData get lightTheme {
    return transparedBackgroundTheme.copyWith(
      canvasColor: ThemeData.light().canvasColor
    );
  }

}
