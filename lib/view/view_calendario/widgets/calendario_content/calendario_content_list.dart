import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/calendario.dart';
import 'package:curso/container/notas.dart';
import 'package:curso/container/provas_notas_materias.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/bottomsheets.dart';
import 'package:curso/utils.dart/pair.dart';
import 'package:curso/view/view_calendario/widgets/calendario_content/calendario_content_aulas_tile.dart';
import 'package:curso/view/view_calendario/widgets/calendario_content/calendario_content_prova_tile.dart';
import 'package:flutter/material.dart';
import 'package:lib_observer/multiobserver.dart';
import 'package:provider/provider.dart';

class CalendarioAulasProvas extends StatelessWidget {
  const CalendarioAulasProvas({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BlocMain b = Provider.of<BlocMain>(context);
    final style = TextStyle(
      color: Colors.black54,
      fontSize: 16,
    );

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

    return MultiObserver(
      streams: [b.outDataDTO, b.outProvasNotasMaterias, b.outAulasAgendamento],
      onSuccess: (BuildContext context, List data) {
        final aulas = data[0] as DataDTO;
        final faltasNotasMaterias =
            data[1] as Pair<List<ProvasNotasMaterias>, List<AulasSemanaDTO>>;
        final aulasAgendamento = data[2] as List<AulasSemanaDTO>;

        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(Strings.aulas, style: style),
            ),
            ...[
              for (int i = 0; i < aulas.aulas.length; i++)
                CalendarioContentAulasTile(
                  aulasSemana: aulas.aulas[i],
                  ordem: aulas.aulas[i].numAula,
                  onOptionSelected: (int selected, AulasSemanaDTO aulasSemana) {
                    onOptionSelected(selected, aulasSemana, aulas.date);
                  },
                ),
            ],
            if (faltasNotasMaterias.first.length > 0) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(Strings.provas, style: style),
              ),
              ...[
                for (int i = 0; i < faltasNotasMaterias.first.length; i++)
                  CalendarioProvasDiaListTile(
                    provasNotasMaterias: faltasNotasMaterias.first[i],
                    onDeleted: (Notas n) => b.deleteNota(n),
                    onUpdateNota: (Notas nota) => b.updateNota(nota),
                  )
              ],
            ],
            if (aulasAgendamento.length > 0)
              Padding(
                padding: EdgeInsets.all(8),
                child: MaterialButton(
                  color: Theme.of(context).accentColor,
                  colorBrightness: Brightness.dark,
                  child: Text("Agendar Prova"),
                  onPressed: () {
                    BottomSheets.showBtsProvasDia(context, aulasAgendamento).then((id) {
                      if (id != null) b.insertNota(id);
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