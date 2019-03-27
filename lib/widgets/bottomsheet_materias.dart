import 'package:flutter/material.dart';

import '../container/periodos.dart';
import '../utils.dart/Strings.dart';
import 'dialog_picker_materias.dart';

class BottomSheetMaterias extends StatelessWidget {
  final Periodos periodo;

  const BottomSheetMaterias({Key key, @required this.periodo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  Strings.materias,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete_sweep),
                onPressed: () => Navigator.of(context).pop(-1),
              ),
            ],
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
