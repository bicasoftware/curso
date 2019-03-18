import 'package:flutter/material.dart';

class ExpandedColumn extends StatelessWidget {
  ///Retorna um Column() dentro de um Expanded,
  ///feito apenas para diminuir a widget tree

  final List<Widget> children;
  final int flex;

  const ExpandedColumn({Key key, this.children, this.flex: 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Column(children: children),
    );
  }
}
