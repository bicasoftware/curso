import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/calendario.dart';
import 'package:curso/container/cronograma.dart';
import 'package:curso/container/notas.dart';
import 'package:curso/utils.dart/pair.dart';
import 'package:curso/view/view_calendario/widgets/calendario_provas_dia/calendario_provas_dia_list_tile.dart';
import 'package:curso/widgets/happy_placeholder.dart';
import 'package:flutter/material.dart';

//Repassar tela de Notas a partir de ViewPeriodos

class CalendarioProvasDiaList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<BlocMain>(context);

    return Column(
      children: <Widget>[
        StreamBuilder<Pair<List<ProvasNotasMaterias>, List<AulasSemanaDTO>>>(
          stream: bloc.outProvasNotasMaterias,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data.first.length == 0) {
              return HappyPlaceholder();
            } else {
              return Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: snapshot.data.first.length,
                  separatorBuilder: (_, __) => Divider(),
                  itemBuilder: (c, i) {
                    return CalendarioProvasDiaListTile(
                      provasNotasMaterias: snapshot.data.first[i],
                      onDeleted: (Notas n) => bloc.deleteNota(n),
                    );
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
