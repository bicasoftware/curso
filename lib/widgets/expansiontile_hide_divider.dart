import 'package:flutter/material.dart';

class ExpansionTileHideDivider extends StatelessWidget {
  const ExpansionTileHideDivider({Key key, this.child}) : super(key: key);

  final ExpansionTile child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: child,
    );
  }
}