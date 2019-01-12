import 'package:curso/main_state.dart';
import 'package:curso/bloc/bloc_main/BlocMain.dart';
import 'package:curso/events/events_main/MainEvents.dart';
import 'package:curso/view/view_home_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewHome extends StatefulWidget {
  @override
  ViewHomeState createState() {
    return new ViewHomeState();
  }
}

class ViewHomeState extends State<ViewHome> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final b = BlocProvider.of<BlocMain>(context);

    return BlocBuilder<MainEvents, MainState>(
      bloc: b,
      builder: (context, state) {
        final nav = TabController(
          length: 3,
          vsync: this,
          initialIndex: state.navPos,
        );

        return Scaffold(
          appBar: ViewHomeBuilder.appBar,
          body: ViewHomeBuilder.body(nav),
          bottomNavigationBar: ViewHomeBuilder.bottomBar(
            state.navPos,
            (i) {
              b.dispatch(SetPosition(i));
              nav.animateTo(i);
            },
          ),
        );
      },
    );
  }
}
