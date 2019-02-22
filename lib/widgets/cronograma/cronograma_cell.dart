import 'package:auto_size_text/auto_size_text.dart';
import 'package:curso/container/periodos.dart';
import 'package:flutter/material.dart';

class CronogramaCell extends StatelessWidget {
  final BuildContext context;
  final Color cor;
  final String sigla;
  final int weekDay;
  final int ordemAula;
  final Periodos periodo;
  final int idAula;
  final Function(int, int, Periodos, int) onCellTap;

  const CronogramaCell({
    Key key,
    @required this.context,
    @required this.cor,
    @required this.sigla,
    @required this.weekDay,
    @required this.ordemAula,
    @required this.periodo,
    @required this.idAula,
    @required this.onCellTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 48,
        margin: EdgeInsets.symmetric(horizontal: 1),
        color: cor ?? Colors.grey[100],
        child: InkWell(
          splashColor: Theme.of(context).accentColor,
          onTap: () => onCellTap(weekDay, ordemAula, periodo, idAula),
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
