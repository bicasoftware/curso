import 'package:curso/custom_colors.dart';
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

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: CustomColors.primary,
      accentColor: CustomColors.accent,
      backgroundColor: CustomColors.canvasColor,
      canvasColor: CustomColors.canvasColor,
      cardColor: CustomColors.cardColor,
      dividerColor: Colors.white60,
      bottomAppBarColor: CustomColors.cardColor,
      iconTheme: IconThemeData(
        color: Colors.white,        
      ),
      appBarTheme: const AppBarTheme(
        brightness: Brightness.dark,
        color: CustomColors.primary,
        elevation: 2,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.indigo,
      accentColor: Colors.pinkAccent,
      backgroundColor: Colors.transparent,
      canvasColor: ThemeData.light().canvasColor,
      cardColor: ThemeData.light().cardColor,
      iconTheme: IconThemeData(
        color: Colors.black87,
      ),
      appBarTheme: const AppBarTheme(
        brightness: Brightness.dark,
        color: Colors.indigo,
        elevation: 2,
      ),
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

  static TextStyle bottomSheetHeader(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).accentColor,
      fontSize: 18,
    );
  }
}
