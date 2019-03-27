import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_date_range_picker/view_data_range_builder.dart';
import 'package:curso/view/view_date_range_picker/view_data_range_result.dart';
import 'package:flutter/material.dart';

class ViewDateRange extends StatefulWidget {
  final int ordemAula;
  final DateTime inicio, termino;

  const ViewDateRange({
    Key key,
    @required this.ordemAula,
    @required this.inicio,
    @required this.termino,
  }) : super(key: key);

  _ViewDateRangeState createState() => _ViewDateRangeState();
}

class _ViewDateRangeState extends State<ViewDateRange> {
  int _ordemAula;
  DateTime _inicio, _termino;

  @override
  void initState() {
    super.initState();
    _ordemAula = widget.ordemAula;
    _inicio = widget.inicio;
    _termino = widget.termino;
  }

  _setInicio(DateTime date) {
    setState(() {
      _inicio = date;
    });
  }

  _setTermino(DateTime date) {
    setState(() {
      _termino = date;
    });
  }

  ///Truque barato pra poder mostrar um SnackBar dentro do Scaffold
  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: ViewDateRangeBuilder.getAppBar(
        "Horários ${_ordemAula + 1}ª aula",
      ),      
      body: Card(
        //padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ViewDateRangeBuilder.getTileInicio(
              date: _inicio,
              onTap: () async {
                final DateTime inicio = await showTimeDialog(_inicio);
                if (inicio != null) {
                  _setInicio(inicio);
                }
              },
            ),
            Divider(height: 0),
            ViewDateRangeBuilder.getTileTermino(
              date: _termino,
              onTap: () async {
                final DateTime termino = await showTimeDialog(_termino);
                if (termino != null) {
                  _setTermino(termino);
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ViewDateRangeBuilder.getFAB(() => validateHorarios(c: context)),
    );
  }

  Future<DateTime> showTimeDialog(DateTime date) async {
    final TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: date.hour, minute: date.minute),
    );

    return time != null ? parseTimeOfDay(time) : date;
  }

  void showErrorSnack({@required BuildContext c, @required String msg}) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(msg)));
  }

  void validateHorarios({@required BuildContext c}) {
    if (_inicio.isAfter(_termino)) {
      showErrorSnack(c: c, msg: Errors.horariosInvalidos);
    } else if (_termino.isAtSameMomentAs(_inicio)) {
      showErrorSnack(c: c, msg: Errors.horariosIguaisInvalidos);
    } else {
      Navigator.of(c).pop(
        ViewDateRangeResult(
          inicio: _inicio,
          termino: _termino,
          ordemAula: _ordemAula,
        ),
      );
    }
  }
}
