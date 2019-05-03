import 'package:curso/container/materias.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/widgets/cronograma/Cronograma.dart';
import 'package:curso/widgets/labeled_button.dart';
import 'package:curso/widgets/squared_card.dart';
import 'package:curso/widgets/weekday_header.dart';
import 'package:flutter/material.dart';

typedef OnNotasTapped = Function(Periodos);

class ViewPeriodosBuilder {
  static Widget listPeriodos({
    @required BuildContext context,
    @required List<Periodos> periodos,
    @required Function(Periodos) onUpdateTap,
    @required Function(int) onDelete,
    @required Function(List<Materias>, int idPeriodo, double medAprov) onMateriasTap,
    @required OnNotasTapped onNotasTap,
    @required Function(int, int, Periodos, int) onCellClick,
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
          onNotasTap: onNotasTap,
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
    @required OnNotasTapped onNotasTap,
    @required Function(int, int, Periodos, int) onCellClick,
  }) {
    return SquaredCard(
      elevation: 1,
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
            Divider(height: 8),
            Padding(
              padding: EdgeInsets.all(4),
              child: Column(
                children: <Widget>[
                  WeekDayHeader(),
                  Cronograma(periodo: periodo, onCellClick: onCellClick),
                ],
              ),
            ),
            Divider(height: 8),
            _buttonBar(
              context: context,
              periodo: periodo,
              onDelete: onDelete,
              onMateriasTap: onMateriasTap,
              onUpdateTap: onUpdateTap,
              onNotasTap: onNotasTap,
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buttonBar({
    @required BuildContext context,
    @required Periodos periodo,
    @required Function(Periodos) onUpdateTap,
    @required Function(int) onDelete,
    @required Function(List<Materias>, int idPeriodo, double medAprov) onMateriasTap,
    @required OnNotasTapped onNotasTap,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        LabeledButton(
          height: 60,
          width: 60,
          label: Strings.materias,
          icon: Icon(
            Icons.school,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () => onMateriasTap(periodo.materias, periodo.id, periodo.medAprov),
        ),
        LabeledButton(
          height: 60,
          width: 60,
          label: Strings.provas,
          icon: Icon(
            Icons.insert_drive_file,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () => onNotasTap(periodo),
        ),
        LabeledButton(
          height: 60,
          width: 60,
          icon: Icon(
            Icons.donut_small,
            color: Theme.of(context).accentColor,
          ),
          label: Strings.editar,
          onPressed: () => onUpdateTap(periodo),
        )
      ],
    );
  }
}
