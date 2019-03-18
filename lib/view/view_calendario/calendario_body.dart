import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/utils.dart/pair.dart';
import 'package:curso/view/view_calendario/calendario_cell.dart';
import 'package:flutter/material.dart';

class CalendarioBody extends StatelessWidget {
  const CalendarioBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = BlocProvider.of<BlocMain>(context);

    return StreamBuilder<Pair<int, List<DateTime>>>(
      stream: b.outCalendario,
      initialData: Pair(first: 0, second: []),
      builder: (context, snapshot) {
        return Container(
          color: Theme.of(context).primaryColor,
          child: GridView.count(
            shrinkWrap: true,
            childAspectRatio: 1.5,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 7,
            children: leftFillCalendar(snapshot.data.second)
                .map((date) => CalendarioCell(date: date))
                .toList(),
          ),
        );
      },
    );
  }
}
