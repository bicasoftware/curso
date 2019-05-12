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

class ViewCalendarioState extends State<ViewCalendario>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
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
            elevation: 1,
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Theme.of(context).primaryColorLight,
                    tabs: [
                      Tab(child: Text(Strings.aulas)),
                      Tab(child: Text(Strings.provas)),
                    ],
                  ),
                  Divider(height: 0),
                  Expanded(
                    child: TabBarView(
                      children: [
                        CalendarioAulasDia(),
                        CalendarioProvasDia(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
