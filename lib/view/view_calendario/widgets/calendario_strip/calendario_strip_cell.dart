import 'package:curso/container/calendario.dart';
// import 'package:curso/custom_colors.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/view/view_calendario/widgets/calendario_strip/calendario_strip_cell_indicator.dart';
import 'package:curso/widgets/rainbow_radial/rainbow_indicator.dart';
import 'package:curso/widgets/week_day_text.dart';
import 'package:flutter/material.dart';

class CalendarioStripCell extends StatelessWidget {
  const CalendarioStripCell({
    @required this.dataDTO,
    @required this.onTap,
    @required this.selectedDate,
    Key key,
  }) : super(key: key);

  final DataDTO dataDTO;
  final DateTime selectedDate;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorList = dataDTO.colorList;
    return Container(
      key: ObjectKey(dataDTO),
      color: getCellColor(context),
      width: 70,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 4),
              WeekDayText(weekDay: formatWeekDay(dataDTO.date)),
              const SizedBox(height: 4),
              RainbowIndicator(
                child: MonthDayText(dataDTO: dataDTO),
                lineWidth: 1.5,
                size: const Offset(25, 25),
                colors: colorList.isEmpty ? [Colors.lightBlue] : colorList,
              ),
              const SizedBox(height: 4),
              CellIndicator(
                isFalta: dataDTO.isFalta,
                isVaga: dataDTO.isVaga,
                hasProva: dataDTO.hasProvas,
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }

  bool checkToday() {
    return isToday(dataDTO.date);
  }

  ///Se for hoje, mostra em primaryColor, se estiver selecionado, mostra em accentColor, senão, mostra branco
  Color getCellColor(BuildContext context) {
    if (isSameDay(dataDTO.date, selectedDate)) {
      return Theme.of(context).focusColor;
    } else if (isToday(dataDTO.date)) {
      return Theme.of(context).hintColor;
    } else {
      return Theme.of(context).cardColor;
    }
  }
}

class MonthDayText extends StatelessWidget {
  const MonthDayText({@required this.dataDTO, Key key}) : super(key: key);

  final DataDTO dataDTO;

  @override
  Widget build(BuildContext context) {
    return Text(
      "${dataDTO.date.day.toString().padLeft(2, '0')}",
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}