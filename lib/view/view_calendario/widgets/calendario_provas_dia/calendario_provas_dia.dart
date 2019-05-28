import 'package:bloc_provider/bloc_provider.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/calendario.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/bottomsheets.dart';
import 'package:curso/view/view_calendario/widgets/calendario_provas_dia/calendario_provas_dia_list.dart';
import 'package:curso/widgets/placeholders/stream_builder_child.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class CalendarioProvasDia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<BlocMain>(context);

    //animar Widget!

    return Column(
      children: [
        Expanded(child: CalendarioProvasDiaList()),
        StreamAwaiter<List<AulasSemanaDTO>>(
          isContainer: true,
          stream: bloc.outAulasAgendamento,
          widgetBuilder: (_, List<AulasSemanaDTO> aulas) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              width: double.infinity,
              child: MaterialButton(
                color: Theme.of(context).accentColor,
                colorBrightness: Brightness.dark,
                child: Text("Agendar Prova"),
                onPressed: () {
                  if (aulas.length > 0) {
                    BottomSheets.showBtsProvasDia(context, aulas).then((id) {
                      if (id != null) bloc.insertNota(id);
                    });
                  } else {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text(Strings.todasAulasAgendadas)),
                    );
                  }
                },
              ),
            );
          },
        )
      ],
    );
  }
}
