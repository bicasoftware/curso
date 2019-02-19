import 'package:curso/utils.dart/Formatting.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:meta/meta.dart';
import 'package:curso/widgets/default_list_tile.dart';
import 'package:flutter/material.dart';

class ViewPeriodosInsertBuilder {
  static Widget numPeriodoTile({@required int numPeriodo, @required Function(int) onChanged}) {
    return DefaultListTile(
      icon: Icons.confirmation_number,
      leading: Text(Strings.numPeriodo),
      trailing: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: numPeriodo,
          items: List.generate(18, (i) {
            return DropdownMenuItem(
              child: Text("${i + 1} ${Strings.periodo}"),
              value: i + 1,
            );
          }),
          onChanged: onChanged,
        ),
      ),
    );
  }

  static Widget inicioDateTile({@required DateTime inicio, VoidCallback onTap}) {
    return DefaultListTile(
      icon: Icons.calendar_today,
      leading: Text(Strings.inicioPeriodo),
      trailing: Text(Formatting.formatDate(inicio)),
      onTap: onTap,
    );
  }

  static Widget terminoDateTile({@required DateTime termino, VoidCallback onTap}) {
    return DefaultListTile(
      icon: Icons.date_range,
      leading: Text(Strings.inicioPeriodo),
      trailing: Text(Formatting.formatDate(termino)),
      onTap: onTap,
    );
  }

  static Widget aulaDiaTile(int aulasDia, Function(int) onChanged) {
    return DefaultListTile(
      icon: Icons.format_list_numbered,
      leading: Text(Strings.aulasDia),
      trailing: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: aulasDia,
          items: List.generate(12, (i) {
            return DropdownMenuItem(
              child: Text("$i"),
              value: i,
            );
          }),
          onChanged: onChanged,
        ),
      ),
    );
  }

  static Widget notaMinimaTile({@required double nota, @required Function(double) onChanged}) {
    return DefaultListTile(
      icon: Icons.warning,
      leading: Text(Strings.notaAprovacao),
      trailing: DropdownButtonHideUnderline(
        child: DropdownButton<double>(
          value: nota,
          onChanged: onChanged,
          items: Arrays.mediaAprovacao
              .map((num n) => DropdownMenuItem(child: Text("$n"), value: n.toDouble()))
              .toList(),
        ),
      ),
    );
  }

  static Widget presencaObrigatoriaTile(int presObrig, Function(int) onChanged) {
    return DefaultListTile(
      icon: Icons.error_outline,
      leading: Text(Strings.presencaObrigatoria),
      trailing: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          items:
              List.generate(40, (i) => DropdownMenuItem(child: Text("${i + 60} %"), value: i + 60)),
          value: presObrig,
          onChanged: onChanged,
        ),
      ),
    );
  }

  static saveButton(GlobalKey<FormState> formKey, Function() onTap) {
    return IconButton(
      icon: Icon(Icons.save),
      onPressed: onTap,
    );
  }
}
