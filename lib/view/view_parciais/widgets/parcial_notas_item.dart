import 'package:curso/container/notas.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/utils.dart/double_utils.dart';
import 'package:flutter/material.dart';

class ParcialNotasItem extends StatelessWidget {
  final Notas nota;
  final double medAprov;

  const ParcialNotasItem({
    Key key,
    @required this.nota,
    @required this.medAprov,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(flex: 2, child: Text(formatDate(nota.data), style: getStyle())),
          Expanded(flex: 4, child: Text(formatNota(nota.nota), style: getStyle())),
        ],
      ),
    );
  }

  TextStyle getStyle() {
    final style = TextStyle(fontSize: 12);

    if (DateTime.now().isBefore(nota.data)) {
      return style.copyWith(color: Colors.black54);
    } else {
      if (nota.nota == null) {
        return style.copyWith(color: Colors.amber, fontWeight: FontWeight.bold);
      } else if (nota.nota < medAprov) {
        return style.copyWith(color: Colors.red);
      } else {
        return style.copyWith(color: Colors.lightBlue);
      }
    }
  }
}
