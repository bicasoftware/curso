import 'package:bloc_provider/bloc_provider.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/calendario.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:curso/view/view_calendario/widgets/calendario_strip/calendario_strip_cell.dart';
import 'package:flutter/material.dart';

class CalendarioStrip extends StatelessWidget {
  const CalendarioStrip({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = BlocProvider.of<BlocMain>(context);

    return MultiObserver(
      streams: [b.outSelectedDate, b.outCalendario],
      onSuccess: (BuildContext context, List data) {
        ScrollController controller = ScrollController(
          initialScrollOffset: getCalendarStripPosition(
            selectedDate: data[0],
            calendario: data[1],
          ),
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
                        children: [
                          for (DataDTO date in (data[1] as CalendarioDTO).dates)
                            CalendarioStripCell(
                              selectedDate: data[0],
                              dataDTO: date,
                              onTap: () => b.setCurrentDate(date.date),
                            )
                        ]),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  double getCalendarStripPosition(
      {@required CalendarioDTO calendario, @required DateTime selectedDate}) {
    return _containsDate(calendario?.dates) ? (selectedDate.day - 1) * 70.0 : 0.0;
  }

  bool _containsDate(List<DataDTO> datas) {
    final n = DateTime.now();
    final DataDTO count = datas?.firstWhere(
      (d) => isSameDay(d.date, n),
      orElse: () => null,
    );

    return count != null;
  }
}
