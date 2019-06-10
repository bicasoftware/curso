import 'package:curso/container/periodos.dart';
import 'package:curso/custom_themes.dart';
import 'package:curso/view/view_calendario/widgets/dropdown_periodos.dart';
import 'package:curso/view/view_periodos_insert/view_periodos_insert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewHomeAppbarAction extends StatelessWidget {
  final int pos;
  final Function(Periodos) onInsertPeriodos;

  const ViewHomeAppbarAction({
    Key key,
    @required this.pos,
    @required this.onInsertPeriodos,
  }) : super(key: key);

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

      if (result != null) onInsertPeriodos(result);
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
            theme: CustomThemes.primaryColorThemeData,
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
            child: child,
          ),
        );
      },
    );
  }
}
