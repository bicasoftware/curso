import 'package:curso/container/calendario.dart';
import 'package:curso/container/cronograma.dart';
import 'package:curso/view/view_provas/view_provas_list_item.dart';
import 'package:flutter/material.dart';

class ProvasList extends StatelessWidget {
  final List<CronogramaDates> dates;
  final List<AulasSemanaDTO> aulasSemana;
  final Function(CronogramaDates) onTileTap;

  const ProvasList({
    Key key,
    @required this.dates,
    @required this.onTileTap,
    this.aulasSemana,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dates.length,
      shrinkWrap: true,
      itemBuilder: (c, i) {
        return ProvasListItem(
          dates: dates[i],
          onTap: onTileTap,
        );
      },
    );
  }
}
