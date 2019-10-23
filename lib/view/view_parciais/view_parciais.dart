import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/parciais.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_parciais/widgets/parcial_list_item.dart';
import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:provider/provider.dart';

class ViewInfo extends StatelessWidget {
  const ViewInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocMain>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(title: Text(Strings.parciais), floating: true),
          SliverList(
            delegate: SliverChildListDelegate (
              [
                StreamObserver<Parciais>(
                  stream: b.outParciais,
                  onSuccess: (_, Parciais parc){
                    return Column(
                      children: [
                        for(final m in parc.materias)
                          ParcialListItem(parciais: m)
                      ],
                    );
                  },
                )
              ]              
            ),
          )
        ],
      )      
    );
  }
}
