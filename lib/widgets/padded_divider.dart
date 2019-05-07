import 'package:flutter/material.dart';

class PaddedDivider extends StatelessWidget {
  final double height;
  final EdgeInsets padding;

  const PaddedDivider({Key key, this.height, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 8),
      child: Divider(height: height ?? 0),
    );
  }
}
