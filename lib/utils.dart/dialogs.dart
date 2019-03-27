import 'dart:async';

import 'package:curso/container/materias.dart';
import 'package:curso/utils.dart/ListUtils.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/widgets/color_dialog.dart';
import 'package:curso/widgets/dialog_picker_materias.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static Future<bool> showRemoveDialog({
    BuildContext context,
    String title,
  }) async {
    return await showDialog(
      context: context,
      builder: (BuildContext c) {
        return SimpleDialog(
          title: Text(title),
          children: <Widget>[
            SimpleDialogOption(
              child: Text(Strings.excluir),
              onPressed: () {
                return Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  static Future<int> showColorDialog({
    BuildContext context,
    int initialColor,
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (c) {
        return Dialog(
          child: ColorDialog(
            onTap: (int cor) => Navigator.of(context).pop(cor),
          ),
        );
      },
    );
  }

  static Future<int> showMateriasDialog({
    BuildContext context,
    List<Materias> materias,
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (c) {
        return Dialog(
          child: PickerMaterias(
            materias: materias,
            onTap: (int idMateria) => Navigator.of(context).pop(idMateria),
          ),
        );
      },
    );
  }

  static Future<int> showMonthPicker({
    BuildContext context,
    int inicio,
    int termino,
  }) async {
    return await showDialog(
      context: context,
      builder: (c) {
        return SimpleDialog(
          title: Text(Strings.mes),
          children: generateInRange(inicio -1, termino -1, (i) {
            return SimpleDialogOption(
              child: ListTile(
                title: Text(Arrays.meses[i]),
                leading: Icon(Icons.date_range),                
              ),
              onPressed: () => Navigator.of(context).pop(i),
            );
          }),
        );
      },
    );
  }
}
