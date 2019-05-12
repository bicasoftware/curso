import 'package:flutter/material.dart';

import '../../container/periodos.dart';
import 'cronograma_cell.dart';
import 'cronograma_cell_container.dart';

class CronogramaRow extends StatelessWidget {
  final int ordemAula;
  final List<CronogramaCellContainer> container;
  final Function(int, int, Periodos, int) onTap;
  final Periodos periodo;

  const CronogramaRow({
    Key key,
    @required this.ordemAula,
    @required this.container,
    @required this.onTap,
    @required this.periodo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(container.length, (i) {
          final c = container[i];
          return CronogramaCell(
            context: context,
            cor: c.corMateria,
            sigla: c.sigla,
            weekDay: i,
            periodo: periodo,
            idAula: c.idAula,
            ordemAula: ordemAula,
            onCellTap: onTap,
          );
        }),
      ),
    );
  }
}
