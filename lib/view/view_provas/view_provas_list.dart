import 'package:bloc_provider/bloc_provider.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/bloc/bloc_provas/bloc_provas.dart';
import 'package:curso/container/falta_container.dart';
import 'package:curso/container/notas.dart';
import 'package:curso/utils.dart/dialogs.dart';
import 'package:curso/view/view_provas/view_provas_list_item.dart';
import 'package:flutter/material.dart';

class ProvasList extends StatelessWidget {
  const ProvasList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocProvas = BlocProvider.of<BlocProvas>(context);
    final blocMain = BlocProvider.of<BlocMain>(context);

    return StreamBuilder<List<NotasContainer>>(
      stream: blocProvas.outFaltas,
      initialData: [],
      builder: (_, AsyncSnapshot<List<NotasContainer>> snap) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (c, i) {
              return ViewProvasListItem(
                dates: snap.data[i].dates,
                mes: snap.data[i].mes,
                onNotasTap: (Notas nota) async {
                  final newNota = await showNotaDialog(
                    context: context,
                    nota: nota.nota,
                  );

                  if (newNota != null && newNota != nota.nota) {
                    final updatedNota = nota..nota = newNota;
                    blocMain.updateNota(updatedNota);
                    blocProvas.updateProva(updatedNota);
                  }
                },
              );
            },
            childCount: snap.data.length,
          ),
        );
      },
    );
  }
}
