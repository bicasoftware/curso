import 'package:curso/container/CronogramaListContainer.dart';
import 'package:curso/container/periodos.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CronogramaRow extends StatelessWidget {
  final int ordemAula;
  final List<CronogramaListContainer> container;
  final Function(int, int, Periodos) onTap;
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
              context: context, cor: c.corMateria, sigla: c.sigla, weekDay: i, periodo: periodo);
        }),
      ),
    );
  }

  Widget _item({
    BuildContext context,
    Color cor,
    String sigla,
    int weekDay,
    Periodos periodo,
  }) {
    return Expanded(
      child: InkWell(
        splashColor: Theme.of(context).accentColor,
        onTap: () => onTap(weekDay, ordemAula, periodo),
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
