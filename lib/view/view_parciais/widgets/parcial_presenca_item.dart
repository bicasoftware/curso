import 'package:curso/widgets/circle.dart';
import 'package:flutter/material.dart';

class ParcialPresencaItem extends StatelessWidget {
  final int valor;
  final String title;
  final Color cor;

  const ParcialPresencaItem({
    Key key,
    @required this.valor,
    @required this.title,
    @required this.cor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      child: Row(
        children: <Widget>[
          Circle(color: cor.value, size: 20),
          SizedBox(width: 8),
          Text(title),
          Spacer(),
          Text(valor.toString().padLeft(3, "0"), textAlign: TextAlign.end),
        ],
      ),
    );
  }
}
