import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/view/view_periodos_insert/horario_aula_tile_chip.dart';
import 'package:flutter/material.dart';
import 'package:helper_tiles/helper_tiles.dart';

class HorarioAulaTile extends StatelessWidget {
  final int ordemAula;
  final DateTime inicio, termino;
  final Function(int, DateTime, DateTime) onOrdemAulaTap;

  const HorarioAulaTile({
    Key key,
    @required this.ordemAula,
    @required this.inicio,
    @required this.termino,
    @required this.onOrdemAulaTap,
  }) : super(key: key);

  String get ini => formatTime(inicio);
  String get end => formatTime(termino);

  @override
  Widget build(BuildContext context) {
    return DefaultListTile(
      onTap: () => onOrdemAulaTap(ordemAula, inicio, termino),
      icon: Icons.access_time,
      leading: Text("${ordemAula + 1}ª aula"),
      trailing: HorarioAulaChip(color: Theme.of(context).accentColor, text: "$ini | $end"),
    );
  }
}
