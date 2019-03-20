import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/widgets/rainbow_radial/rainbow_indicator.dart';
import 'package:flutter/material.dart';

class CalendarioStripCell extends StatelessWidget {
  final DateTime date;
  final VoidCallback onTap;

  const CalendarioStripCell({
    Key key,
    @required this.date,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        width: 40,
        color: isToday(date) ? Colors.white10 : Colors.transparent,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              weekDayText(),
              RainbowIndicator(
                child: monthDayText(),
                lineWidth: 2,
                size: Offset(25,25),
                colors: [
                  Colors.red,
                  Colors.green,
                  Colors.blue,
                  Colors.yellow,
                  Colors.orange,
                  Colors.lightGreen,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget monthDayText() {
    return Text(
      "${date.day}",
      style: TextStyle(
        fontSize: 18,
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
      formatWeekDay(date),
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
