import 'package:curso/container/materias.dart';
import 'package:curso/widgets/circle.dart';
import 'package:flutter/material.dart';

class ViewMateriasBuilder {
  static Widget listViewMaterias({
    @required List<Materias> materias,
    @required Function(Materias, int pos) onTap,
    @required Function(Materias) onLongTap,
  }) {
    return ListView.separated(
      itemCount: materias.length,
      shrinkWrap: true,
      separatorBuilder: (BuildContext c, int i) => Divider(height: 1),
      itemBuilder: (BuildContext c, int i) {
        return _materiaTile(context: c, m: materias[i], onTap: onTap, onLongTap: onLongTap, pos: i);
      },
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
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: onTap,
    );
  }
}
