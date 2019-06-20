import 'package:bloc_provider/bloc_provider.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/parciais.dart';
import 'package:curso/view/view_parciais/widgets/parcial_list_item.dart';
import 'package:curso/widgets/placeholders/stream_builder_child.dart';
import 'package:flutter/material.dart';

class ViewInfo extends StatelessWidget {
  const ViewInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = BlocProvider.of<BlocMain>(context);

    return Observer<Parciais>(
      stream: b.outParciais,
      onSuccess: (BuildContext context, Parciais data) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: data.materias.length,
          itemBuilder: (BuildContext context, int index) {
            return ParcialListItem(parciais: data.materias[index]);
          },
        );
      },
    );
  }
}
