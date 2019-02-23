import 'package:auto_size_text/auto_size_text.dart';
import 'package:curso/widgets/default_list_tile.dart';
import 'package:flutter/material.dart';

import '../utils.dart/Formatting.dart';

class HorarioAulaTile extends StatelessWidget {
  final int ordemAula;
  final DateTime inicio, termino;

  const HorarioAulaTile({
    Key key,
    @required this.ordemAula,
    @required this.inicio,
    @required this.termino,
  }) : super(key: key);

  String get horarios =>
      "das ${Formatting.formatTime(inicio)} até ${Formatting.formatTime(termino)}";

  TextStyle chipStyle(BuildContext context) {
    return TextStyle(
      fontSize: 14,
      color: Colors.white70,
    );
  }

  String get ini => Formatting.formatTime(inicio);
  String get end => Formatting.formatTime(termino);

  @override
  Widget build(BuildContext context) {
    return DefaultListTile(
      icon: Icons.timelapse,
      leading: Text("${ordemAula + 1}ª aula"),
      trailing: Chip(
        padding: EdgeInsets.symmetric(horizontal: 8),
        avatar: Icon(Icons.timeline, color: Colors.white,),
        label: Text(
          "$ini | $end",
          style: chipStyle(context),
        ),
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }
}
