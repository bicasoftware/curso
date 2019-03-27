import 'package:flutter/material.dart';

import 'package:curso/utils.dart/date_utils.dart';
import 'default_list_tile.dart';

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

  String get horarios =>
      "das ${formatTime(inicio)} até ${formatTime(termino)}";

  TextStyle chipStyle(BuildContext context) {
    return TextStyle(
      fontSize: 14,
      color: Colors.white70,
    );
  }

  String get ini => formatTime(inicio);
  String get end => formatTime(termino);

  @override
  Widget build(BuildContext context) {
    return DefaultListTile(
      onTap: () => onOrdemAulaTap(ordemAula, inicio, termino),
      icon: Icons.timelapse,
      leading: Text("${ordemAula + 1}ª aula"),
      trailing: Chip(
        padding: EdgeInsets.symmetric(horizontal: 8),
        avatar: Icon(
          Icons.timeline,
          color: Colors.white,
        ),
        label: Text(
          "$ini | $end",
          style: chipStyle(context),
        ),
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }
}
