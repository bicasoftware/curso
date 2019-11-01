import 'package:curso/container/calendario.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/widgets/materia_color_container.dart';
import 'package:flutter/material.dart';

typedef ListAulaAction = Function(int selectedAction, AulasSemanaDTO aulasSemana);

class CalendarioContentAulasTile extends StatelessWidget {
  const CalendarioContentAulasTile({
    @required this.aulasSemana,
    @required this.ordem,
    @required this.onOptionSelected,
    Key key,
  }) : super(key: key);

  final AulasSemanaDTO aulasSemana;
  final int ordem;
  final ListAulaAction onOptionSelected;

  @override
  Widget build(BuildContext context) {
    return aulasSemana.idMateria == null
        ? const SizedBox()
        : Row(
            children: <Widget>[
              const SizedBox(width: 4),
              SizedBox(
                height: 64,
                width: 4,
                child: Container(                  
                  color: _getColor(),
                ),
              ),
              Expanded(
                child: ListTile(
                  subtitle: Text(
                    "${ordem + 1}ª ${Strings.aula} | ${formatTime(aulasSemana.horario)} ${faltaTipo(aulasSemana.tipo)}",
                  ),
                  leading: MateriaColorContainer(
                    color: Color(aulasSemana.cor),
                    size: 40,
                  ),
                  title: Text(aulasSemana.nome),
                  trailing: PopupMenuButton<int>(
                    onSelected: (int i) => onOptionSelected(i, aulasSemana),
                    itemBuilder: (c) => entryList(),
                  ),
                ),
              ),
            ],
          );
  }

  String faltaTipo(int tipo) {
    if (aulasSemana.idFalta != null) {
      if (aulasSemana.tipo == 0) {
        return " | Falta!";
      } else if (aulasSemana.tipo == 1) {
        return " | Aula Vaga";
      }
    }

    return "";
  }

  List<PopupMenuEntry<int>> entryList() {
    final entryList = <PopupMenuEntry<int>>[];

    if (aulasSemana.idFalta == null) {
      entryList.add(const PopupMenuItem<int>(value: 0, child: Text(Strings.faltar)));
      entryList.add(const PopupMenuItem<int>(value: 1, child: Text(Strings.aulaVaga)));
    } else {
      if (aulasSemana.isFalta) {
        entryList.add(const PopupMenuItem<int>(value: 0, child: Text(Strings.cancelarFalta)));
      } else if (aulasSemana.isAulaVaga) {
        entryList.add(const PopupMenuItem<int>(value: 1, child: Text(Strings.cancelarAulaVaga)));
      }
    }

    return entryList;
  }

  Color _getColor() {
    if (aulasSemana.idFalta != null) {
      if (aulasSemana.tipo == 0) {
        return Colors.red;
      } else if (aulasSemana.tipo == 1) {
        return Colors.teal;
      }
    }

    return Colors.transparent;
  }
}
