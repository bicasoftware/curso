import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_calendario/view_calendario.dart';
import 'package:curso/view/view_home/widgets/view_home_appbar_action.dart';
import 'package:curso/view/view_home/widgets/view_home_bottombar.dart';
import 'package:curso/view/view_parciais/view_parciais.dart';
import 'package:curso/view/view_periodos/view_periodos.dart';
import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:morpheus/morpheus.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class ViewHome extends StatefulWidget {
  final int initialPos;
  const ViewHome({Key key, @required this.initialPos}) : super(key: key);

  @override
  _ViewHomeState createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome> with SingleTickerProviderStateMixin {
  final pages = [
    const ViewPeriodos(),
    const ViewCalendario(),
    const ViewInfo(),
  ];

  final titles = [
    Strings.periodos,
    Strings.calendario,
    Strings.parciais,
  ];

  BehaviorSubject<int> _subjectPos = BehaviorSubject<int>();
  get outPos => _subjectPos.stream;
  get inPos => _subjectPos.sink;

  @override
  void initState() {
    super.initState();
    inPos.add(widget.initialPos);
  }

  @override
  void dispose() {
    _subjectPos.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocMain>(context);

    return Scaffold(
      backgroundColor: ThemeData.light().canvasColor,
      appBar: AppBar(
        title: Observer<int>(
          stream: outPos,
          onSuccess: (BuildContext context, int pos) {
            return AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              child: Text(titles[pos], key: UniqueKey()),
              transitionBuilder: (Widget w, Animation<double> a) {
                return SizeTransition(
                  sizeFactor: a,
                  axis: Axis.vertical,
                  axisAlignment: 0,
                  child: FadeTransition(
                    opacity: a,
                    child: w,
                  ),
                );
              },
            );
          },
        ),
        actions: [
          Observer<int>(
            stream: outPos,
            onSuccess: (BuildContext context, int pos) {
              return ViewHomeAppbarAction(
                pos: pos,
                onInsertPeriodos: (Periodos periodo) => b.insertPeriodo(periodo),
              );
            },
          )
        ],
      ),
      body: Observer<int>(
        stream: outPos,
        onSuccess: (BuildContext context, int pos) => MorpheusTabView(
          child: pages[pos],
          duration: Duration(milliseconds: 300),
        ),
      ),
      bottomNavigationBar: Observer(
        stream: _subjectPos,
        onSuccess: (_, int pos) {
          return ViewHomeBottombar(
            pos: pos,
            onChanged: (pos) => inPos.add(pos),
          );
        },
      ),
    );
  }
}
