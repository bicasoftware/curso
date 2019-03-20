import 'package:flutter/material.dart';
import 'package:curso/widgets/rainbow_radial/radial_rainbow_painter.dart';

class RainbowIndicator extends StatelessWidget {
  final Offset size;
  final Widget child;
  final EdgeInsets padding;
  final List<Color> colors;
  final double lineWidth;

  const RainbowIndicator({
    Key key,
    this.size: const Offset(3.0, 3.0),
    @required this.colors,
    @required this.child,
    this.lineWidth: 3,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.dx,
      height: size.dy,
      child: CustomPaint(
        child: Container(
          padding: EdgeInsets.all(2),
          child: Center(child: child),
        ),
        painter: RadialRainbowPainter(
          colors: colors,
          width: lineWidth,
        ),
      ),
    );
  }
}
