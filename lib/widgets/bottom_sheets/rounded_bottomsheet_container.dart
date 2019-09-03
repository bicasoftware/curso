import 'package:flutter/material.dart';

class RoundedBottomSheetContainer extends StatelessWidget {
  const RoundedBottomSheetContainer({Key key, this.child, this.radius = 30}) : super(key: key);

  final Widget child;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: child,
    );
  }
}
