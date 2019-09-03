import 'package:curso/container/notas.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/utils.dart/double_utils.dart';
import 'package:flutter/material.dart';

class ParcialNotasItem extends StatelessWidget {
  const ParcialNotasItem({
    @required this.nota,
    @required this.medAprov,
    Key key,
  }) : super(key: key);

  final Notas nota;
  final double medAprov;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              flex: 2, child: Text("${Strings.data}: ${formatDate(nota.data)}", style: getStyle())),
          Expanded(
              flex: 4, child: Text("${Strings.nota}: ${formatNota(nota.nota)}", style: getStyle())),
        ],
      ),
    );
  }

  TextStyle getStyle() {
    final style = TextStyle(fontSize: 12);

    if (DateTime.now().isBefore(nota.data)) {
      return style.copyWith(color: Colors.white60);
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
