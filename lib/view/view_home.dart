import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:flutter/material.dart';

import '../container/conf.dart';
import '../container/periodos.dart';
import 'view_home_builder.dart';
import 'view_options/ViewOptionsResult.dart';
import 'view_options/view_options.dart';
import 'view_periodos_insert/view_periodos_insert.dart';

class ViewHome extends StatefulWidget {
  @override
  ViewHomeState createState() {
    return new ViewHomeState();
  }
}

class ViewHomeState extends State<ViewHome> with TickerProviderStateMixin {
  BlocMain b;
  int _pos;
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _pos = 0;
    _controller = TabController(
      length: 3,
      vsync: this,
      initialIndex: _pos,
    );
  }

  @override
  void dispose() {
    super.dispose();
    b.dispose();
  }

  _setPos(i) => setState(() => _pos = i);

  @override
  Widget build(BuildContext context) {
    b = BlocProvider.of<BlocMain>(context);

    return StreamBuilder<Conf>(
      stream: b.outConf,
      builder: (BuildContext context, AsyncSnapshot<Conf> snap) {
        return Scaffold(
          appBar: ViewHomeBuilder.appBar(
            bloc: b,
            pos: _pos,
            onOptionSelected: (i) async {
              final ViewOptionsResult result = await Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (c) {
                    return ViewOptions(
                      brightness: snap.data.brightness,
                      notify: snap.data.notify,
                    );
                  },
                ),
              );

              if (result != null && result is ViewOptionsResult) {
                b.setBrightness(result.brightness);
                b.setNotify(result.notify);
              }
            },
          ),
          body: ViewHomeBuilder.body(_controller),
          floatingActionButton: ViewHomeBuilder.fab(
            pos: _pos,
            onTap: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (BuildContext c) {
                    return ViewPeriodosInsert(periodo: Periodos.newInstance());
                  },
                ),
              );

              if (result != null) b.insertPeriodo(result);
            },            
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          bottomNavigationBar: ViewHomeBuilder.bottomBar(_pos, (i) {
            _setPos(i);
            _controller.animateTo(i);
          }),
        );
      },
    );
  }
}
