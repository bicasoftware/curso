import 'package:curso/container/materias.dart';
import 'package:curso/view/view_materias/view_materias_list_item.dart';
import 'package:curso/widgets/padded_divider.dart';
import 'package:flutter/material.dart';

class ViewMateriasList extends StatelessWidget {
  const ViewMateriasList({
    @required this.materias,
    @required this.onTap,
    @required this.onDelete,
    Key key,
  }) : super(key: key);

  final List<Materias> materias;
  final Function(Materias, int pos, GlobalKey morpheusKey) onTap;
  final Function(Materias) onDelete;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext c, int i) {
          final morpheusKey = GlobalKey();
          return Column(
            children: <Widget>[
              ViewMateriasListItem(
                morpheusKey: morpheusKey,
                context: c,
                m: materias[i],
                pos: i,
                onTap: onTap,
                onDelete: onDelete,
              ),
              if (i == materias.length - 1)
                Container()
              else
                const PaddedDivider(padding: EdgeInsets.only(left: 72, right: 16))
            ],
          );
        },
        childCount: materias.length,
      ),
    );
  }
}
