import 'package:curso/utils.dart/Formatting.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/widgets/default_list_tile.dart';
import 'package:flutter/material.dart';

class ViewDateRangeBuilder {
  static getAppBar(String title) => AppBar(title: Text(title));

  static getFAB(VoidCallback onTap) => FloatingActionButton.extended(
        icon: Icon(Icons.save),
        label: Text(Strings.salvar),
        highlightElevation: 2,
        onPressed: onTap,
      );

  static Widget getTileInicio({@required DateTime date, @required VoidCallback onTap}) {
    return _timeTile(date, onTap, Strings.inicioAula);
  }

  static Widget getTileTermino({@required DateTime date, @required VoidCallback onTap}) {
    return _timeTile(date, onTap, Strings.terminoAula);
  }

  static Widget _timeTile(DateTime date, VoidCallback onTap, String title) {
    return DefaultListTile(
      icon: Icons.date_range,
      leading: Text(title),
      trailing: Text(
        Formatting.formatTime(date),
      ),
      onTap: onTap,
    );
  }
}

