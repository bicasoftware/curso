import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/materias.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/utils.dart/bottomsheets.dart';
import 'package:curso/view/view_materias/view_materias.dart';
import 'package:curso/view/view_periodos/view_periodos_list_item.dart';
import 'package:curso/view/view_periodos_insert/view_periodos_insert.dart';
import 'package:curso/view/view_provas/view_provas.dart';
import 'package:curso/widgets/padded_divider.dart';
import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:provider/provider.dart';

class ViewPeriodos extends StatefulWidget {
  const ViewPeriodos({Key key}) : super(key: key);

  @override
  ViewPeriodosState createState() => ViewPeriodosState();
}

class ViewPeriodosState extends State<ViewPeriodos> {
  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocMain>(context);

    void _onRefreshMaterias(int idPeriodo, List<Materias> materias) {
      b.updateMaterias(idPeriodo, materias);
    }

    return Container(
      height: double.infinity,
      child: Observer<List<Periodos>>(
        stream: b.outListPeriodos,
        onSuccess: (BuildContext context, List<Periodos> periodos) {
          return ListView.separated(
            itemCount: periodos.length,
            separatorBuilder: (c, i) {
              return const PaddedDivider(padding: EdgeInsets.symmetric(horizontal: 16));
            },
            itemBuilder: (_, int i) {
              return ViewPeriodosListItem(
                periodo: periodos[i],
                onUpdateTap: (p) async {
                  final Periodos result = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (c) => ViewPeriodosInsert(periodo: p)),
                  );

                  if (result != null) {
                    b.updatePeriodo(result);
                  }
                },
                onDelete: b.deletePeriodo,
                onMateriasTap: (List<Materias> materias, int idPeriodo, double medAprov) async {
                  _showViewInsertMaterias(
                      context, idPeriodo, materias, medAprov, _onRefreshMaterias);
                },
                onNotasTap: (Periodos periodo) async {
                  b.setCurrentPeriodoId(periodo.id);
                  final result = await Navigator.of(context).push(MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (c) => ViewProvas(periodo: periodo),
                  ));

                  if (result != null) {}
                },
                onCellClick: (int weekDay, int ordemAula, Periodos p, int idAula) async {
                  if (p.materias.isEmpty) {
                    _showViewInsertMaterias(
                        context, p.id, p.materias, p.medAprov, _onRefreshMaterias);
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
              );
            },
          );
        },
      ),
    );
  }

  void _showViewInsertMaterias(
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
