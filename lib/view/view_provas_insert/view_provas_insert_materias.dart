import 'package:curso/container/cronograma.dart';
import 'package:flutter/material.dart';

class ListProvasMaterias extends StatelessWidget {
  final List<CronogramaMaterias> materias;
  final Function(CronogramaMaterias) onLongTap;

  const ListProvasMaterias({
    Key key,
    @required this.materias,
    @required this.onLongTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: materias.length,
        separatorBuilder: (c, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(height: 1),
          );
        },
        itemBuilder: (c, i) {
          final m = materias[i];
          return ListTile(
            onLongPress: () => onLongTap(m),
            leading: CircleAvatar(
              child: Icon(Icons.school, color: Colors.white),
              backgroundColor: Color(m.cor),
            ),
            title: Text(m.nome),
            subtitle: Text(m.sigla),
          );
        },
      ),
    );
  }
}
