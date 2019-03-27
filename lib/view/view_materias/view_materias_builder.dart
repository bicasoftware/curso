import 'package:curso/container/materias.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/widgets/circle.dart';
import 'package:flutter/material.dart';

class ViewMateriasBuilder {
  static Widget sliverAppbar(VoidCallback onPressed) {
    return SliverAppBar(
      title: Text(Strings.materias),
      floating: true,
      leading: IconButton(
        icon: Icon(Icons.close),
        onPressed: onPressed,
      ),
    );
  }

  static Widget sliverListMaterias({
    @required List<Materias> materias,
    @required Function(Materias, int pos) onTap,
    @required Function(Materias) onLongTap,
  }) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext c, int i) {
          return _materiaTile(
            context: c,
            m: materias[i],
            onTap: onTap,
            onLongTap: onLongTap,
            pos: i,
          );
        },
        childCount: materias.length,
      ),
    );
  }

  static Widget _materiaTile({
    @required BuildContext context,
    @required Materias m,
    @required int pos,
    @required Function(Materias, int pos) onTap,
    @required Function(Materias) onLongTap,
  }) {
    return ListTile(
      onTap: () {
        onTap(m, pos);
      },
      onLongPress: () {
        onLongTap(m);
      },
      leading: Icon(Icons.school, color: Theme.of(context).accentColor),
      title: Text(m.nome),
      subtitle: Text(m.sigla),
      trailing: Hero(
        tag: ObjectKey(m),
        child: Circle(color: m.cor, size: 35),
      ),
    );
  }

  static Widget fab(VoidCallback onTap) {
    return FloatingActionButton.extended(
      icon: Icon(Icons.add),
      label: Text(Strings.adicionar),
      onPressed: onTap,
    );
  }
}
