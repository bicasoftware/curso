import 'dart:math';

import 'package:flutter/material.dart';

class RadialRainbowPainter extends CustomPainter {
  RadialRainbowPainter({this.colors, this.width});

  List<Color> colors;
  double width;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = min(size.width / 2, size.height / 2);

    for (var i = colors.length; i > 0; i--) {
      final Paint arc = Paint()
        ..color = colors[i - 1]
        ..strokeCap = StrokeCap.square
        ..style = PaintingStyle.stroke
        ..strokeWidth = width;

      final double arcAngle = 2 * pi * (i / colors.length);

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
