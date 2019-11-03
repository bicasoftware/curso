import 'package:flutter/material.dart';

class RoundedCornerContainer extends StatelessWidget {
  const RoundedCornerContainer({
    @required this.child,
    this.radius = 48,
    this.color = Colors.white,
    this.padding,
    Key key,
  }) : super(key: key);

  final Widget child;
  final double radius;
  final Color color;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: Container(
        padding: padding,
        width: double.maxFinite,
        child: child,
      ),
    );
  }
}
