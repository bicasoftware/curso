import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/widgets/week_day_text.dart';
import 'package:flutter/material.dart';

class ViewPeriodosCronogramaHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: Arrays.weekDayShort.map((it) => WeekDayText(weekDay: it.toString())).toList(),
    );
  }
}
