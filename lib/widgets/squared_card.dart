import 'package:flutter/material.dart';

class SquaredCard extends StatelessWidget {
  final Widget child;
  final double elevation, margin;

  const SquaredCard({Key key, this.child, this.elevation, this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? 2,
      margin: EdgeInsets.all(margin ?? 4.0),
      child: child,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
    );
  }
}
