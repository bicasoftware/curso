import 'package:curso/container/falta_container.dart';
import 'package:curso/container/notas.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/view/view_provas/view_provas_list_item_materias.dart';
import 'package:flutter/material.dart';

class ViewProvasListItem extends StatelessWidget {
  final Function(Notas) onNotasTap;
  final List<NotasByDate> dates;
  final int mes;
  final int pos;

  const ViewProvasListItem({
    Key key,
    @required this.onNotasTap,
    @required this.dates,
    @required this.mes,
    @required this.pos,
  }) : super(key: key);

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
                Divider(),
                ViewProvasListItemMaterias(materias: notaByDate.materias, onTap: onNotasTap)
              ],
            )
        ],
      ),
    );
  }
}
