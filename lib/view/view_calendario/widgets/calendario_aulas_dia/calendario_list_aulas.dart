import 'package:curso/container/calendario.dart';
import 'package:curso/view/view_calendario/widgets/calendario_aulas_dia/calendario_list_aulas_tile.dart';
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
      shrinkWrap: true,
      itemCount: aulas.length,
      itemBuilder: (c, i) {
        return CalendarioAulasDiaTile(
          ordem: i,
          aulasSemana: aulas[i],
          onChanged: onChanged,
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
