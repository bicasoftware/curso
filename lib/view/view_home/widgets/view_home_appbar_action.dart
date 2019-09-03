import 'package:curso/container/periodos.dart';
import 'package:curso/view/view_calendario/widgets/dropdown_periodos.dart';
import 'package:curso/view/view_periodos_insert/view_periodos_insert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewHomeAppbarAction extends StatelessWidget {
  const ViewHomeAppbarAction({
    @required this.pos,
    @required this.onInsertPeriodos,
    Key key,
  }) : super(key: key);

  final int pos;
  final Function(Periodos) onInsertPeriodos;

  @override
  Widget build(BuildContext context) {
    void showActInsertEmprego() async {
      final result = await Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (BuildContext c) {
            return ViewPeriodosInsert(periodo: Periodos.newInstance());
          },
        ),
      );

      if (result != null) {
        onInsertPeriodos(result);
      }
    }

    Widget getActionByPos(int pos) {
      switch (pos) {
        case 0:
          return IconButton(
            key: UniqueKey(),
            icon: Icon(Icons.add),
            onPressed: showActInsertEmprego,
          );
          break;
        case 1:
          return DropDownPeriodos(
            key: UniqueKey(),
          );
          break;
        case 2:
          return Container(key: UniqueKey());
          break;
        default:
          return Container();
      }
    }

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: getActionByPos(pos),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      transitionBuilder: (Widget child, Animation<double> anim) {
        return FadeTransition(
          opacity: anim,
          alwaysIncludeSemantics: true,
          child: SizeTransition(
            axis: Axis.horizontal,
            sizeFactor: anim,
            axisAlignment: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: child,
            ),
          ),
        );
      },
    );
  }
}
