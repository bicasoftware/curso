import 'package:curso/models/aulas.dart';
import 'package:curso/models/periodos.dart';
import 'package:curso/widgets/cronograma/cronograma_cell_container.dart';
import 'package:curso/widgets/cronograma/cronograma_row.dart';
import 'package:flutter/material.dart';

class Cronograma extends StatelessWidget {
  const Cronograma({
    @required this.periodo,
    @required this.onCellClick,
    Key key,
  }) : super(key: key);

  final Periodos periodo;
  final Function(int, int, Periodos, int) onCellClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (int i = 0; i < periodo.aulasdia; i++)
          CronogramaRow(
            ordemAula: i,
            container: _getRowContainer(i),
            onTap: onCellClick,
            periodo: periodo,
          )
      ],
    );
  }

  List<CronogramaCellContainer> _getRowContainer(int ordemAula) {
    final container = List.generate(
      7,
      (i) {
        return CronogramaCellContainer(
          weekDay: i,
          corMateria: null,
          sigla: null,
          idAula: null,
        );
      },
    );

    for (var i = 0; i < 7; i++) {
      for (final materia in periodo.materias) {
        final Aulas aula = materia.aulas.firstWhere(
          (a) => a.ordem == ordemAula && a.weekday == i,
          orElse: () => null,
        );

        if (aula != null) {
          container[i] = CronogramaCellContainer(
            corMateria: Color(materia.cor),
            weekDay: i,
            sigla: materia.sigla,
            idAula: aula.id,
          );
        }
      }
    }

    return container;
  }
}
