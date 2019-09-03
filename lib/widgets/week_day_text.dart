import 'package:flutter/material.dart';

class WeekDayText extends StatelessWidget {
  const WeekDayText({@required this.weekDay, Key key}) : super(key: key);

  final String weekDay;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(2),
        margin: const EdgeInsets.symmetric(horizontal: 1),
        child: Text(
          weekDay,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,            
            fontWeight: FontWeight.bold,
            color: Theme.of(context).unselectedWidgetColor,
          ),
        ),
      ),
    );
  }
}
