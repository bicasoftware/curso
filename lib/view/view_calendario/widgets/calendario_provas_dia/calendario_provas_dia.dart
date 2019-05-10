import 'package:bloc_provider/bloc_provider.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/calendario.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_calendario/widgets/calendario_provas_dia/calendario_provas_dia_list.dart';
import 'package:curso/view/view_provas_insert/bottomsheet_aulas_dia.dart';
import 'package:curso/widgets/rounded_bottomsheet_container.dart';
import 'package:flutter/material.dart';

class CalendarioProvasDia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<BlocMain>(context);

    return Stack(
      children: [
        CalendarioProvasDiaList(),
        StreamBuilder<List<AulasSemanaDTO>>(
          stream: bloc.outAulasAgendamento,
          builder: (context, snapshot) {
            return _fabInsert(
              context,
              snapshot.data,
              (int idMateria) => bloc.insertNota(idMateria),
            );
          },
        ),
      ],
    );
  }

  Widget _fabInsert(
    BuildContext context,
    List<AulasSemanaDTO> aulasAgendamento,
    Function(int) onInsertMateria,
  ) {
    return Positioned(
      right: 16,
      bottom: 16,
      child: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          if (aulasAgendamento.length > 0) {
            final selectedIdMateria = await showModalBottomSheet(
              context: context,
              builder: (c) {
                return RoundedBottomSheetContainer(
                  child: BottomSheetAulasDia(aulasSemana: aulasAgendamento),
                );
              },
            );
            if (selectedIdMateria != null) {
              onInsertMateria(selectedIdMateria);
            }
          } else {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text(Strings.todasAulasAgendadas)));
          }
        },
      ),
    );
  }
}
