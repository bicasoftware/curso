import 'package:flutter/material.dart';

class SquaredCard extends StatelessWidget {
  const SquaredCard({Key key, this.child, this.elevation, this.margin}) : super(key: key);

  final Widget child;
  final double elevation, margin;

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
