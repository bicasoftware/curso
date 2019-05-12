import 'package:curso/container/horarios.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_horario_aulas/view_horario_aulas.dart';
import 'package:curso/view/view_horario_aulas/view_horario_aulas_result.dart';
import 'package:flutter/material.dart';
import 'package:helper_tiles/helper_tiles.dart';

import 'view_periodos_insert_builder.dart';

class ViewPeriodosInsert extends StatefulWidget {
  final Periodos periodo;

  const ViewPeriodosInsert({
    Key key,
    @required this.periodo,
  }) : super(key: key);

  @override
  _ViewPeriodosInsertState createState() => _ViewPeriodosInsertState();
}

class _ViewPeriodosInsertState extends State<ViewPeriodosInsert> {
  Periodos _periodo;

  @override
  void initState() {
    super.initState();
    _periodo = widget.periodo;
  }

  _setDataIni(DateTime ini) => setState(() => _periodo.inicio = ini);

  _setDataTermino(DateTime end) => setState(() => _periodo.termino = end);

  _setAulasDiaDouble(double pos) {
    setState(() {
      _periodo.aulasDia = pos.toInt();
      for (var i = 0; i < _periodo.aulasDia; i++) {
        if (!_temHorarioSalvo(i)) {
          _periodo.horarios.add(
            Horarios(
              id: null,
              idPeriodo: _periodo.id,
              inicio: _periodo.horarios.last.termino,
              termino: _periodo.horarios.last.termino.add(Duration(minutes: 50)),
              ordemAula: i,
            ),
          );
        }
      }
    });
  }

  _setMedAprov(double aprov) => setState(() => _periodo.medAprov = aprov);

  _setPresObrigDouble(double pos) => setState(() => _periodo.presObrig = pos.toInt());

  _setNumPeriodo(int numero) => setState(() => _periodo.numPeriodo = numero);

  _setHoraAula(int ordemAula, DateTime inicio, DateTime termino) {
    setState(() {
      int index = _periodo.horarios.indexWhere((h) => h.ordemAula == ordemAula);

      if (index < 0) {
        _periodo.addHorario(
          Horarios(idPeriodo: _periodo.id, inicio: inicio, termino: termino, ordemAula: ordemAula),
        );
      } else {
        _periodo.horarios.removeAt(index);
        _periodo.addHorario(
          Horarios(
            idPeriodo: _periodo.id,
            inicio: inicio,
            termino: termino,
            ordemAula: ordemAula,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeData.light().canvasColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            title: Text("${_periodo.numPeriodo}º ${Strings.periodo}"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.save),
                onPressed: () => Navigator.of(context).pop(_periodo),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ViewPeriodosInsertBuilder.numPeriodoDropdownTile(
                  numPeriodo: _periodo.numPeriodo,
                  onChanged: _setNumPeriodo,
                ),
                DatePickerTile(
                  initialDate: _periodo.inicio,
                  title: Strings.inicioPeriodo,
                  onDateSet: _setDataIni,
                ),
                DatePickerTile(
                  initialDate: _periodo.termino,
                  title: Strings.terminoPeriodo,
                  onDateSet: _setDataTermino,
                ),
                LabeledDividerTile(hint: Strings.valorReprovacao),
                ViewPeriodosInsertBuilder.notaMinimaSliderTile(
                  nota: _periodo.medAprov,
                  onChanged: (n) => _setMedAprov(n),
                ),
                ViewPeriodosInsertBuilder.presencaObrigatoriaSliderTile(
                  _periodo.presObrig.toDouble(),
                  (double value) => _setPresObrigDouble(value),
                ),
                ViewPeriodosInsertBuilder.aulaDiaTileSlider(
                  aulasDia: _periodo.aulasDia,
                  onChanged: (double i) {
                    _setAulasDiaDouble(i + 1);
                  },
                ),
                LabeledDividerTile(hint: Strings.horarios),
                ViewPeriodosInsertBuilder.listHorarios(
                  horarios: _periodo.horarios,
                  aulasDia: _periodo.aulasDia,
                  onOrdemAulaTap: (int ordemAula, DateTime inicio, DateTime termino) {
                    _showDateRangeView(ordemAula, inicio, termino);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  bool _temHorarioSalvo(int i) {
    return _periodo.horarios.firstWhere((h) => h.ordemAula == i, orElse: () => null) != null;
  }

  _showDateRangeView(int ordemAula, DateTime inicio, DateTime termino) async {
    ViewHorarioAulasResult result = await Navigator.of(context).push(
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
      _setHoraAula(result.ordemAula, result.inicio, result.termino);
    }
  }
}
