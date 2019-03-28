import 'package:curso/widgets/calendario/calendario.dart';
import 'package:curso/widgets/calendario/calendario_aulas_dia/calendario_aulas_dia.dart';
import 'package:flutter/material.dart';

class ViewCalendario extends StatefulWidget {
  @override
  ViewCalendarioState createState() => ViewCalendarioState();
}

class ViewCalendarioState extends State<ViewCalendario> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Material(
          elevation: 4,
          color: Theme.of(context).primaryColor,
          child: Column(
            children: <Widget>[
              CalendarioNavigator(),
              CalendarioStrip(),
            ],
          ),
        ),
        CalendarioAulasDia(),
      ],
    );
  }
}
