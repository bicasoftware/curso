import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/calendario_content.dart';
import 'package:curso/widgets/awaiting_container.dart';
import 'package:curso/widgets/calendario/calendario.dart';
import 'package:flutter/material.dart';

class CalendarioStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final b = BlocProvider.of<BlocMain>(context);

    return StreamBuilder<CalendarioDTO>(
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
                    children: snapshot.data.dates.map((date) {
                      return CalendarioStripCell(
                        today: date,
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
