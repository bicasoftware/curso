import 'package:curso/container/calendario.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/widgets/materia_color_container.dart';
import 'package:flutter/material.dart';

typedef ListAulaAction(int selectedAction, AulasSemanaDTO aulasSemana);

class CalendarioContentAulasTile extends StatelessWidget {
  const CalendarioContentAulasTile({
    Key key,
    @required this.aulasSemana,
    @required this.ordem,
    @required this.onOptionSelected,
  }) : super(key: key);

  final AulasSemanaDTO aulasSemana;
  final int ordem;
  final ListAulaAction onOptionSelected;

  @override
  Widget build(BuildContext context) {
    return aulasSemana.idMateria == null
        ? ListTile(
            title: Icon(
              Icons.tag_faces,
              color: Theme.of(context).primaryColorLight,
            ),
          )
        : Container(
            color: _getColor(),
            child: ListTile(
              dense: true,
              subtitle: Text(
                "${ordem + 1}ª ${Strings.aula} | ${formatTime(aulasSemana.horario)}",
              ),
              leading: MateriaColorContainer(
                color: Color(aulasSemana.cor),
                size: 32,
              ),
              title: Text(aulasSemana.nome),
              trailing: PopupMenuButton<int>(
                onSelected: (int i) => onOptionSelected(i, aulasSemana),
                itemBuilder: (c) => entryList(),
              ),
            ),
          );
  }

  List<PopupMenuEntry<int>> entryList() {
    final entryList = List<PopupMenuEntry<int>>();

    if (aulasSemana.idFalta == null) {
      entryList.add(PopupMenuItem<int>(value: 0, child: Text(Strings.faltar)));
      entryList.add(PopupMenuItem<int>(value: 1, child: Text(Strings.aulaVaga)));
    } else {
      if (aulasSemana.isFalta) {
        entryList.add(PopupMenuItem<int>(value: 0, child: Text(Strings.cancelarFalta)));
      } else if (aulasSemana.isAulaVaga) {
        entryList.add(PopupMenuItem<int>(value: 1, child: Text(Strings.cancelarAulaVaga)));
      }
    }

    return entryList;
  }

  Color _getColor() {
    if (aulasSemana.idFalta != null) {
      if (aulasSemana.tipo == 0) {
        return Colors.red[50];
      } else if (aulasSemana.tipo == 1) {
        return Colors.teal[50];
      }
    }

    return Colors.transparent;
  }
}