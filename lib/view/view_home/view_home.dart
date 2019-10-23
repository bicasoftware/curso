import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_calendario/view_calendario.dart';
import 'package:curso/view/view_home/widgets/view_home_bottombar.dart';
import 'package:curso/view/view_parciais/view_parciais.dart';
import 'package:curso/view/view_periodos/view_periodos.dart';
import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:morpheus/morpheus.dart';
import 'package:rxdart/rxdart.dart';

class ViewHome extends StatefulWidget {
  const ViewHome({
    @required this.initialPos,
    Key key,
  }) : super(key: key);

  final int initialPos;

  @override
  _ViewHomeState createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome> {
  final List<Widget> pages = <Widget>[
    const ViewPeriodos(),
    const ViewCalendario(),
    const ViewInfo(),
  ];

  final List<String> titles = [
    Strings.periodos,
    Strings.calendario,
    Strings.parciais,
  ];

  final BehaviorSubject<int> _subjectPos = BehaviorSubject<int>();
  Stream<int> get outPos => _subjectPos.stream;
  Sink<int> get inPos => _subjectPos.sink;

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
    return Scaffold(
      body: StreamObserver<int>(
        stream: outPos,
        onSuccess: (BuildContext context, int pos) => MorpheusTabView(
          child: pages[pos],
          duration: const Duration(milliseconds: 300),
        ),
      ),
      bottomNavigationBar: StreamObserver(
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
