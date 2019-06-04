import 'package:curso/container/materias.dart';
import 'package:curso/widgets/materia_color_container.dart';
import 'package:flutter/material.dart';

class ViewMateriasListItem extends StatelessWidget {
  const ViewMateriasListItem({
    Key key,
    @required this.context,
    @required this.m,
    @required this.pos,
    @required this.onTap,
    @required this.onLongTap,
  }) : super(key: key);

  final BuildContext context;
  final Materias m;
  final int pos;
  final Function(Materias, int pos) onTap;
  final Function(Materias) onLongTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap(m, pos);
      },
      onLongPress: () {
        onLongTap(m);
      },
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Icon(Icons.school, color: Theme.of(context).accentColor),
      ),
      title: Text(m.nome),
      subtitle: Text(m.sigla),
      trailing: Hero(
        tag: ObjectKey(m),
        child: MateriaColorContainer(
          color: Color(m.cor),
          size: 32,
        ),
      ),
    );
  }
}
