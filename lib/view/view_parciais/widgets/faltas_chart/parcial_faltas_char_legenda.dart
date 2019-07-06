import 'package:curso/widgets/materia_color_container.dart';
import 'package:flutter/material.dart';

class ParciaisFaltasChartLegenda extends StatelessWidget {
  final int number;
  final String legenda;
  final Color cor;

  const ParciaisFaltasChartLegenda({
    Key key,
    @required this.number,
    @required this.cor,
    @required this.legenda,
  })  : assert(number != null),
        assert(cor != null && cor != Colors.transparent),
        assert(legenda != null && legenda != ""),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          MateriaColorContainer(color: cor, size: 8),
          SizedBox(width: 8),
          Text(legenda, style: theme.textTheme.caption.copyWith(color: theme.accentColor) ),
        ],
      ),
    );
  }
}