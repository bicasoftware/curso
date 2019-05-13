import 'package:bloc_provider/bloc_provider.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:flutter/material.dart';

import '../container/periodos.dart';
import 'view_home_builder.dart';
import 'view_periodos_insert/view_periodos_insert.dart';

class ViewHome extends StatefulWidget {

  final int initialPagePos;

  const ViewHome({Key key, @required this.initialPagePos}) : super(key: key);

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
    _pos = widget.initialPagePos;
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

    return Scaffold(
      backgroundColor: ThemeData.light().canvasColor,
      appBar: ViewHomeBuilder.appBar(
        bloc: b,
        pos: _pos,
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
      bottomNavigationBar: ViewHomeBuilder.bottomBar(context, _pos, (i) {
        _setPos(i);
        _controller.animateTo(i);
      }),
    );
  }
}
