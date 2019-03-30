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

  final _lastDate = DateTime(2030, 12, 31);

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

  _setNumPeriodoDouble(double numero) => setState(() => _periodo.numPeriodo = numero.toInt());

  _setHoraAula(int ordemAula, DateTime inicio, DateTime termino) {
    setState(() {
      int index = _periodo.horarios.indexWhere((h) => h.ordemAula == ordemAula);

      if (index < 0) {
        _periodo.addHorario(
          Horarios(idPeriodo: _periodo.id, inicio: inicio, termino: termino, ordemAula: ordemAula),
        );
        _periodo.horarios.forEach((h) => print(h));
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
              ListIndicator(hint: "Periodo"),
              ViewPeriodosInsertBuilder.numPeriodoSliderTile(
                numPeriodo: _periodo.numPeriodo.toDouble(),
                onChanged: _setNumPeriodoDouble,
              ),
              _divider(),
              ViewPeriodosInsertBuilder.inicioDateTile(
                inicio: _periodo.inicio,
                onTap: () async {
                  final dt = await showDatePicker(
                    context: context,
                    initialDate: _periodo.inicio,
                    firstDate: DateTime(2010, 1, 1),
                    lastDate: _lastDate,
                  );

                  if (dt != null) {
                    _setDataIni(dt);
                  }
                },
              ),
              _divider(),
              ViewPeriodosInsertBuilder.terminoDateTile(
                termino: _periodo.termino,
                onTap: () async {
                  final termino = await showDatePicker(
                    context: context,
                    initialDate: _periodo.termino,
                    firstDate: _periodo.inicio,
                    lastDate: _lastDate,
                  );

                  if (termino != null) _setDataTermino(termino);
                },
              ),
              ListIndicator(hint: "Valores de Reprovação"),
              ViewPeriodosInsertBuilder.notaMinimaSliderTile(
                nota: _periodo.medAprov,
                onChanged: (n) => _setMedAprov(n),
              ),
              _divider(),
              ViewPeriodosInsertBuilder.presencaObrigatoriaSliderTile(
                _periodo.presObrig.toDouble(),
                (double value) => _setPresObrigDouble(value),
              ),
              _divider(),
              ListIndicator(
                hint: "Aulas e Horários",
              ),
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
