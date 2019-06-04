import 'package:curso/container/periodos.dart';
import 'package:curso/widgets/materia_color_container.dart';
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
      child: GestureDetector(
        onTap: () => onCellTap(weekDay, ordemAula, periodo, idAula),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 1),
          child: MateriaColorContainer(          
            type: MaterialType.card,
            size: 48,
            color: cor ?? Theme.of(context).cardColor,
            child: Center(            
              child: Text(
                sigla ?? "${ordemAula + 1}ª Aula",
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: sigla != null ? FontWeight.bold : null,
                  color: (cor != null && cor.computeLuminance() < 0.5) ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
