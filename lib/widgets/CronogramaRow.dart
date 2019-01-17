import 'package:curso/container/CronogramaListContainer.dart';
import 'package:flutter/material.dart';

class CronogramaRow extends StatelessWidget {
  final int rowPos;
  final List<CronogramaListContainer> container;

  const CronogramaRow({
    Key key,
    @required this.rowPos,
    @required this.container,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: container.map((c) => _item(context, c.corMateria, c.sigla)).toList(),
      ),
    );
  }

  Widget _item(BuildContext c, Color cor, String sigla) {
    return Expanded(
      child: Container(
        height: 48,
        margin: EdgeInsets.symmetric(horizontal: 1),
        color: cor ?? Theme.of(c).dividerColor,
        child: Center(
          child: Text(
            sigla ?? "${rowPos + 1}ª Aula",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10),
          ),
        ),
      ),
    );
  }
}
