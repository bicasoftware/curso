import 'package:curso/Themes.dart';
import 'package:curso/bloc/bloc_main/BlocMain.dart';
import 'package:curso/container/conf.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/events/events_main/MainEvents.dart';
import 'package:curso/main_state.dart';
import 'package:curso/utils.dart/AppBrightness.dart';
import 'package:curso/view/view_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppEntrance extends StatefulWidget {
  final List<Periodos> periodos;
  final Conf conf;

  const AppEntrance({Key key, this.periodos, this.conf}) : super(key: key);

  @override
  AppEntranceState createState() {
    return new AppEntranceState();
  }
}

class AppEntranceState extends State<AppEntrance> {
  BlocMain _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocMain(
      periodos: widget.periodos,
      conf: widget.conf,
    );
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
    final b = BlocProvider.of<BlocMain>(context);

    return BlocBuilder<MainEvents, MainState>(
      bloc: b,
      builder: (c, s) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: s.brightness == AppBrightness.DARK ? Themes.darkTheme : Themes.lightTheme,
          home: ViewHome(),
        );
      },
    );
  }
}
