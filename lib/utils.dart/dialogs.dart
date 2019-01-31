import 'dart:async';

import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/widgets/color_dialog.dart';
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
}
