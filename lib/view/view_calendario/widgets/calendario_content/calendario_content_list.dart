import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/calendario.dart';
import 'package:curso/container/provas_notas_materias.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/bottomsheets.dart';
import 'package:curso/utils.dart/pair.dart';
import 'package:curso/utils.dart/showup.dart';
import 'package:curso/view/view_calendario/widgets/calendario_content/calendario_content_aulas_tile.dart';
import 'package:curso/view/view_calendario/widgets/calendario_content/calendario_content_prova_tile.dart';
import 'package:curso/view/view_calendario/widgets/calendario_content/calendario_content_session_header.dart';
import 'package:flutter/material.dart';
import 'package:lib_observer/merged_stream_observer.dart';
import 'package:provider/provider.dart';

class CalendarioAulasProvas extends StatelessWidget {
  const CalendarioAulasProvas({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BlocMain b = Provider.of<BlocMain>(context);
    final theme = Theme.of(context);

    void onOptionSelected(int selectedAction, AulasSemanaDTO aulas, DateTime date) {
      ///0 - faltas
      ///1 - aula vaga
      if (selectedAction == 0) {
        if (aulas.idFalta == null) {
          b.insertFalta(
            idMateria: aulas.idMateria,
            ordemAula: aulas.numAula,
            date: date,
            tipo: 0,
          );
        } else {
          b.deleteFalta(
            idMateria: aulas.idMateria,
            idFalta: aulas.idFalta,
            date: date,
            tipoFalta: aulas.tipo,
          );
        }
      } else if (selectedAction == 1) {
        if (aulas.idFalta == null) {
          b.insertFalta(
            idMateria: aulas.idMateria,
            ordemAula: aulas.numAula,
            date: date,
            tipo: 1,
          );
        } else {
          b.deleteFalta(
            idFalta: aulas.idFalta,
            idMateria: aulas.idMateria,
            date: date,
            tipoFalta: aulas.tipo,
          );
        }
      }
    }

    return MergedStreamObserver(
      streams: [b.outDataDTO, b.outProvasNotasMaterias, b.outAulasAgendamento],
      onSuccess: (BuildContext context, List data) {
        final aulas = data[0] as DataDTO;
        final faltasNotasMaterias =
            data[1] as Pair<List<ProvasNotasMaterias>, List<AulasSemanaDTO>>;
        final aulasAgendamento = data[2] as List<AulasSemanaDTO>;

        return aulas.aulas.every((a) => a.idMateria == null)
            ? CalendarioContentSessionHeader(title: Strings.semAulasHoje)
            : Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CalendarioContentSessionHeader(title: Strings.aulas),
                  ...[
                    for (int i = 0; i < aulas.aulas.length; i++)
                      CalendarioContentAulasTile(
                        key: ObjectKey(aulas.aulas[i]),
                        aulasSemana: aulas.aulas[i],
                        ordem: aulas.aulas[i].numAula,
                        onOptionSelected: (int selected, AulasSemanaDTO aulasSemana) {
                          onOptionSelected(selected, aulasSemana, aulas.date);
                        },
                      ),
                  ],
                  if (faltasNotasMaterias.first.isNotEmpty) ...[
                    CalendarioContentSessionHeader(title: Strings.provas),
                    ...[
                      for (int i = 0; i < faltasNotasMaterias.first.length; i++)
                        CalendarioProvasDiaListTile(
                          provasNotasMaterias: faltasNotasMaterias.first[i],
                          onDeleted: b.deleteNota,
                          onUpdateNota: b.updateNota,
                        )
                    ],
                  ],
                  if (aulasAgendamento.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: MaterialButton(
                        minWidth: double.maxFinite,
                        color: theme.accentColor,
                        colorBrightness: Brightness.dark,
                        child: const Text("Agendar Prova"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        onPressed: () {
                          BottomSheets.showBtsProvasDia(context, aulasAgendamento).then((id) {
                            if (id != null) {
                              b.insertNota(id);
                            }
                          });
                        },
                      ),
                    ),
                ],
              );
      },
    );
  }
}
