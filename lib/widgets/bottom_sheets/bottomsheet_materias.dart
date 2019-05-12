import 'package:curso/container/materias.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/widgets/dialogs/dialog_picker_materias.dart';
import 'package:flutter/material.dart';

class BottomSheetMaterias extends StatelessWidget {
  final List<Materias> materias;

  const BottomSheetMaterias({Key key, @required this.materias}) : super(key: key);

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
            materias: materias,
            onTap: (int idMateria) {
              Navigator.of(context).pop(idMateria);
            },
          ),
        ),
      ],
    );
  }
}
