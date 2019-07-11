import 'package:curso/custom_themes.dart';
import 'package:curso/view/view_home/view_home.dart';
import 'package:flutter/material.dart';

import 'bloc/bloc_main/bloc_main.dart';
import 'container/periodos.dart';
import 'package:provider/provider.dart';

class AppEntrance extends StatelessWidget {
  final List<Periodos> periodos;

  const AppEntrance({Key key, this.periodos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<BlocMain>(
      child: MyApp(initialPosition: periodos.length > 0 ? 1 : 0),
      builder: (BuildContext context) => BlocMain(periodos: periodos),
      dispose: (BuildContext a, BlocMain b) => b.dispose(),
    );
  }
}

class MyApp extends StatelessWidget {
  final int initialPosition;

  const MyApp({
    Key key,
    @required this.initialPosition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: CustomThemes.transparedBackgroundTheme,
      home: ViewHome(
        initialPos: initialPosition,
      ),
    );
  }
}
