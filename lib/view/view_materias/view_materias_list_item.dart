import 'package:curso/container/materias.dart';
import 'package:curso/widgets/circle.dart';
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
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(Icons.school, color: Colors.white),
      ),
      title: Text(m.nome),
      subtitle: Text(m.sigla),
      trailing: Hero(
        tag: ObjectKey(m),
        child: Circle(color: m.cor, size: 35),
      ),
    );
  }
}
