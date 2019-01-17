import 'package:curso/container/CronogramaListContainer.dart';
import 'package:curso/container/periodos.dart';
import 'package:flutter/material.dart';
import 'CronogramaRow.dart';

class Cronograma extends StatelessWidget {
  final Periodos periodo;

  const Cronograma({Key key, this.periodo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: periodo.aulasDia,
      itemBuilder: (BuildContext c, int i) {
        return CronogramaRow(rowPos: i, container: _getRowContainer(i));
      },
    );
  }

  List<CronogramaListContainer> _getRowContainer(int ordemAula) {
    final container = List.generate(7, (i) {
      return CronogramaListContainer(weekDay: i, corMateria: null, sigla: null);
    });

    for (var i = 0; i < 7; i++) {
      for (final materia in periodo.materias) {
        final aula = materia.aulas.where((a) => a.ordem == ordemAula && a.weekDay == i).toList();
        if (aula.length > 0) {
          container[i] = CronogramaListContainer(
            corMateria: Color(materia.cor),
            weekDay: i,
            sigla: materia.sigla,
          );
        }
      }
    }

    return container;
  }
}