import 'package:curso/container/calendario.dart';
import 'package:curso/view/view_calendario/widgets/calendario_aulas_dia/calendario_list_aulas_tile.dart';
import 'package:curso/widgets/padded_divider.dart';
import 'package:flutter/material.dart';

class AulasDiaList extends StatelessWidget {
  final List<AulasSemanaDTO> aulas;
  final ListAulaAction onOptionSelected;

  const AulasDiaList({
    Key key,
    @required this.aulas,
    @required this.onOptionSelected,
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
          onOptionSelected: onOptionSelected,
        );
      },
      separatorBuilder: (c, i) {
        return PaddedDivider(padding: const EdgeInsets.only(right: 16, left: 120));
      },      
    );
  }
}
