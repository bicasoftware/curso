import 'package:bloc_provider/bloc_provider.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/calendario.dart';
import 'package:curso/container/notas.dart';
import 'package:curso/container/provas_notas_materias.dart';
import 'package:curso/utils.dart/pair.dart';
import 'package:curso/view/view_calendario/widgets/calendario_provas_dia/calendario_provas_dia_list_tile.dart';
import 'package:curso/widgets/padded_divider.dart';
import 'package:curso/widgets/placeholders/happy_placeholder.dart';
import 'package:curso/widgets/placeholders/stream_builder_child.dart';
import 'package:curso/widgets/placeholders/widget_swapper.dart';
import 'package:flutter/material.dart';

class CalendarioProvasDiaList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<BlocMain>(context);

    return Observer<Pair<List<ProvasNotasMaterias>, List<AulasSemanaDTO>>>(
      stream: bloc.outProvasNotasMaterias,
      onAwaiting: (context) => HappyPlaceholder(),
      onSuccess: (
        BuildContext context,
        Pair<List<ProvasNotasMaterias>, List<AulasSemanaDTO>> data,
      ) {
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          transitionBuilder: (Widget w, Animation<double> a) {
            return FadeTransition(
              opacity: a,
              child: w,
            );
          },
          child: WidgetSwapper(
            key: UniqueKey(),
            switchingCase: () => data.first.length > 0,
            placeholder: HappyPlaceholder(),
            realWidget: ListView.separated(
              itemCount: data.first.length,
              separatorBuilder: (_, __) {
                return PaddedDivider(padding: const EdgeInsets.only(right: 16.0, left: 72));
              },
              itemBuilder: (_, int i) {
                return CalendarioProvasDiaListTile(
                  provasNotasMaterias: data.first[i],
                  onDeleted: (Notas n) => bloc.deleteNota(n),
                  onUpdateNota: (Notas nota) => bloc.updateNota(nota),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
