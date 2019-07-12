import 'package:curso/container/materias.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:flutter/material.dart';

class ViewPeriodosButtombar extends StatelessWidget {
  final Periodos periodo;
  final Function(Periodos) onUpdateTap;
  final Function(int) onDelete;
  final Function(List<Materias>, int idPeriodo, double medAprov) onMateriasTap;
  final Function(Periodos) onNotasTap;

  const ViewPeriodosButtombar({
    @required this.periodo,
    @required this.onUpdateTap,
    @required this.onDelete,
    @required this.onMateriasTap,
    @required this.onNotasTap,
    Key key,
  }) : super(key: key);

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
        Spacer(),
        FlatButton(
          child: Text(Strings.provas, style: style),
          onPressed: () => onNotasTap(periodo),
        ),
        FlatButton(
          child: Text(Strings.materias, style: style),
          onPressed: () => onMateriasTap(periodo.materias, periodo.id, periodo.medAprov),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
