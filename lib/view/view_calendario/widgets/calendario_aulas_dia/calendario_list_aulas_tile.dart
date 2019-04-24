import 'package:curso/container/calendario.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/widgets/horario_aula_tile_chip.dart';
import 'package:flutter/material.dart';

class CalendarioAulasDiaTile extends StatelessWidget {
  const CalendarioAulasDiaTile({
    Key key,
    @required this.aulasSemana,
    @required this.onChanged,
    @required this.ordem,
  }) : super(key: key);

  final AulasSemanaDTO aulasSemana;
  final Function(AulasSemanaDTO, bool) onChanged;
  final int ordem;

  @override
  Widget build(BuildContext context) {
    return aulasSemana.idMateria == null
        ? ListTile(
            title: Icon(
              Icons.tag_faces,
              color: Theme.of(context).primaryColorLight,
            ),
          )
        : ListTile(            
            leading: HorarioAulaChip(
              color: Color(aulasSemana.cor),
              text: "${ordem + 1}ª ${Strings.aula}",
            ),
            title: Text(aulasSemana.nome),
            subtitle: Text("${formatTime(aulasSemana.horario)}"),
            trailing: Switch(
              value: aulasSemana.isFalta,
              onChanged: (bool s) => onChanged(aulasSemana, s),
              materialTapTargetSize: MaterialTapTargetSize.padded,
            ),
          );
  }
}
