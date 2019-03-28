import 'package:auto_size_text/auto_size_text.dart';
import 'package:curso/container/calendario_content.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/widgets/horario_aula_tile_chip.dart';
import 'package:flutter/material.dart';

class AulasDiaList extends StatelessWidget {
  final List<AulasSemanaDTO> aulas;

  const AulasDiaList({Key key, @required this.aulas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: aulas.length,
      shrinkWrap: true,
      itemBuilder: (c, i) {
        final aulasSemana = aulas[i];
        return ListTile(
          leading: HorarioAulaChip(text: formatTime(aulasSemana.horario)),
          title: AutoSizeText(aulasSemana.nome),
          trailing: CircleAvatar(
            backgroundColor: Color(aulasSemana.cor),
          ),
        );
      },
      separatorBuilder: (c, i) => Divider(height: 0),
    );
  }
}
