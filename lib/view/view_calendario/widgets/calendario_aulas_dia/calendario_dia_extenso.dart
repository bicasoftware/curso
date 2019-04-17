import 'package:curso/utils.dart/date_utils.dart';
import 'package:flutter/material.dart';

class DiaExtensoText extends StatelessWidget {
  final DateTime date;

  const DiaExtensoText({Key key, @required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            formatFullDayString(date),
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
