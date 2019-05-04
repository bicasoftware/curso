import 'package:curso/container/falta_container.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/view/view_provas/view_provas_list_item_materias.dart';
import 'package:curso/widgets/list_indicator.dart';
import 'package:flutter/material.dart';

///TODO a- alterar view para utilizar Sleeves

class ViewProvasListItem extends StatelessWidget {
  final List<NotasByDate> dates;
  final int mes;

  const ViewProvasListItem({
    Key key,
    @required this.dates,
    @required this.mes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ListIndicator(
              hint: Arrays.meses[mes - 1],
              padding: EdgeInsets.all(8),
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: dates.length,
            shrinkWrap: true,
            itemBuilder: (_, j) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        formatFullDayString(dates[j].date),
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(height: 0),
                  ),
                  ViewProvasListItemMaterias(materias: dates[j].materias)
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
