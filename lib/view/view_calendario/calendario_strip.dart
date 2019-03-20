import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/utils.dart/pair.dart';
import 'package:curso/view/view_calendario/calendario_strip_cell.dart';
import 'package:flutter/material.dart';

class CalendarioStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final b = BlocProvider.of<BlocMain>(context);

    return StreamBuilder<Pair<int, List<DateTime>>>(
      stream: b.outCalendario,
      initialData: Pair(first: 0, second: []),
      builder: (context, snapshot) {
        return Container(
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: snapshot.data.second.map((date) {
                    return CalendarioStripCell(
                      date: date,
                      onTap: () => b.setCurrentDate(date),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
