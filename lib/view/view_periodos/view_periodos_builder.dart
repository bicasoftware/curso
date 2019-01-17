import 'package:curso/container/periodos.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/widgets/Cronograma.dart';
import 'package:curso/widgets/WeekDayHeader.dart';
import 'package:flutter/material.dart';

class ViewPeriodosBuilder {
  static Widget listPeriodos(BuildContext context, List<Periodos> periodos, Function(int) onTap) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: periodos.length,
      itemBuilder: (c, i) {
        return _expandedTile(c, periodos[i], onTap);
      },
    );
  }

  static Widget _expandedTile(BuildContext c, Periodos p, Function(int) onTap) {
    return ExpansionTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(c).accentColor,
        child: Icon(Icons.date_range),
      ),
      title: Text("${p.id}º ${Strings.periodo}"),
      children: <Widget>[
        Text(Strings.cronograma),
        SizedBox(height: 8),
        WeekDayHeader(),
        Cronograma(periodo: p),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              child: Text(Strings.materias),
              onPressed: () {},
            ),
            FlatButton(
              child: Text(Strings.provas),
              onPressed: () {},
            )
          ],
        )
      ],
    );
  }
}
