import 'package:curso/container/falta_container.dart';
import 'package:curso/models/notas.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/view/view_provas/view_provas_list_item_materias.dart';
import 'package:flutter/material.dart';

class ViewProvasListItem extends StatelessWidget {
  const ViewProvasListItem({
    @required this.onNotasTap,
    @required this.dates,
    @required this.mes,
    @required this.pos,
    Key key,
  }) : super(key: key);

  final Function(Notas) onNotasTap;
  final List<NotasByDate> dates;
  final int mes;
  final int pos;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ExpansionTile(
        leading: Icon(Icons.date_range),
        title: Text(Arrays.meses[mes - 1]),
        children: [
          for (final NotasByDate notaByDate in dates)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      formatFullDayString(notaByDate.date),
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ),
                const Divider(),
                ViewProvasListItemMaterias(materias: notaByDate.materias, onTap: onNotasTap)
              ],
            )
        ],
      ),
    );
  }
}
