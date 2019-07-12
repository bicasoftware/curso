import 'package:curso/container/calendario.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/view/view_calendario/widgets/calendario_strip/calendario_strip_cell_indicator.dart';
import 'package:curso/widgets/rainbow_radial/rainbow_indicator.dart';
import 'package:flutter/material.dart';

class CalendarioStripCell extends StatelessWidget {
  final DataDTO dataDTO;
  final DateTime selectedDate;
  final VoidCallback onTap;

  const CalendarioStripCell({
    @required this.dataDTO,
    @required this.onTap,
    @required this.selectedDate,
    Key key,
  }) : super(key: key);

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
              weekDayText(context),
              const SizedBox(height: 4),
              RainbowIndicator(
                child: monthDayText(context),
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

  Widget monthDayText(BuildContext context) {
    return Text(
      "${dataDTO.date.day.toString().padLeft(2, '0')}",
      style: TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
    );
  }

  Widget weekDayText(BuildContext context) {
    return Text(
      formatWeekDay(dataDTO.date),
      style: TextStyle(
        fontSize: 14,
        color: checkToday() ? Colors.black : Theme.of(context).accentColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  bool checkToday() {
    return isToday(dataDTO.date);
  }

  ///Se for hoje, mostra em Azul, se estiver selecionado, mostra Teal, senão, mostra branco
  Color getCellColor(BuildContext context) {
    if (isSameDay(dataDTO.date, selectedDate)) {
      return Colors.orange[50];
    } else if (isToday(dataDTO.date)) {
      return Colors.lightBlue[50];
    } else {
      return Theme.of(context).cardColor;
    }
  }
}
