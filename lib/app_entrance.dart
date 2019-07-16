import 'package:curso/custom_themes.dart';
import 'package:curso/view/view_home/view_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bloc/bloc_main/bloc_main.dart';
import 'container/periodos.dart';

class AppEntrance extends StatelessWidget {
  final List<Periodos> periodos;

  const AppEntrance({Key key, this.periodos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<BlocMain>(
      child: MyApp(initialPosition: periodos.isNotEmpty ? 1 : 0),
      builder: (BuildContext context) => BlocMain(periodos: periodos),
      dispose: (BuildContext a, BlocMain b) => b.dispose(),
    );
  }
}

class MyApp extends StatelessWidget {
  final int initialPosition;

  const MyApp({
    @required this.initialPosition,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: CustomThemes.darkTheme,
      home: ViewHome(
        initialPos: initialPosition,
      ),
    );
  }
}
