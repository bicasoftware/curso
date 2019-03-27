import 'package:flutter/material.dart';

class ExpandedContainer extends StatelessWidget {
  ///Retorna um Row() dentro de um Expanded,
  ///feito apenas para diminuir a widget tree

  final Widget child;
  final int flex;
  final Color color;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry padding;
  final BoxConstraints constraints;
  final EdgeInsetsGeometry margin;
  final Decoration decoration;

  const ExpandedContainer({
    Key key,
    this.child,
    this.flex: 1,
    this.color,
    this.alignment,
    this.padding,
    this.constraints,
    this.margin,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        child: this.child,
        color: this.color,
        alignment: this.alignment,
        padding: this.padding,
        constraints: this.constraints,
        margin: this.margin,
        decoration: this.decoration,
      ),
    );
  }
}
