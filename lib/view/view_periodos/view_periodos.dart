import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/models/materias.dart';
import 'package:curso/models/periodos.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/bottomsheets.dart';
import 'package:curso/view/view_materias/view_materias.dart';
import 'package:curso/view/view_periodos/view_periodos_list_item.dart';
import 'package:curso/view/view_periodos_insert/view_periodos_insert.dart';
import 'package:curso/view/view_provas/view_provas.dart';
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

    void showActInsertEmprego() async {
      final result = await Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (BuildContext c) {
            return ViewPeriodosInsert(periodo: Periodos.newInstance());
          },
        ),
      );

      if (result != null) {
        b.insertPeriodo(result);
      }
    }

    void _onRefreshMaterias(int idPeriodo, List<Materias> materias) {
      b.updateMaterias(idPeriodo, materias);
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: showActInsertEmprego,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            title: Text(Strings.periodos),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                StreamObserver(
                  stream: b.outListPeriodos,
                  onSuccess: (c, List<Periodos> data) {
                    return Column(
                      children: <Widget>[
                        for (final periodo in data)
                          ViewPeriodosListItem(
                            periodo: periodo,
                            onUpdateTap: (p) async {
                              final Periodos result = await Navigator.of(context).push(
                                MaterialPageRoute(builder: (c) => ViewPeriodosInsert(periodo: p)),
                              );

                              if (result != null) {
                                b.updatePeriodo(result);
                              }
                            },
                            onDelete: b.deletePeriodo,
                            onMateriasTap:
                                (List<Materias> materias, int idPeriodo, double medAprov) async {
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
                            onCellClick:
                                (int weekDay, int ordemAula, Periodos p, int idAula) async {
                              if (p.materias.isEmpty) {
                                _showViewInsertMaterias(
                                    context, p.id, p.materias, p.medaprov, _onRefreshMaterias);
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
                          )
                      ],
                    );
                  },
                ),
              ],
            ),
          )
        ],
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
