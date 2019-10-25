import 'package:curso/container/calendario.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/widgets/materia_color_container.dart';
import 'package:flutter/material.dart';

typedef ListAulaAction = Function(int selectedAction, AulasSemanaDTO aulasSemana);

class CalendarioContentAulasTile extends StatefulWidget {
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
  _CalendarioContentAulasTileState createState() => _CalendarioContentAulasTileState();
}

class _CalendarioContentAulasTileState extends State<CalendarioContentAulasTile>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> fadeAnim;
  Animation<Offset> slideAnim;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    final curve = CurvedAnimation(curve: Curves.decelerate, parent: controller);

    slideAnim = Tween<Offset>(
      begin: const Offset(0, .35),
      end: Offset.zero,
    ).animate(curve);

    fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(curve);
    controller.forward();
  }

  @override
  void didUpdateWidget(CalendarioContentAulasTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.key != widget.key) {
      controller.reset();
      controller.forward();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.aulasSemana.idMateria == null
        ? Container()
        : SlideTransition(
          position: slideAnim,
          child: FadeTransition(
            opacity: fadeAnim,
            child: Row(
              children: <Widget>[
                const SizedBox(width: 4),
                SizedBox(
                  height: 48,
                  width: 4,
                  child: Container(
                    color: _getColor(),
                  ),
                ),
                Expanded(
                  child: ListTile(                        
                    subtitle: Text(
                      "${widget.ordem + 1}ª ${Strings.aula} | ${formatTime(widget.aulasSemana.horario)} ${faltaTipo(widget.aulasSemana.tipo)}",
                    ),
                    leading: MateriaColorContainer(
                      color: Color(widget.aulasSemana.cor),
                      size: 40,
                    ),
                    title: Text(widget.aulasSemana.nome),
                    trailing: PopupMenuButton<int>(
                      onSelected: (int i) => widget.onOptionSelected(i, widget.aulasSemana),
                      itemBuilder: (c) => entryList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
  }

  String faltaTipo(int tipo) {
    if (widget.aulasSemana.idFalta != null) {
      if (widget.aulasSemana.tipo == 0) {
        return " | Falta!";
      } else if (widget.aulasSemana.tipo == 1) {
        return " | Aula Vaga";
      }
    }

    return "";
  }

  List<PopupMenuEntry<int>> entryList() {
    final entryList = <PopupMenuEntry<int>>[];

    if (widget.aulasSemana.idFalta == null) {
      entryList.add(const PopupMenuItem<int>(value: 0, child: Text(Strings.faltar)));
      entryList.add(const PopupMenuItem<int>(value: 1, child: Text(Strings.aulaVaga)));
    } else {
      if (widget.aulasSemana.isFalta) {
        entryList.add(const PopupMenuItem<int>(value: 0, child: Text(Strings.cancelarFalta)));
      } else if (widget.aulasSemana.isAulaVaga) {
        entryList.add(const PopupMenuItem<int>(value: 1, child: Text(Strings.cancelarAulaVaga)));
      }
    }

    return entryList;
  }

  Color _getColor() {
    if (widget.aulasSemana.idFalta != null) {
      if (widget.aulasSemana.tipo == 0) {
        return Colors.red;
      } else if (widget.aulasSemana.tipo == 1) {
        return Colors.teal;
      }
    }

    return Colors.transparent;
  }
}
