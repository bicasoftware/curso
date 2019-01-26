import 'package:curso/container/materias.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ViewMateriasBuilder {
  static Widget listViewMaterias({
    @required List<Materias> materias,
    @required Function(Materias) onTap,
    @required Function(Materias) onLongTap,
  }) {
    return ListView.separated(
      itemCount: materias.length,
      shrinkWrap: true,
      separatorBuilder: (BuildContext c, int i) => Divider(height: 1),
      itemBuilder: (BuildContext c, int i) {
        return _materiaTile(context: c, m: materias[i], onTap: onTap, onLongTap: onLongTap);
      },
    );
  }

  static Widget _materiaTile({
    @required BuildContext context,
    @required Materias m,
    @required Function(Materias) onTap,
    @required Function(Materias) onLongTap,
  }) {
    return ListTile(
      onTap: () {
        onTap(m);
      },
      onLongPress: () {
        onLongTap(m);
      },
      leading: Icon(Icons.school, color: Theme.of(context).accentColor,),
      title: Text(m.nome),
      subtitle: Text(m.sigla),
      trailing: CircleAvatar(
        child: Container(
          padding: EdgeInsets.all(5),
          child: AutoSizeText(
            m.sigla,
            maxLines: 1,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Color(m.cor),
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
