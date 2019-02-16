import 'package:flutter/material.dart';

import '../container/periodos.dart';
import '../utils.dart/Strings.dart';
import 'dialog_picker_materias.dart';

class BottomSheetMaterias extends StatelessWidget {
  final Periodos periodo;

  const BottomSheetMaterias({Key key, @required this.periodo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          child: Text(
            Strings.materias,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Container(
          child: Divider(height: 1),
          margin: EdgeInsets.symmetric(horizontal: 16),
        ),
        Expanded(
          child: PickerMaterias(
            materias: periodo.materias,
            onTap: (int idMateria) {
              Navigator.of(context).pop(idMateria);
            },
          ),
        ),
      ],
    );
  }
}
