import 'package:bloc_provider/bloc_provider.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/calendario.dart';
import 'package:curso/view/view_calendario/widgets/calendario_aulas_dia/calendario_list_aulas.dart';
import 'package:curso/widgets/placeholders/happy_placeholder.dart';
import 'package:curso/widgets/placeholders/stream_builder_child.dart';
import 'package:curso/widgets/placeholders/widget_swapper.dart';
import 'package:flutter/material.dart';

class CalendarioAulasDia extends StatefulWidget {
  @override
  _CalendarioAulasDiaState createState() => _CalendarioAulasDiaState();
}

class _CalendarioAulasDiaState extends State<CalendarioAulasDia>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final b = BlocProvider.of<BlocMain>(context);

    return Observer<DataDTO>(
      stream: b.outDataDTO,
      onSuccess: (BuildContext context, DataDTO data) {
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          switchInCurve: Curves.fastOutSlowIn,
          transitionBuilder: (Widget w, Animation<double> a) {
            return FadeTransition(
              opacity: a,
              child: w,
            );
          },
          child: WidgetSwapper(
            key: UniqueKey(),
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
                      tipoFalta: aulas.tipo,
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
                      tipoFalta: aulas.tipo,
                    );
                  }
                }
              },
            ),
          ),
        );
      },
    );
  }

  bool hasAula(List<AulasSemanaDTO> aulas) {
    return aulas.every((a) => a.idMateria == null);
  }
}
