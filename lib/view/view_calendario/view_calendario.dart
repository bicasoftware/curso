import 'package:curso/view/view_calendario/widgets/calendario_content/calendario_content_list.dart';
import 'package:curso/view/view_calendario/widgets/calendario_strip/calendario_navigator.dart';
import 'package:curso/view/view_calendario/widgets/calendario_strip/calendario_strip.dart';
import 'package:curso/widgets/padded_divider.dart';
import 'package:curso/widgets/squared_card.dart';
import 'package:flutter/material.dart';

class ViewCalendario extends StatefulWidget {
  const ViewCalendario({Key key}) : super(key: key);

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
          child: Column(
            children: const <Widget>[
              CalendarioNavigator(),
              PaddedDivider(height: 0, padding: EdgeInsets.symmetric(horizontal: 64)),
              CalendarioStrip(),
            ],
          ),
        ),
        const Expanded(
          child: SquaredCard(child: CalendarioAulasProvas()),
        ),
      ],
    );
  }
}
