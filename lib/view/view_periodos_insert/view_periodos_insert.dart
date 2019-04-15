import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/widgets/date_picker_tile.dart';
import 'package:flutter/material.dart';

import '../../container/horarios.dart';
import '../../container/periodos.dart';
import '../../widgets/list_indicator.dart';
import '../view_date_range_picker/view_data_range.dart';
import '../view_date_range_picker/view_data_range_result.dart';
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
  static final _formKey = GlobalKey<FormState>();

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

  Widget _divider() => Divider(height: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ViewPeriodosInsertBuilder.appBar(
        idPeriodo: _periodo.numPeriodo,
        formKey: _formKey,
        onTap: () => Navigator.of(context).pop(_periodo),
      ),
      body: Form(
        key: _formKey,
        child: Card(
          margin: EdgeInsets.all(8),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListIndicator(hint: Strings.periodo),
              ViewPeriodosInsertBuilder.numPeriodoDropdownTile(
                numPeriodo: _periodo.numPeriodo,
                onChanged: _setNumPeriodo,
              ),
              _divider(),
              DatePickerTile(
                initialDate: _periodo.inicio,
                title: Strings.inicioPeriodo,
                onDateSet: _setDataIni,
              ),
              _divider(),
              DatePickerTile(
                initialDate: _periodo.termino,
                title: Strings.terminoPeriodo,
                onDateSet: _setDataTermino,
              ),
              ListIndicator(hint: Strings.valorReprovacao),
              ViewPeriodosInsertBuilder.notaMinimaSliderTile(
                nota: _periodo.medAprov,
                onChanged: (n) => _setMedAprov(n),
              ),
              _divider(),
              ViewPeriodosInsertBuilder.presencaObrigatoriaSliderTile(
                _periodo.presObrig.toDouble(),
                (double value) => _setPresObrigDouble(value),
              ),
              ListIndicator(hint: Strings.aulas_e_horarios),
              ViewPeriodosInsertBuilder.aulaDiaTileSlider(
                aulasDia: _periodo.aulasDia,
                onChanged: (double i) {
                  _setAulasDiaDouble(i + 1);
                },
              ),
              ViewPeriodosInsertBuilder.listHorarios(
                horarios: _periodo.horarios,
                aulasDia: _periodo.aulasDia,
                onOrdemAulaTap: (int ordemAula, DateTime inicio, DateTime termino) {
                  _showDateRangeView(ordemAula, inicio, termino);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _temHorarioSalvo(int i) {
    return _periodo.horarios.firstWhere((h) => h.ordemAula == i, orElse: () => null) != null;
  }

  _showDateRangeView(int ordemAula, DateTime inicio, DateTime termino) async {
    ViewDateRangeResult result = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (c) {
          return ViewDateRange(
            ordemAula: ordemAula,
            inicio: inicio,
            termino: termino,
          );
        },
      ),
    );

    if (result != null && result is ViewDateRangeResult) {
      _setHoraAula(result.ordemAula, result.inicio, result.termino);
    }
  }
}
