import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:curso/bloc/bloc_provas/bloc_provas.dart';
import 'package:curso/container/falta_container.dart';
import 'package:curso/view/view_provas/view_provas_list_item.dart';
import 'package:flutter/material.dart';

class ProvasList extends StatelessWidget {
  const ProvasList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = BlocProvider.of<BlocProvas>(context);

    return StreamBuilder<List<NotasContainer>>(
      stream: b.outFaltas,
      initialData: [],
      builder: (_, AsyncSnapshot<List<NotasContainer>> snap) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (c, i) {
              return ViewProvasListItem(
                dates: snap.data[i].dates,
                mes: snap.data[i].mes,
              );
            },
            childCount: snap.data.length,
          ),
        );
      },
    );
  }
}
