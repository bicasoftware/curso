import 'package:curso/container/periodos.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/widgets/dialog_picker_materias.dart';
import 'package:curso/widgets/dialog_picker_materias_fallback.dart';
import 'package:flutter/material.dart';

class BottomSheetMaterias extends StatelessWidget {
  final Periodos periodo;

  const BottomSheetMaterias({Key key, @required this.periodo}) : super(key: key);

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
          child: periodo.materias.length > 0
              ? PickerMaterias(
                  materias: periodo.materias,
                  onTap: (int idMateria) {
                    Navigator.of(context).pop(idMateria);
                  },
                )
              : PickerMateriasFallback(periodo: periodo),
        ),
      ],
    );
  }
}
