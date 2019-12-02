import 'package:curso/custom_themes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomThemes.lightTheme,
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: const Center(
            child: Image(
              image: AssetImage('assets/images/curso_logo2.png'),
            ),
          ),
        ),
      ),
    );
  }
}
