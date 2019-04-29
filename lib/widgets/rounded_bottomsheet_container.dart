import 'package:flutter/material.dart';

class RoundedBottomSheetContainer extends StatelessWidget {
  final Widget child;
  final double radius;

  const RoundedBottomSheetContainer({Key key, this.child, this.radius: 20}) : super(key: key);

  ///Lembrar de alterar o theme em MaterialApp() para canvasColor: Colors.transparent,

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF737373),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
        ),
        child: Container(
          //height: 300.0,
          width: double.infinity,
          child: child,
          color: Colors.white,
        ),
      ),
    );
  }
}
