import 'package:curso/custom_themes.dart';
import 'package:curso/view/view_home/view_home.dart';
import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:provider/provider.dart';

import 'bloc/bloc_main/bloc_main.dart';
import 'container/periodos.dart';

class AppEntrance extends StatelessWidget {
  const AppEntrance({
    @required this.periodos,
    @required this.brightness,
    Key key,
  }) : super(key: key);

  final List<Periodos> periodos;
  final int brightness;

  @override
  Widget build(BuildContext context) {
    return Provider<BlocMain>(
      child: MyApp(initialPosition: periodos.isNotEmpty ? 1 : 0),
      builder: (BuildContext context) => BlocMain(periodos: periodos, isLight: brightness),
      dispose: (BuildContext a, BlocMain b) => b.dispose(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({
    @required this.initialPosition,
    Key key,
  }) : super(key: key);

  final int initialPosition;

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocMain>(context);
    return Observer<bool>(
      stream: b.outBrightness,
      onSuccess: (BuildContext context, bool isLight) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: isLight ? CustomThemes.darkTheme : CustomThemes.lightTheme,
          home: ViewHome(
            initialPos: initialPosition,
          ),
        );
      },
    );
  }
}
