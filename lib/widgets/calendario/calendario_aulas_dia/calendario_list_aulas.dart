import 'package:curso/container/calendario.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/widgets/horario_aula_tile_chip.dart';
import 'package:flutter/material.dart';

class AulasDiaList extends StatelessWidget {
  final List<AulasSemanaDTO> aulas;
  final Function(AulasSemanaDTO, bool) onChanged;

  const AulasDiaList({
    Key key,
    @required this.aulas,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: aulas.length,
      itemBuilder: (c, i) {
        final AulasSemanaDTO aulasSemana = aulas[i];
        return ListTile(
          dense: true,
          leading: HorarioAulaChip(
            text: formatTime(aulasSemana.horario),
            color: Color(aulasSemana.cor),
          ),
          title: Text(aulasSemana.nome),
          trailing: Switch(
            value: aulasSemana.isFalta,
            onChanged: (bool s) => onChanged(aulasSemana, s),
            materialTapTargetSize: MaterialTapTargetSize.padded,
          ),
        );
      },
      separatorBuilder: (c, i) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Divider(height: 0),
        );
      },
    );
  }
}
