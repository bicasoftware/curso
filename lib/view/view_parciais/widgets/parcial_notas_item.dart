import 'package:curso/container/notas.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/utils.dart/double_utils.dart';
import 'package:flutter/material.dart';

class ParcialNotasItem extends StatelessWidget {
  final Notas nota;

  const ParcialNotasItem({
    Key key,
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
          Expanded(flex: 2, child: Text(formatDate(nota.data), style: style)),
          Expanded(flex: 4, child: Text(formatNota(nota.nota), style: style)),
        ],
      ),
    );
  }
}
