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
                        onChanged: (AulasSemanaDTO aulas, bool checked) {
                          if (checked) {
                            b.insertFalta(aulas.idMateria, aulas.numAula, snapshot.data.date);
                          } else {
                            b.deleteFalta(
                              idFalta: aulas.idFalta,
                              idMateria: aulas.idMateria,
                              date: snapshot.data.date,
                            );
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