import 'package:flutter/material.dart';

class MateriaColorContainer extends StatelessWidget {
  final Color color;
  final Widget child;
  final double size;
  final MaterialType type;

  const MateriaColorContainer({
    @required this.color,
    this.child,
    this.size = 36,
    this.type = MaterialType.circle,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Colors.black54,
      elevation: 1,
      color: color ?? Theme.of(context).cardColor,
      type: type,
      child: SizedBox(child: child, width: size ?? 48, height: size ?? 48),
    );
  }
}
