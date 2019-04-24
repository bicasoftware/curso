import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_calendario/widgets/calendario_aulas_dia/calendario_aulas_dia.dart';
import 'package:curso/view/view_calendario/widgets/calendario_navigator.dart';
import 'package:curso/view/view_calendario/widgets/calendario_provas_dia/calendario_provas_dia.dart';
import 'package:curso/view/view_calendario/widgets/calendario_strip.dart';
import 'package:curso/widgets/squared_card.dart';
import 'package:flutter/material.dart';

class ViewCalendario extends StatefulWidget {
  @override
  ViewCalendarioState createState() => ViewCalendarioState();
}

class ViewCalendarioState extends State<ViewCalendario> with TickerProviderStateMixin {
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
            child: DefaultTabController(
              initialIndex: 0,
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    labelColor: Theme.of(context).primaryColor,
                    tabs: [
                      Tab(text: Strings.aulas),
                      Tab(text: Strings.provas),
                    ],
                  ),
                  Divider(height: 0,),
                  Expanded(
                    child: TabBarView(
                      children: [
                        CalendarioAulasDia(),
                        CalendarioProvasDia(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
