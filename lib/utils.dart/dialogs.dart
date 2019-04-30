import 'dart:async';

import 'package:curso/container/materias.dart';
import 'package:curso/utils.dart/ListUtils.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/widgets/color_dialog.dart';
import 'package:curso/widgets/dialog_picker_materias.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static Future<bool> showRemoveDialog({
    @required BuildContext context,
    @required String title,
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
          children: generateInRange(inicio - 1, termino - 1, (i) {
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

Future<bool> showConfirmationDialog({
  @required BuildContext context,
  @required String title,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(Strings.confirmacao),
        actions: <Widget>[
          FlatButton(
            child: Text("Não"),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          FlatButton(
            child: Text("Sim"),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
        content: Container(
          child: Text(title),
        ),
      );
    },
  );
}

Future<int> showOptionsDialog({
  @required BuildContext context,
  @required String title,
  @required List<String> options,
}) async {
  return await showDialog(
    context: context,
    builder: (_) {
      return SimpleDialog(
        title: Text(title),
        children: options.map((opt) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SimpleDialogOption(
              child: Text(opt),
              onPressed: () => Navigator.of(context).pop(options.indexOf(opt)),
            ),
          );
        }).toList(),
      );
    },
  );
}

Future<bool> showRemoveDialog({
  @required BuildContext context,
  @required String title,
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

Future<double> showNotaDialog({
  @required BuildContext context,
  @required double nota,
}) async {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  return await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (c) {
      return AlertDialog(
        title: Text(Strings.adicionarNota),
        content: Form(
          key: _formKey,
          child: TextFormField(
            initialValue: (nota ?? 0.0).toString(),
            decoration: InputDecoration(labelText: Strings.adicionarNota, hintText: "10,0"),
            onSaved: (String n) {
              Navigator.of(context).pop(double.parse(n));
            },
            validator: (n) {
              final novaNota = double.tryParse(n.replaceAll(",", "."));
              if (novaNota == null) {
                return Errors.notaInvalida;
              } else if (novaNota < 0.0 || novaNota > 10.0) {
                return Errors.notaInvalida;
              } else
                return null;
            },
          ),
        ),
        actions: [
          FlatButton(
            child: Text(Strings.cancelar),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text(Strings.salvar),
            onPressed: () {
              final state = _formKey.currentState;
              if (state.validate()) {
                state.save();
              }
            },
          ),
        ],
      );
    },
  );
}
