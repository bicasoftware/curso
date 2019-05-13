import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';

import 'bloc/bloc_main/bloc_main.dart';
import 'container/periodos.dart';
import 'view/view_home.dart';

class AppEntrance extends StatefulWidget {
  final List<Periodos> periodos;

  const AppEntrance({Key key, this.periodos}) : super(key: key);

  @override
  AppEntranceState createState() => AppEntranceState(periodos: periodos);
}

class AppEntranceState extends State<AppEntrance> {
  BlocMain _bloc;

  final List<Periodos> periodos;

  AppEntranceState({@required this.periodos});

  @override
  void initState() {
    super.initState();
    _bloc = BlocMain(periodos: periodos);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocMain>(
      creator: (_, __) => _bloc,      
      child: MyApp(initPos: widget.periodos.length > 0 ? 1 : 0),
    );
  }
}

class MyApp extends StatelessWidget {

  final int initPos;

  const MyApp({Key key, @required this.initPos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
        fontFamily: "FiraSans",
        brightness: Brightness.light,
        splashColor: Colors.lightBlue[50],
        highlightColor: Colors.lightBlue[50],
        canvasColor: Colors.transparent,
      ),
      home: ViewHome(initialPagePos: initPos),
    );
  }
}
