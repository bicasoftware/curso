import 'package:flutter/material.dart';

class ExpandedRow extends StatelessWidget {
  ///Retorna um Row() dentro de um Expanded,
  ///feito apenas para diminuir a widget tree

  final List<Widget> children;
  final int flex;

  const ExpandedRow({Key key, this.children, this.flex: 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(children: children),
    );
  }
}
