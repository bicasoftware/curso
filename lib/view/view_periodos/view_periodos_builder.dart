import 'package:curso/container/materias.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/widgets/cronograma/Cronograma.dart';
import 'package:curso/widgets/DiaSemanaHeader.dart';
import 'package:flutter/material.dart';

class ViewPeriodosBuilder {
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
    return GestureDetector(
      onLongPress: () {
        onDelete(periodo.id);
      },
      child: ExpansionTile(
        leading: Icon(Icons.date_range),
        title: Text("${periodo.numPeriodo}º ${Strings.periodo}"),
        children: <Widget>[
          WeekDayHeader(),
          SizedBox(height: 0.5),
          Cronograma(periodo: periodo, onCellClick: onCellClick),
          SizedBox(height: 16),
          Row(
            children: <Widget>[
              FlatButton(
                child: Text(Strings.editar),
                onPressed: () {
                  onUpdateTap(periodo);
                },
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      child: Text(Strings.materias),
                      onPressed: () {
                        onMateriasTap(periodo.materias, periodo.id, periodo.medAprov);
                      },
                    ),
                    FlatButton(
                      child: Text(Strings.provas),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
