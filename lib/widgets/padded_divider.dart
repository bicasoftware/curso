import 'package:flutter/material.dart';

class PaddedDivider extends StatelessWidget {
  final double height;
  final EdgeInsets padding;

  const PaddedDivider({
    Key key,
    this.height: 0,
    this.padding: const EdgeInsets.symmetric(horizontal: 8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Divider(height: height),
    );
  }
}
