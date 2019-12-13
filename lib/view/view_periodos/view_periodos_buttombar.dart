import 'package:curso/models/materias.dart';
import 'package:curso/models/periodos.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:flutter/material.dart';

class ViewPeriodosButtombar extends StatelessWidget {
  const ViewPeriodosButtombar({
    @required this.periodo,
    @required this.onUpdateTap,
    @required this.onDelete,
    @required this.onMateriasTap,
    @required this.onNotasTap,
    Key key,
  }) : super(key: key);

  final Periodos periodo;
  final Function(Periodos) onUpdateTap;
  final Function(int) onDelete;
  final Function(List<Materias>, int idPeriodo, double medAprov) onMateriasTap;
  final Function(Periodos) onNotasTap;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.button.copyWith(color: Theme.of(context).accentColor);

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          child: Text(Strings.editar, style: style),
          onPressed: () => onUpdateTap(periodo),
        ),
        const Spacer(),
        FlatButton(
          child: Text(Strings.provas, style: style),
          onPressed: () => onNotasTap(periodo),
        ),
        FlatButton(
          child: Text(Strings.materias, style: style),
          onPressed: () => onMateriasTap(periodo.materias, periodo.id, periodo.medaprov),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
