import 'package:curso/container/materias.dart';
import 'package:curso/view/view_materias/view_materias_list_item.dart';
import 'package:flutter/material.dart';

class ViewMateriasList extends StatelessWidget {
  const ViewMateriasList({
    Key key,
    @required this.materias,
    @required this.onTap,
    @required this.onLongTap,
  }) : super(key: key);

  final List<Materias> materias;
  final Function(Materias, int pos) onTap;
  final Function(Materias) onLongTap;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext c, int i) {
          return Column(
            children: <Widget>[
              ViewMateriasListItem(
                  context: c, m: materias[i], pos: i, onTap: onTap, onLongTap: onLongTap),
              i == materias.length ? Container() : Divider(height: 0)
            ],
          );
        },
        childCount: materias.length,
      ),
    );
  }
}
