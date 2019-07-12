import 'package:curso/utils.dart/Strings.dart';
import 'package:flutter/material.dart';

class ViewPeriodosCronogramaHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: Arrays.weekDayShort.map((it) => _item(context, it)).toList(),
    );
  }

  Widget _item(BuildContext context, String d) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(2),
        margin: const EdgeInsets.symmetric(horizontal: 1),
        child: Text(
          d,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
