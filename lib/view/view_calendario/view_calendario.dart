import 'package:curso/widgets/calendario/calendario.dart';
import 'package:curso/widgets/calendario/calendario_aulas_dia/calendario_aulas_dia.dart';
import 'package:curso/widgets/squared_card.dart';
import 'package:flutter/material.dart';

class ViewCalendario extends StatefulWidget {
  @override
  ViewCalendarioState createState() => ViewCalendarioState();
}

class ViewCalendarioState extends State<ViewCalendario> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SquaredCard(
          elevation: 1,
          child: Column(
            children: <Widget>[
              CalendarioNavigator(),
              Divider(height: 0),
              CalendarioStrip(),
            ],
          ),
        ),
        Expanded(
          child: SquaredCard(
            elevation: 4,
            child: CalendarioAulasDia(),
          ),
        ),
      ],
    );
  }
}
