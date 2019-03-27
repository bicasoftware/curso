import 'package:curso/container/calendario_content.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/widgets/rainbow_radial/rainbow_indicator.dart';
import 'package:flutter/material.dart';

class CalendarioStripCell extends StatelessWidget {
  final DataDTO today;
  final VoidCallback onTap;

  const CalendarioStripCell({
    Key key,
    @required this.today,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorList = today.aulas.map((aula) => Color(aula.cor)).toList();

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        width: 40,
        color: isToday(today.date) ? Colors.white10 : Colors.transparent,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              weekDayText(),
              SizedBox(height: 4),
              RainbowIndicator(
                child: monthDayText(),
                lineWidth: 1.5,
                size: Offset(25, 25),
                colors: colorList.length == 0 ? [Colors.white] : colorList,
                //colors: [Colors.red, Colors.lightBlue, Colors.orange],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget monthDayText() {
    return Text(
      "${today.date.day.toString().padLeft(2, '0')}",
      style: TextStyle(
        fontSize: 14,
        color: Colors.white,
        shadows: [
          Shadow(
            blurRadius: 0.5,
            color: Colors.white,
            offset: Offset(0.2, 0.2),
          ),
        ],
      ),
    );
  }

  Widget weekDayText() {
    return Text(
      formatWeekDay(today.date),
      style: TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontStyle: FontStyle.italic,
        shadows: [
          Shadow(
            blurRadius: 2,
            color: Colors.white30,
            offset: Offset(0.5, 0.5),
          ),
        ],
      ),
    );
  }
}
