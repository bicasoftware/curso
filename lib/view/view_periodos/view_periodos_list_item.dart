import 'package:curso/models/materias.dart';
import 'package:curso/models/periodos.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/dialogs.dart';
import 'package:curso/view/view_periodos/view_periodos_buttombar.dart';
import 'package:curso/view/view_periodos/view_periodos_cronogr_header.dart';
import 'package:curso/widgets/cronograma/cronograma.dart';
import 'package:curso/widgets/expansiontile_hide_divider.dart';
import 'package:flutter/material.dart';

class ViewPeriodosListItem extends StatelessWidget {
  const ViewPeriodosListItem({
    @required this.periodo,
    @required this.onUpdateTap,
    @required this.onDelete,
    @required this.onMateriasTap,
    @required this.onNotasTap,
    @required this.onCellClick,
    Key key,
  }) : super(key: key);

  final Periodos periodo;
  final Function(Periodos) onUpdateTap;
  final Function(int) onDelete;
  final Function(List<Materias>, int idPeriodo, double medAprov) onMateriasTap;
  final Function(Periodos) onNotasTap;
  final Function(int, int, Periodos, int) onCellClick;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(periodo),
      confirmDismiss: (DismissDirection dir) async {
        return await showConfirmationDialog(
          context: context,
          title: Strings.confirmarRemocao,
          message: Strings.avisoRemoverPeriodo,
          yesButtonText: Strings.removerPeriodo,
          noButtonText: Strings.cancelar,
        );
      },
      onDismissed: (DismissDirection dir) {
        onDelete(periodo.id);
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),

        child: ExpansionTileHideDivider(
          child: ExpansionTile(
            leading: Icon(Icons.date_range),
            title: Text(
              "${periodo.numPeriodo}º ${Strings.periodo}",
            ),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: <Widget>[
                    ViewPeriodosCronogramaHeader(),
                    const SizedBox(height: 2),
                    Cronograma(periodo: periodo, onCellClick: onCellClick),
                  ],
                ),
              ),
              ViewPeriodosButtombar(
                periodo: periodo,
                onDelete: onDelete,
                onUpdateTap: onUpdateTap,
                onNotasTap: onNotasTap,
                onMateriasTap: onMateriasTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
