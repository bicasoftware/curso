import 'package:curso/container/materias.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/dialogs.dart';
import 'package:curso/widgets/materia_color_container.dart';
import 'package:flutter/material.dart';

class ViewMateriasListItem extends StatelessWidget {
  const ViewMateriasListItem({
    Key key,
    @required this.context,
    @required this.m,
    @required this.pos,
    @required this.onTap,
    @required this.onDelete,
  }) : super(key: key);

  final BuildContext context;
  final Materias m;
  final int pos;
  final Function(Materias, int pos) onTap;
  final Function(Materias) onDelete;

  static Icon get _swipeIcon => Icon(Icons.close, color: Colors.white70);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(m),
      confirmDismiss: (DismissDirection a) async {
        return await showConfirmationDialog(
          title: Strings.confirmarRemocao,
          message: Strings.avisoRemoverMateria,
          context: context,
        );
      },
      onDismissed: (DismissDirection dir) {
        onDelete(m);
      },
      background: Container(
        color: Colors.red,
        child: Row(
          children: [_swipeIcon, Spacer(), _swipeIcon],
        ),
      ),
      child: ListTile(
        onTap: () => onTap(m, pos),
        title: Text(m.nome),
        trailing: Text(m.sigla, style: Theme.of(context).textTheme.caption),
        leading: MateriaColorContainer(
          color: Color(m.cor),
          size: 36,
        ),
      ),
    );
  }
}
