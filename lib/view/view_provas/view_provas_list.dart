import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/falta_container.dart';
import 'package:curso/models/notas.dart';
import 'package:curso/utils.dart/dialogs.dart';
import 'package:curso/view/view_provas/view_provas_list_item.dart';
import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:provider/provider.dart';

import 'bloc/bloc_provas.dart';

class ProvasList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final blocProvas = Provider.of<BlocProvas>(context);
    final blocMain = Provider.of<BlocMain>(context);

    return StreamObserver<List<NotasContainer>>(
      stream: blocProvas.outFaltas,
      onSuccess: (_, List<NotasContainer> notasContainer) {
        return ListView.builder(
          itemCount: notasContainer.length,
          itemBuilder: (BuildContext c, int i) {
            return ViewProvasListItem(
              pos: i,
              dates: notasContainer[i].dates,
              mes: notasContainer[i].mes,
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
        );
      },
    );
  }
}
