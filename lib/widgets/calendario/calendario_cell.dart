import 'package:curso/widgets/circle.dart';
import 'package:flutter/material.dart';

class CalendarioCell extends StatelessWidget {
  final DateTime date;

  const CalendarioCell({Key key, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return date != null
        ? Container(
            color: Colors.white54,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${date.day}",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                Circle(
                  size: 8,
                  color: Colors.red.value,
                ),
              ],
            ),
          )
        : Container();
  }
}
