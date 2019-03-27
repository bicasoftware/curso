import 'package:flutter/material.dart';

class Circle extends StatelessWidget {

  final int color;
  final double size;

  const Circle({Key key, @required this.color, this.size: 30}) : super(key: key);

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
