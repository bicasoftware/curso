import 'package:bloc_provider/bloc_provider.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/calendario_strip_container.dart';
import 'package:curso/view/view_calendario/widgets/calendario_strip_cell.dart';
import 'package:curso/widgets/placeholders/stream_builder_child.dart';
import 'package:flutter/material.dart';

class CalendarioStrip extends StatefulWidget {
  @override
  _CalendarioStripState createState() => _CalendarioStripState();
}

class _CalendarioStripState extends State<CalendarioStrip> {
  @override
  Widget build(BuildContext context) {
    final b = BlocProvider.of<BlocMain>(context);

    return StreamAwaiter<CalendarioStripContainer>(
      stream: b.outCalendario,
      widgetBuilder: (BuildContext context, CalendarioStripContainer data) {
        ScrollController controller = ScrollController(
          initialScrollOffset: data.initialOffset,
        );

        return Column(
          children: [
            Container(
              height: 70,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      controller: controller,
                      addRepaintBoundaries: true,
                      children: data.calendario.dates.map((date) {
                        return CalendarioStripCell(
                          selectedDate: data.selectedDate,
                          dataDTO: date,
                          onTap: () => b.setCurrentDate(date.date),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
