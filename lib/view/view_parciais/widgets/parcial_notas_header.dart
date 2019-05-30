import 'package:curso/utils.dart/Strings.dart';
import 'package:flutter/material.dart';

class ParcialNotasHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: Colors.black,
      fontSize: 14,
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(flex: 2, child: Text(Strings.provas, style: style)),
          Expanded(flex: 4, child: Text(Strings.notas, style: style)),
        ],
      ),
    );
  }
}
