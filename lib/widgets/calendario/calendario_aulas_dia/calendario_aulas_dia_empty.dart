import 'package:curso/utils.dart/Strings.dart';
import 'package:flutter/material.dart';

class CalendarioAulasDiaEmpty extends StatelessWidget {
  const CalendarioAulasDiaEmpty({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Strings.semAulasHoje,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
