import 'package:curso/container/periodos.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_materias/view_materias.dart';
import 'package:curso/view/view_materias_insert/view_materias_insert.dart';
import 'package:flutter/material.dart';

class PickerMateriasFallback extends StatelessWidget {
  final Periodos periodo;

  const PickerMateriasFallback({Key key, @required this.periodo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Center(
        child: RaisedButton(
          color: Theme.of(context).accentColor,
          child: Text(Strings.materiasVazias),
          onPressed: () {
            return Navigator.of(context).push(_route(context));
          },
        ),
      ),
    );
  }

  MaterialPageRoute _route(BuildContext context) {
    return MaterialPageRoute<ViewMateriasInsert>(
      fullscreenDialog: true,
      builder: (c) {
        return ViewMaterias(
          materias: periodo.materias,
          idPeriodo: periodo.id,
          medAprov: periodo.medAprov,
        );
      },
    );
  }
}
