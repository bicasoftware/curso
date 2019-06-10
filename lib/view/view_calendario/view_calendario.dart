import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_calendario/widgets/calendario_aulas_dia/calendario_aulas_dia.dart';
import 'package:curso/view/view_calendario/widgets/calendario_navigator.dart';
import 'package:curso/view/view_calendario/widgets/calendario_provas_dia/calendario_provas_dia.dart';
import 'package:curso/view/view_calendario/widgets/calendario_strip/calendario_strip.dart';
import 'package:curso/widgets/padded_divider.dart';
import 'package:curso/widgets/squared_card.dart';
import 'package:flutter/material.dart';

class ViewCalendario extends StatefulWidget {
  const ViewCalendario({Key key}) : super(key: key);

  @override
  ViewCalendarioState createState() => ViewCalendarioState();
}

class ViewCalendarioState extends State<ViewCalendario> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SquaredCard(
          elevation: 1,
          child: Column(
            children: const <Widget>[
              const CalendarioNavigator(),
              const PaddedDivider(height: 0, padding: EdgeInsets.symmetric(horizontal: 64)),
              const CalendarioStrip(),
            ],
          ),
        ),
        Expanded(
          child: SquaredCard(
            elevation: 1,
            child: DefaultTabController(
              length: 2,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TabBar(
                    labelColor: Theme.of(context).primaryColorDark,
                    unselectedLabelColor: Theme.of(context).primaryColorLight,
                    tabs: [
                      Tab(child: Text(Strings.aulas)),
                      Tab(child: Text(Strings.provas)),
                    ],
                  ),
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
