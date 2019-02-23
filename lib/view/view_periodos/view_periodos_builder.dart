import 'package:flutter/material.dart';

import '../../container/materias.dart';
import '../../container/periodos.dart';
import '../../utils.dart/Strings.dart';
import '../../widgets/weekday_header.dart';
import '../../widgets/cronograma/Cronograma.dart';

class ViewPeriodosBuilder {
  static Widget _buttonBar({
    @required BuildContext context,
    @required Periodos periodo,
    @required Function(Periodos) onUpdateTap,
    @required Function(int) onDelete,
    @required Function(List<Materias>, int idPeriodo, double medAprov) onMateriasTap,
  }) {
    final ThemeData theme = Theme.of(context);
    return ButtonBar(
      //crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.school,
            color: theme.accentColor,
          ),
          onPressed: () => onMateriasTap(periodo.materias, periodo.id, periodo.medAprov),
        ),
        IconButton(
          icon: Icon(
            Icons.insert_drive_file,
            color: theme.accentColor,
          ),
          onPressed: () {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text("Não implementado"),
                duration: Duration(milliseconds: 1000),
              ),
            );
            print("Não implementado");
          },
        ),
        IconButton(
          icon: Icon(
            Icons.calendar_view_day,
            color: theme.accentColor,
          ),
          onPressed: () => onUpdateTap(periodo),
        ),
      ],
    );
  }

  static Widget listPeriodos({
    BuildContext context,
    List<Periodos> periodos,
    Function(Periodos) onUpdateTap,
    Function(int) onDelete,
    Function(List<Materias>, int idPeriodo, double medAprov) onMateriasTap,
    Function(int, int, Periodos, int) onCellClick,
  }) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: periodos.length,
      itemBuilder: (c, i) {
        return _expandedTile(
          context: c,
          periodo: periodos[i],
          onUpdateTap: onUpdateTap,
          onDelete: onDelete,
          onMateriasTap: onMateriasTap,
          onCellClick: onCellClick,
        );
      },
    );
  }

  static Widget _expandedTile({
    @required BuildContext context,
    @required Periodos periodo,
    @required Function(Periodos) onUpdateTap,
    @required Function(int) onDelete,
    @required Function(List<Materias>, int idPeriodo, double medAprov) onMateriasTap,
    @required Function(int, int, Periodos, int) onCellClick,
  }) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.all(1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      child: GestureDetector(
        onLongPress: () {
          onDelete(periodo.id);
        },
        child: ExpansionTile(
          leading: Icon(
            Icons.date_range,
            color: Theme.of(context).accentColor,
          ),
          title: Text("${periodo.numPeriodo}º ${Strings.periodo}"),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(4),
              child: Column(
                children: <Widget>[
                  WeekDayHeader(),
                  Cronograma(periodo: periodo, onCellClick: onCellClick),
                ],
              ),
            ),
            _buttonBar(
              context: context,
              periodo: periodo,
              onDelete: onDelete,
              onMateriasTap: onMateriasTap,
              onUpdateTap: onUpdateTap,
            ),
          ],
        ),
      ),
    );
  }
}
