import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../../bloc/bloc_main/bloc_main.dart';
import '../../container/materias.dart';
import '../../container/periodos.dart';
import '../../utils.dart/Strings.dart';
import '../../utils.dart/bottomsheets.dart';
import '../../utils.dart/dialogs.dart';
import '../view_materias/view_materias.dart';
import '../view_periodos_insert/view_periodos_insert.dart';
import 'view_periodos_builder.dart';

class ViewPeriodos extends StatefulWidget {
  @override
  ViewPeriodosState createState() => ViewPeriodosState();
}

class ViewPeriodosState extends State<ViewPeriodos> {
  @override
  Widget build(BuildContext context) {
    BlocMain b = BlocProvider.of<BlocMain>(context);

    _onRefreshMaterias(int idPeriodo, List<Materias> materias) {
      b.updateMaterias(idPeriodo, materias);
    }

    return StreamBuilder<List<Periodos>>(
      initialData: [],
      stream: b.outPeriodos,
      builder: (c, snap) {
        return Container(
          child: ViewPeriodosBuilder.listPeriodos(
            context: context,
            periodos: snap.data,
            onUpdateTap: (p) async {
              final Periodos result = await Navigator.of(context).push(
                MaterialPageRoute(builder: (c) => ViewPeriodosInsert(periodo: p)),
              );

              if (result != null) {
                b.updatePeriodo(result);
              }
            },
            onDelete: (int idPeriodo) async {
              final deleteConfirmation = await Dialogs.showRemoveDialog(
                context: context,
                title: Strings.removerPeriodo,
              );

              if (deleteConfirmation ?? false) {
                b.deletePeriodo(idPeriodo);
              }
            },
            onMateriasTap: (List<Materias> materias, int idPeriodo, double medAprov) async {
              _showViewInsertMaterias(context, idPeriodo, materias, medAprov, _onRefreshMaterias);
            },
            onCellClick: (int weekDay, int ordemAula, Periodos p, int idAula) async {
              if (p.materias.length == 0) {
                _showViewInsertMaterias(context, p.id, p.materias, p.medAprov, _onRefreshMaterias);
              } else {
                final idMateria = await BottomSheets.showBtsMaterias(context, p);
                if (idMateria != null) {
                  if (idMateria > 0) {
                    if (idAula != null) {
                      b.updateAula(
                        idAula: idAula,
                        idPeriodo: p.id,
                        idMateria: idMateria,
                        weekDay: weekDay,
                        ordemAula: ordemAula,
                      );
                    } else {
                      b.insertAula(
                        idPeriodo: p.id,
                        idMateria: idMateria,
                        weekDay: weekDay,
                        ordemAula: ordemAula,
                      );
                    }
                  } else {
                    b.deleteAula(idAula: idAula, idPeriodo: p.id);
                  }
                }
              }
            },
          ),
        );
      },
    );
  }

  _showViewInsertMaterias(
    BuildContext context,
    int idPeriodo,
    List<Materias> materias,
    double medAprov,
    Function(int, List<Materias> materias) onRefresh,
  ) async {
    final List<Materias> resultMaterias = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (c) {
          return ViewMaterias(
            idPeriodo: idPeriodo,
            materias: materias,
            medAprov: medAprov,
          );
        },
      ),
    );

    if (resultMaterias != materias) {
      onRefresh(idPeriodo, resultMaterias);
    }
  }
}
