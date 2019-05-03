import 'package:curso/container/calendario.dart';
import 'package:curso/container/falta_container.dart';
import 'package:curso/container/notas.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/utils.dart/dialogs.dart';
import 'package:curso/view/view_provas_insert/bottomsheet_aulas_dia.dart';
import 'package:curso/view/view_provas_insert/view_provas_insert_materias.dart';
import 'package:curso/widgets/date_picker_tile.dart';
import 'package:curso/widgets/list_insert_header.dart';
import 'package:curso/widgets/rounded_bottomsheet_container.dart';
import 'package:curso/widgets/squared_card.dart';
import 'package:flutter/material.dart';

class ViewProvasInsert extends StatefulWidget {
  final NotasByDate dates;
  final List<AulasSemanaDTO> aulasSemana;

  const ViewProvasInsert({
    Key key,
    this.dates,
    this.aulasSemana,
  }) : super(key: key);

  @override
  _ViewProvasInsertState createState() => _ViewProvasInsertState();
}

class _ViewProvasInsertState extends State<ViewProvasInsert> {
  NotasByDate _dates;

  @override
  void initState() {
    super.initState();
    _dates = widget.dates.getCopy();
  }

  void popResult() {
    Navigator.of(context).pop(_dates);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Incluir Provas")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: popResult,
      ),
      body: Column(
        children: <Widget>[
          SquaredCard(
            child: DatePickerTile(
              initialDate: _dates.date,
              title: Strings.dataProva,
              onDateSet: (DateTime date) {
                setState(() => _dates.date = date);
              },
            ),
          ),
          Expanded(
            child: SquaredCard(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ListInsertHeader(
                    title: Strings.materias,
                    onAddTapped: () async {
                      final result = await showModalBottomSheet(
                        context: context,
                        builder: (c) {
                          final aulasSemana = _getAulasSemana(widget.aulasSemana);

                          return RoundedBottomSheetContainer(
                            child: BottomSheetAulasDia(
                              aulasSemana: aulasSemana,
                            ),
                          );
                        },
                      );

                      if (result != null) {
                        final materia = widget.aulasSemana.firstWhere(
                          (m) => m.idMateria == result,
                          orElse: () => null,
                        );

                        if (materia != null) {
                          setState(() {
                            _dates.addMateria(
                              MateriasByDate(
                                id: result,
                                cor: materia.cor,
                                nome: materia.nome,
                                sigla: materia.sigla,
                                notas: Notas(
                                  id: null,
                                  data: _dates.date,
                                  idMateria: result,
                                  nota: 0.0,
                                ),
                              ),
                            );
                          });
                        }
                      }
                    },
                  ),
                  Container(
                    child: ListProvasMaterias(
                      materias: _dates.materias,
                      onLongTap: (MateriasByDate m) async {
                        final bool shouldRemove = await Dialogs.showRemoveDialog(
                          context: context,
                          title: Strings.removerProva,
                        );

                        if (shouldRemove != null && shouldRemove) {
                          setState(() {
                            _dates.materias.remove(m);
                          });
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _getAulasSemana(List<AulasSemanaDTO> aulasSemana) {
    ///Fica assim enquanto Dart não tiver um List.distinct() ou algo que gere uma lista sem itens repetidos
    final List<AulasSemanaDTO> resultAulas = [];
    aulasSemana
        .where((AulasSemanaDTO a) => a.idMateria != null)
        .where((a) => a.weekDay == getWeekday(_dates.date))
        .map((AulasSemanaDTO a) => a.idMateria)
        .toSet()
        .forEach((int id) => resultAulas.add(aulasSemana.firstWhere((it) => it.idMateria == id)));

    return resultAulas;
  }
}
