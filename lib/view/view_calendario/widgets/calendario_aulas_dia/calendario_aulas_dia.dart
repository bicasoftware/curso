import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/calendario.dart';
import 'package:curso/view/view_calendario/widgets/calendario_aulas_dia/calendario_list_aulas.dart';
import 'package:curso/widgets/awaiting_container.dart';
import 'package:curso/widgets/happy_placeholder.dart';
import 'package:flutter/material.dart';

class CalendarioAulasDia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final b = BlocProvider.of<BlocMain>(context);

    return StreamBuilder<DataDTO>(
      stream: b.outDataDTO,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              hasAula(snapshot.data.aulas)
                  ? HappyPlaceholder()
                  : Expanded(
                      child: AulasDiaList(
                        aulas: snapshot.data.aulas,
                        onOptionSelected: (int selectedAction, AulasSemanaDTO aulas) {
                          ///0 - faltas
                          ///1 - aula vaga
                          ///2 - agendar prova
                          switch (selectedAction) {
                            case 0:
                              if (aulas.idFalta == null) {
                                b.insertFalta(
                                  idMateria: aulas.idMateria,
                                  ordemAula: aulas.numAula,
                                  date: snapshot.data.date,
                                  tipo: 0,
                                );
                              } else {
                                b.deleteFalta(
                                  idMateria: aulas.idMateria,
                                  idFalta: aulas.idFalta,
                                  date: snapshot.data.date,
                                );
                              }
                              break;
                            case 1:
                              if (aulas.idFalta == null) {
                                b.insertFalta(
                                  idMateria: aulas.idMateria,
                                  ordemAula: aulas.numAula,
                                  date: snapshot.data.date,
                                  tipo: 1,
                                );
                              } else {
                                b.deleteFalta(
                                  idFalta: aulas.idFalta,
                                  idMateria: aulas.idMateria,
                                  date: snapshot.data.date,
                                );
                              }
                              break;
                            case 2:

                              ///TODO - Agendar [provas] aqui
                              break;
                            default:
                              break;
                          }
                        },
                      ),
                    ),
            ],
          );
        } else
          return AwaitingContainer();
      },
    );
  }

  bool hasAula(List<AulasSemanaDTO> aulas) {
    return aulas.every((a) => a.idMateria == null);
  }
}
