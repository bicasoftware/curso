import 'package:curso/bloc/bloc_main/BlocMain.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/events/events_main/MainEvents.dart';
import 'package:curso/main_state.dart';
import 'package:curso/view/view_home_builder.dart';
import 'package:curso/view/view_options/ViewOptionsResult.dart';
import 'package:curso/view/view_options/view_options.dart';
import 'package:curso/view/view_periodos_insert/view_periodos_insert.dart';
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
          appBar: ViewHomeBuilder.appBar(onOptionSelected: (i) async {
            final ViewOptionsResult result = await Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (c) {
                  return ViewOptions(
                    brightness: state.brightness,
                    notify: state.notify,
                  );
                },
              ),
            );

            if (result != null && result is ViewOptionsResult) {
              b.dispatch(SetBrightness(result.brightness));
              b.dispatch(SetNotify(result.notify));
            }
          }),
          body: ViewHomeBuilder.body(nav),
          floatingActionButton: ViewHomeBuilder.fab(state.showFab, () async {

            final result = await Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (BuildContext c) {
                  return ViewPeriodosInsert(periodo: Periodos.newInstance());
                },
              ),
            );

            if(result != null){
              b.dispatch(InsertPeriodo(result));
            }
          }),
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
