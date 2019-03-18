import 'package:curso/utils.dart/Strings.dart';
import 'package:flutter/material.dart';

class CalendarioHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: Arrays.weekDaySigla.map((d) => _item(d)).toList(),
      ),
    );
  }

  Widget _item(String label) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8),
        color: Colors.white10,
        child: Text(
          label,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),

          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
