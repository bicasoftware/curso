import 'package:flutter/material.dart';
import 'dart:math';

class RadialRainbowPainter extends CustomPainter {
  List<Color> colors;
  double width;
  RadialRainbowPainter({this.colors, this.width});
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    for (var i = colors.length; i > 0; i--) {
      Paint arc = new Paint()
        ..color = colors[i-1]
        ..strokeCap = StrokeCap.square
        ..style = PaintingStyle.stroke
        ..strokeWidth = width;

      double arcAngle = 2 * pi * (i / colors.length);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi / 2,
        arcAngle,
        false,
        arc,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
