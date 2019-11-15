import 'dart:math';

import 'package:flutter/material.dart';

class BgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    /* final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = min(size.width / 2, size.height / 2); */
    final Offset center = Offset(size.width, 0);
    final double radius = min(size.width / 2, size.height / 2);

    final Paint arc = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final double arcAngle = 2 * pi * 2;
    
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      arcAngle,
      false,
      arc,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
