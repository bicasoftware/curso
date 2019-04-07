import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/calendario_content.dart';
import 'package:curso/utils.dart/pair.dart';
import 'package:curso/widgets/awaiting_container.dart';
import 'package:curso/widgets/calendario/calendario.dart';
import 'package:flutter/material.dart';

class CalendarioStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final b = BlocProvider.of<BlocMain>(context);

    return StreamBuilder<Pair<CalendarioDTO, DateTime>>(
      stream: b.outCalendario,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: 60,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    addRepaintBoundaries: true,
                    children: snapshot.data.first.dates.map((date) {
                      return CalendarioStripCell(
                        selectedDate: snapshot.data.second,
                        dataDTO: date,
                        onTap: () => b.setCurrentDate(date.date),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        } else
          return AwaitingContainer();
      },
    );
  }
}
