import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/utils.dart/double_utils.dart';
import 'package:flutter/material.dart';

class ParcialNotasItem extends StatelessWidget {
  final DateTime data;
  final double nota;

  const ParcialNotasItem({
    Key key,
    @required this.data,
    @required this.nota,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: Colors.black54,
      fontSize: 12,
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(flex: 2, child: Text(formatDate(data), style: style)),
          Expanded(flex: 4, child: Text(formatNota(nota), style: style)),
        ],
      ),
    );
  }
}
