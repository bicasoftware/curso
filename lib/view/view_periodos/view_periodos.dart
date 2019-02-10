import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc_main/BlocMain.dart';
import '../../container/materias.dart';
import '../../container/periodos.dart';
import '../../events/events_main/MainEvents.dart';
import '../../main_state.dart';
import '../../utils.dart/Strings.dart';
import '../../utils.dart/bottomsheets.dart';
import '../../utils.dart/dialogs.dart';
import '../view_materias/view_materias.dart';
import '../view_periodos_insert/view_periodos_insert.dart';
import 'view_periodos_builder.dart';

class ViewPeriodos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final b = BlocProvider.of<BlocMain>(context);

    return BlocBuilder<MainEvents, MainState>(
      bloc: b,
      builder: (c, state) {
        return Container(
          padding: EdgeInsets.all(0),
          child: ViewPeriodosBuilder.listPeriodos(
            context: context,
            periodos: state.periodos,
            onUpdateTap: (p) async {
              final Periodos result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (c) => ViewPeriodosInsert(periodo: p),
                ),
              );

              if (result != null) {
                b.dispatch(UpdatePeriodo(result));
              }
            },
            onDelete: (int idPeriodo) async {
              final deleteConfirmation = await Dialogs.showRemoveDialog(
                context: context,
                title: Strings.removerPeriodo,
              );

              if (deleteConfirmation ?? false) {
                b.dispatch(DeletePeriodo(idPeriodo));
              }
            },
            onMateriasTap: (List<Materias> materias, int idPeriodo, double medAprov) async {
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
                b.dispatch(RefreshMaterias(materias: resultMaterias, idPeriodo: idPeriodo));
              }
            },
            onCellClick: (int weekDay, int ordemAula, Periodos p) async {
              final idMateria = await BottomSheets.showBtsMaterias(context, p);
              if (idMateria != null) {
                print("dia: $weekDay, aula: $ordemAula, materia: $idMateria periodo: ${p.id}");
                b.dispatch(
                  InsertAula(
                    idPeriodo: p.id,
                    idMateria: idMateria,
                    weekDay: weekDay,
                    ordemAula: ordemAula,
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
