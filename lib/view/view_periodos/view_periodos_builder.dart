import 'package:curso/container/periodos.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:flutter/material.dart';
import 'package:curso/utils.dart/Formatting.dart';

class ViewPeriodosBuilder {
  static Widget listPeriodos(BuildContext context, List<Periodos> periodos, Function(int) onTap) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: periodos.length,
      itemBuilder: (c, i) {
        return _periodoListItem(c, periodos[i], onTap);
      },
      separatorBuilder: (c, i) {
        return Divider(height: 1);
      },
    );
  }

  static Widget _periodoListItem(BuildContext context, Periodos p, Function(int) onTap) {
    return ListTile(
      onTap: () => onTap,
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(Icons.date_range),
      ),
      title: Text("${p.id}º ${Strings.periodo}"),
      subtitle:
          Text("De ${Formatting.formatDate(p.inicio)} até ${Formatting.formatDate(p.termino)}"),
    );
  }
}
