import 'package:curso/container/materias.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/custom_themes.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_periodos/view_periodos_buttombar.dart';
import 'package:curso/view/view_periodos/view_periodos_cronogr_header.dart';
import 'package:curso/widgets/cronograma/cronograma.dart';
import 'package:flutter/material.dart';

class ViewPeriodosListItem extends StatefulWidget {
  final Periodos periodo;
  final Function(Periodos) onUpdateTap;
  final Function(int) onDelete;
  final Function(List<Materias>, int idPeriodo, double medAprov) onMateriasTap;
  final Function(Periodos) onNotasTap;
  final Function(int, int, Periodos, int) onCellClick;

  const ViewPeriodosListItem({
    Key key,
    @required this.periodo,
    @required this.onUpdateTap,
    @required this.onDelete,
    @required this.onMateriasTap,
    @required this.onNotasTap,
    @required this.onCellClick,
  }) : super(key: key);

  @override
  _ViewPeriodosListItemState createState() => _ViewPeriodosListItemState();
}

class _ViewPeriodosListItemState extends State<ViewPeriodosListItem> {
  bool isOpen;

  @override
  void initState() {
    super.initState();
    isOpen = false;
  }

  @override
  Widget build(BuildContext context) {
    final styleClosed = Theme.of(context).textTheme.subhead;
    final styleOpened = styleClosed.copyWith(color: Theme.of(context).accentColor);

    return Theme(
      data: CustomThemes.lightTheme,
      child: Card(
        elevation: 1,
        child: ExpansionTile(
          onExpansionChanged: (bool status) => setState(() => isOpen = status),
          leading: Icon(Icons.date_range),
          title: Container(
            width: double.infinity,
            child: Text(
              "${widget.periodo.numPeriodo}º ${Strings.periodo}",
              textAlign: TextAlign.center,
              style: isOpen ? styleOpened : styleClosed,
            ),
          ),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: <Widget>[
                  ViewPeriodosCronogramaHeader(),
                  SizedBox(height: 2),
                  Cronograma(periodo: widget.periodo, onCellClick: widget.onCellClick),
                ],
              ),
            ),
            ViewPeriodosButtombar(
              periodo: widget.periodo,
              onDelete: widget.onDelete,
              onUpdateTap: widget.onUpdateTap,
              onNotasTap: widget.onNotasTap,
              onMateriasTap: widget.onMateriasTap,
            ),
          ],
        ),
      ),
    );
  }
}
