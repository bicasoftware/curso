import 'package:curso/utils.dart/Strings.dart';
import 'package:flutter/material.dart';

class ViewInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Center(child: Text(Strings.parciais)),
    );
  }
}
