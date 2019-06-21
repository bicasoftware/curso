import 'dart:async';

import 'package:curso/utils.dart/ListUtils.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/double_utils.dart';
import 'package:curso/widgets/dialogs/color_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helper_tiles/helper_tiles.dart';

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
  @required String message,
  String title,
  String yesButtonText,
  String noButtonText,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(title ?? ""),
        actions: <Widget>[
          FlatButton(
            child: Text(noButtonText ?? "Não"),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          FlatButton(
            child: Text(yesButtonText ?? "Sim"),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
        content: Container(
          child: Text(message),
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
            keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
            onSaved: (String n) {
              Navigator.of(context).pop(parseDoubleFromText(n));
            },
            validator: (n) {
              final novaNota = parseDoubleFromText(n);
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

Future<int> showOptionsDialog2({
  BuildContext context,
  String title,
  int currentItem,
  List<String> options,
}) async {
  return await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (c) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(title, style: Theme.of(context).textTheme.title),
            ),
            ListView(
              shrinkWrap: true,
              children: [
                for (final opt in options)
                  DefaultListTile(
                    icon: Icons.donut_small,
                    leading: Text(opt),
                    trailing: null,
                    onTap: () => Navigator.of(context).pop(options.indexWhere((i) => i == opt)),
                  )
              ],
            ),
          ],
        ),
      );
    },
  );
}
