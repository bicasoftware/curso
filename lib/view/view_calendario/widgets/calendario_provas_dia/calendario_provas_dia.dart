import 'package:bloc_provider/bloc_provider.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/calendario.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/bottomsheets.dart';
import 'package:curso/view/view_calendario/widgets/calendario_provas_dia/calendario_provas_dia_list.dart';
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
        onPressed: () {
          if (aulasAgendamento.length > 0) {
            BottomSheets.showBtsProvasDia(context, aulasAgendamento).then((id) {
              if (id != null) {
                onInsertMateria(id);
              }
            },);
          } else {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text(Strings.todasAulasAgendadas)));
          }
        },
      ),
    );
  }
}
