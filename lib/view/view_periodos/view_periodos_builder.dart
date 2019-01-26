import 'package:curso/container/materias.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/widgets/Cronograma.dart';
import 'package:curso/widgets/DiaSemanaHeader.dart';
import 'package:flutter/material.dart';

class ViewPeriodosBuilder {
  static Widget listPeriodos({
    BuildContext context,
    List<Periodos> periodos,
    Function(Periodos) onUpdateTap,
    Function(int) onDelete,
    Function(List<Materias>, int idPeriodo, double medAprov) onMateriasTap,
  }) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: periodos.length,
      itemBuilder: (c, i) {
        return _expandedTile(c, periodos[i], onUpdateTap, onDelete, onMateriasTap);
      },
    );
  }

  static Widget _expandedTile(
    BuildContext c,
    Periodos p,
    Function(Periodos) onUpdateTap,
    Function(int) onDelete,
    Function(List<Materias>, int idPeriodo, double medAprov) onMateriasTap,
  ) {
    return GestureDetector(
      onLongPress: () {
        onDelete(p.id);
      },
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(c).accentColor,
          child: Icon(Icons.date_range),
        ),
        title: Text("${p.id}º ${Strings.periodo}"),
        children: <Widget>[
          WeekDayHeader(),
          SizedBox(height: 0.5),
          Cronograma(periodo: p),
          SizedBox(height: 16),
          Row(
            children: <Widget>[
              FlatButton(
                child: Text(Strings.editar),
                onPressed: () {
                  onUpdateTap(p);
                },
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      child: Text(Strings.materias),
                      onPressed: () {
                        onMateriasTap(p.materias, p.id, p.medAprov);
                      },
                    ),
                    FlatButton(
                      child: Text(Strings.provas),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
