import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/view/view_time_range_picker/view_time_range_builder.dart';
import 'package:curso/view/view_time_range_picker/view_time_range_result.dart';
import 'package:curso/widgets/squared_card.dart';
import 'package:flutter/material.dart';

class ViewTimeRange extends StatefulWidget {
  final int ordemAula;
  final DateTime inicio, termino;

  const ViewTimeRange({
    Key key,
    @required this.ordemAula,
    @required this.inicio,
    @required this.termino,
  }) : super(key: key);

  _ViewTimeRangeState createState() => _ViewTimeRangeState();
}

class _ViewTimeRangeState extends State<ViewTimeRange> {
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
      appBar: AppBar(title: Text("Horários ${_ordemAula + 1}ª aula")),
      body: Container(
        padding: EdgeInsets.all(8),
        child: SquaredCard(
          elevation: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ViewTimeRangeBuilder.getTileInicio(
                date: _inicio,
                onTap: () async {
                  final DateTime inicio = await showTimeDialog(_inicio);
                  if (inicio != null) {
                    _setInicio(inicio);
                  }
                },
              ),
              Divider(height: 0),
              ViewTimeRangeBuilder.getTileTermino(
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
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: FlatButton(
          color: Theme.of(context).accentColor,
          child: Text(
            Strings.salvar,
            style: Theme.of(context).textTheme.button.copyWith(
                  color: Colors.white,
                ),
          ),
          onPressed: () => validateHorarios(c: context),
        ),
      ),
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
        ViewTimeRangeResult(
          inicio: _inicio,
          termino: _termino,
          ordemAula: _ordemAula,
        ),
      );
    }
  }
}
