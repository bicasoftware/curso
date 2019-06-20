import 'package:bloc_provider/bloc_provider.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/calendario_strip_container.dart';
import 'package:curso/view/view_calendario/widgets/calendario_strip/calendario_strip_cell.dart';
import 'package:curso/widgets/placeholders/stream_builder_child.dart';
import 'package:flutter/material.dart';

class CalendarioStrip extends StatelessWidget {

  const CalendarioStrip({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = BlocProvider.of<BlocMain>(context);

    return Observer<CalendarioStripContainer>(
      stream: b.outCalendario,
      onSuccess: (BuildContext context, CalendarioStripContainer data) {
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
