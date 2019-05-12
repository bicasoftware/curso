import 'package:bloc_provider/bloc_provider.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/calendario_strip_container.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/view/view_calendario/widgets/calendario_strip_cell.dart';
import 'package:curso/widgets/placeholders/awaiting_container.dart';
import 'package:flutter/material.dart';

class CalendarioStrip extends StatefulWidget {
  @override
  _CalendarioStripState createState() => _CalendarioStripState();
}

class _CalendarioStripState extends State<CalendarioStrip> {
  @override
  Widget build(BuildContext context) {
    final b = BlocProvider.of<BlocMain>(context);

    return StreamBuilder<CalendarioStripContainer>(
      stream: b.outCalendario,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ScrollController controller = ScrollController(
            initialScrollOffset: snapshot.data.initialOffset,
          );

          return Column(
            children: [
              Container(
                height: 60,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        controller: controller,
                        addRepaintBoundaries: true,
                        children: snapshot.data.calendario.dates.map((date) {
                          return CalendarioStripCell(
                            selectedDate: snapshot.data.selectedDate,
                            dataDTO: date,
                            onTap: () => b.setCurrentDate(date.date),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  formatFullDayString(snapshot.data.selectedDate),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle
                      .copyWith(color: Theme.of(context).accentColor),
                ),
              ),
            ],
          );
        } else
          return AwaitingContainer();
      },
    );
  }
}
