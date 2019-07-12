import 'package:curso/container/periodos.dart';
import 'package:curso/custom_themes.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/dialogs.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:curso/view/view_horario_aulas/view_horario_aulas.dart';
import 'package:curso/view/view_horario_aulas/view_horario_aulas_result.dart';
import 'package:curso/view/view_periodos_insert/bloc/bloc_periodo.dart';
import 'package:flutter/material.dart';
import 'package:helper_tiles/helper_tiles.dart';

import 'view_periodos_insert_builder.dart';

class ViewPeriodosInsert extends StatefulWidget {
  final Periodos periodo;

  const ViewPeriodosInsert({
    @required this.periodo,
    Key key,
  }) : super(key: key);

  @override
  _ViewPeriodosInsertState createState() => _ViewPeriodosInsertState();
}

class _ViewPeriodosInsertState extends State<ViewPeriodosInsert> {
  BlocPeriodo bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocPeriodo(periodo: widget.periodo);
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  Future<bool> _canPop(BuildContext context) async {
    if (widget.periodo.id != null && bloc.hasChanged()) {
      final discard = await showConfirmationDialog(
        context: context,
        title: Strings.descartarAlteracaoes,
        message: Strings.descartarAlteracaoesMsg,
        yesButtonText: Strings.descartar,
        noButtonText: Strings.cancelar,
      );

      return discard ?? false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _canPop(context);
      },
      child: Scaffold(
        backgroundColor: ThemeData.light().canvasColor,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              title: Observer<int>(
                stream: bloc.numPeriodo.get(),
                onSuccess: (BuildContext context, int ordem) {
                  return Text("$ordemº ${Strings.periodo}");
                },
              ),
              actions: <Widget>[
                FlatButton(
                  colorBrightness: Brightness.dark,
                  child: Text(Strings.salvar),
                  onPressed: () {
                    bloc.shouldUpdate = true;
                    Navigator.of(context).pop(bloc.providePeriodo());
                  },
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Observer<int>(
                    stream: bloc.numPeriodo.get(),
                    onSuccess: (context, int ordem) {
                      return ViewPeriodosInsertBuilder.numPeriodoDropdownTile(
                        numPeriodo: ordem,
                        onChanged: bloc.numPeriodo.set,
                      );
                    },
                  ),
                  Observer<DateTime>(
                    stream: bloc.inicio.get(),
                    onSuccess: (BuildContext context, DateTime data) {
                      return DatePickerTile(
                        initialDate: data,
                        title: Strings.inicioPeriodo,
                        onDateSet: bloc.inicio.set,
                      );
                    },
                  ),
                  Observer<DateTime>(
                    stream: bloc.termino.get(),
                    onSuccess: (BuildContext context, DateTime data) {
                      return DatePickerTile(
                        initialDate: data,
                        title: Strings.terminoPeriodo,
                        onDateSet: bloc.termino.set,
                      );
                    },
                  ),
                  Observer<double>(
                    stream: bloc.medAprov.get(),
                    onSuccess: (BuildContext context, double medAprov) {
                      return ViewPeriodosInsertBuilder.notaMinimaSliderTile(
                        nota: medAprov,
                        onChanged: bloc.medAprov.set,
                      );
                    },
                  ),
                  Observer<double>(
                    stream: bloc.presObrig.get(),
                    onSuccess: (_, double presObrig) {
                      return ViewPeriodosInsertBuilder.presencaObrigatoriaSliderTile(
                        presObrig,
                        bloc.presObrig.set,
                      );
                    },
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 8, top: 8, bottom: 8),
                    child: Text(
                      Strings.horariosAulas,
                      style: CustomThemes.bottomSheetHeader,
                    ),
                  ),
                  Observer<int>(
                    stream: bloc.aulasDia.get(),
                    onSuccess: (_, int aulasDia) {
                      return ViewPeriodosInsertBuilder.qntAulasDropdownTile(
                        qntAulas: aulasDia,
                        onChanged: bloc.setAulasDia,
                      );
                    },
                  ),
                  MultiObserver(
                    streams: [bloc.aulasDia.get(), bloc.horarios.get()],
                    onSuccess: (BuildContext context, List data) {
                      return ViewPeriodosInsertBuilder.listHorarios(
                        aulasDia: data[0],
                        horarios: data[1],
                        onOrdemAulaTap: _showDateRangeView,
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showDateRangeView(int ordemAula, DateTime inicio, DateTime termino) async {
    final ViewHorarioAulasResult result = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (c) {
          return ViewHorarioAulas(
            ordemAula: ordemAula,
            inicio: TimeOfDay.fromDateTime(inicio),
            termino: TimeOfDay.fromDateTime(termino),
          );
        },
      ),
    );

    if (result != null && result is ViewHorarioAulasResult) {
      bloc.setHoraAula(result.ordemAula, result.inicio, result.termino);
    }
  }
}
