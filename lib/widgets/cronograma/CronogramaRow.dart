import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../container/periodos.dart';
import 'package:curso/widgets/cronograma/cronograma_cell_container.dart';

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
          return _item(
            context: context,
            cor: c.corMateria,
            sigla: c.sigla,
            weekDay: i,
            periodo: periodo,
            idAula: c.idAula,
          );
        }),
      ),
    );
  }

  Widget _item({
    @required BuildContext context,
    @required Color cor,
    @required String sigla,
    @required int weekDay,
    @required Periodos periodo, int idAula,
  }) {
    return Expanded(
      child: InkWell(
        splashColor: Theme.of(context).accentColor,
        onTap: () => onTap(weekDay, ordemAula, periodo, idAula),
        child: Container(
          height: 48,
          margin: EdgeInsets.symmetric(horizontal: 1),
          color: cor ?? Theme.of(context).dividerColor,
          child: Center(
            child: AutoSizeText(
              sigla ?? "${ordemAula + 1}ª Aula",
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
      ),
    );
  }
}
