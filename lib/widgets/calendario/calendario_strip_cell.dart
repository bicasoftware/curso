import 'package:curso/container/calendario_content.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/widgets/rainbow_radial/rainbow_indicator.dart';
import 'package:flutter/material.dart';

class CalendarioStripCell extends StatelessWidget {
  final DataDTO dataDTO;
  final VoidCallback onTap;

  const CalendarioStripCell({
    Key key,
    @required this.dataDTO,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorList = dataDTO.aulas.map((aula) => Color(aula.cor)).toList();

    return Container(
      color: checkToday() ? Colors.lightBlue[50] : Colors.transparent,

      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                weekDayText(context),
                SizedBox(height: 4),
                RainbowIndicator(
                  child: monthDayText(context),
                  lineWidth: 1.5,
                  size: Offset(25, 25),
                  colors: colorList.length == 0 ? [Colors.lightBlue] : colorList,
                ),
              ],
            ),
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
}
