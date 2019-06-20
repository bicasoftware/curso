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

    return Column(
      children: [
        Expanded(child: CalendarioProvasDiaList()),
        Observer<List<AulasSemanaDTO>>(
          stream: bloc.outAulasAgendamento,
          onAwaiting: (c) => Container(),
          onSuccess: (_, List<AulasSemanaDTO> aulas) {
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
