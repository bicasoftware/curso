import 'package:bloc_provider/bloc_provider.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/calendario.dart';
import 'package:curso/view/view_calendario/widgets/calendario_aulas_dia/calendario_list_aulas.dart';
import 'package:curso/widgets/placeholders/happy_placeholder.dart';
import 'package:curso/widgets/placeholders/stream_builder_child.dart';
import 'package:curso/widgets/placeholders/widget_swapper.dart';
import 'package:flutter/material.dart';

class CalendarioAulasDia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final b = BlocProvider.of<BlocMain>(context);

    return StreamAwaiter<DataDTO>(
      isHappy: true,
      stream: b.outDataDTO,
      widgetBuilder: (BuildContext context, DataDTO data) {
        return WidgetSwapper(
          switchingCase: () => !hasAula(data.aulas),
          placeholder: HappyPlaceholder(),
          realWidget: AulasDiaList(
            aulas: data.aulas,
            onOptionSelected: (int selectedAction, AulasSemanaDTO aulas) {
              ///0 - faltas
              ///1 - aula vaga
              if (selectedAction == 0) {
                if (aulas.idFalta == null) {
                  b.insertFalta(
                    idMateria: aulas.idMateria,
                    ordemAula: aulas.numAula,
                    date: data.date,
                    tipo: 0,
                  );
                } else {
                  b.deleteFalta(
                    idMateria: aulas.idMateria,
                    idFalta: aulas.idFalta,
                    date: data.date,
                  );
                }
              } else if (selectedAction == 1) {
                if (aulas.idFalta == null) {
                  b.insertFalta(
                    idMateria: aulas.idMateria,
                    ordemAula: aulas.numAula,
                    date: data.date,
                    tipo: 1,
                  );
                } else {
                  b.deleteFalta(
                    idFalta: aulas.idFalta,
                    idMateria: aulas.idMateria,
                    date: data.date,
                  );
                }
              }
            },
          ),
        );
      },
    );
  }

  bool hasAula(List<AulasSemanaDTO> aulas) {
    return aulas.every((a) => a.idMateria == null);
  }
}
