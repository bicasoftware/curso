import 'package:flutter/material.dart';

class RoundedBottomSheetContainer extends StatelessWidget {
  final Widget child;
  final double radius;

  const RoundedBottomSheetContainer({Key key, this.child, this.radius = 30}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(      
      width: double.infinity,
      child: child,
    );
  }
}
