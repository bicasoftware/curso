import 'package:curso/utils.dart/Strings.dart';
import 'package:flutter/material.dart';

class WeekDayHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: Arrays.weekDayShort.map((it) => _item(context, it)).toList(),
    );
  }

  Widget _item(BuildContext c, String d) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(2),
        margin: EdgeInsets.symmetric(horizontal: 1),
        color: Colors.grey[200],
        child: Text(
          d,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
