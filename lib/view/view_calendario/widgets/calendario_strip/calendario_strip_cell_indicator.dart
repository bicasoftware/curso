import 'package:curso/widgets/circle.dart';
import 'package:flutter/material.dart';

class CellIndicator extends StatelessWidget {
  const CellIndicator({Key key, this.isFalta, this.isVaga, this.hasProva}) : super(key: key);

  final bool isFalta, isVaga, hasProva;

  @override
  Widget build(BuildContext context) {
    final List<Widget> indicators = [];

    if (isFalta) {
      indicators.add(_indicator(Colors.red.value));
    }

    if (isVaga) {
      indicators.add(_indicator(Colors.lightGreen.value));
    }

    if (hasProva) {
      indicators.add(_indicator(Colors.orange.value));
    }

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: indicators.isNotEmpty ? indicators : [_indicator(Colors.transparent.value)],
    );
  }

  Widget _indicator(int cor) {
    return Container(
      height: 5,
      child: Circle(
        color: cor,
        size: 5,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 2),
    );
  }
}
