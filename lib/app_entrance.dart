import 'package:curso/bloc/bloc_main/BlocMain.dart';
import 'package:curso/view/view_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppEntrance extends StatefulWidget {
  @override
  AppEntranceState createState() {
    return new AppEntranceState();
  }
}

class AppEntranceState extends State<AppEntrance> {
  BlocMain _bloc = BlocMain();

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.green,
        fontFamily: "FiraSans",
        brightness: Brightness.dark,
      ),
      home: BlocProvider<BlocMain>(
        bloc: _bloc,
        child: ViewHome(),
      ),
    );
  }
}