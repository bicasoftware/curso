import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  const Circle({
    @required this.color,
    this.size = 30,
    Key key,
  }) : super(key: key);

  final int color;
  final double size;
  
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(color),
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: size,
        width: size,
      ),
    );
  }
}
