import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'Themes.dart';
import 'bloc/bloc_main/bloc_main.dart';
import 'container/conf.dart';
import 'container/periodos.dart';
import 'view/view_home.dart';

class AppEntrance extends StatefulWidget {
  final List<Periodos> periodos;
  final Conf conf;

  const AppEntrance({Key key, this.periodos, this.conf}) : super(key: key);

  @override
  AppEntranceState createState() => AppEntranceState(conf: conf, periodos: periodos);
}

class AppEntranceState extends State<AppEntrance> {
  BlocMain _bloc;

  final List<Periodos> periodos;
  final Conf conf;

  AppEntranceState({@required this.periodos, @required this.conf});

  @override
  void initState() {
    super.initState();
    _bloc = BlocMain(periodos: periodos, conf: conf);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocMain>(
      bloc: _bloc,
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Themes.lightTheme,
      home: ViewHome(),
    );
  }
}
