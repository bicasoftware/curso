import 'package:flutter/material.dart';

class SquaredCard extends StatelessWidget {
  final Widget child;
  final double elevation;

  const SquaredCard({Key key, this.child, this.elevation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? 2,
      child: child,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
    );
  }
}
