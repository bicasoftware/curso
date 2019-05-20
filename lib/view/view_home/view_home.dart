import 'package:bloc_provider/bloc_provider.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_calendario/view_calendario.dart';
import 'package:curso/view/view_home/widgets/view_home_bottombar.dart';
import 'package:curso/view/view_home/widgets/view_home_dropdown_periodos.dart';
import 'package:curso/view/view_home/widgets/view_home_fab.dart';
import 'package:curso/view/view_parciais/view_parciais.dart';
import 'package:curso/view/view_periodos/view_periodos.dart';
import 'package:curso/view/view_periodos_insert/view_periodos_insert.dart';
import 'package:curso/widgets/placeholders/stream_builder_child.dart';
import 'package:flutter/material.dart';

class ViewHome extends StatelessWidget {
  const ViewHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = BlocProvider.of<BlocMain>(context);

    return Scaffold(
      backgroundColor: ThemeData.light().canvasColor,
      appBar: AppBar(
        title: Text(Strings.appName),
        elevation: 0,
        actions: [
          StreamAwaiter<int>(
            stream: b.outPos,
            widgetBuilder: (_, int pos) => ViewHomeDropdownPeriodos(pos: pos),
          ),
        ],
      ),
      body: StreamAwaiter<int>(
        stream: b.outPos,
        widgetBuilder: (_, int pos) {
          return IndexedStack(

            index: pos,
            children: const [
              const ViewPeriodos(),
              const ViewCalendario(),
              const ViewInfo(),
            ],
          );
        },
      ),
      floatingActionButton: ViewHomeFab(
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
      bottomNavigationBar: ViewHomeBottombar(),
    );
  }
}
