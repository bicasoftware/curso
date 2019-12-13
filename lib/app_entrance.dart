import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/custom_themes.dart';
import 'package:curso/models/periodos.dart';
import 'package:curso/view/view_login/view_login.dart';
import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:provider/provider.dart';

class AppEntrance extends StatelessWidget {
  const AppEntrance({
    @required this.periodos,
    @required this.isLight,
    Key key,
  }) : super(key: key);

  final List<Periodos> periodos;
  final bool isLight;

  @override
  Widget build(BuildContext context) {
    return Provider<BlocMain>(
      child: MyApp(initialPosition: periodos.isNotEmpty ? 1 : 0),
      builder: (BuildContext context) => BlocMain(periodos: periodos, isLight: isLight),
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

    //TODO - testar se existe registro do token
    //e testar se existem dados no banco.
    //Se for true, true
    // => carregar tela inicial,
    // else
    // => carregar tela de login

    final b = Provider.of<BlocMain>(context);
    return StreamObserver<bool>(
      stream: b.outBrightness,
      onSuccess: (BuildContext context, bool isLight) {
        return  MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: isLight ? CustomThemes.darkTheme : CustomThemes.lightTheme,
          home: ViewLogin(),
          /* home: ViewHome(
            initialPos: initialPosition,
          ), */
        );
      },
    );
  }
}
