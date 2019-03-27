import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../../bloc/bloc_main/bloc_main.dart';
import '../../container/periodos.dart';
import '../../utils.dart/Strings.dart';
import '../DropDownAction.dart';

class DropDownPeriodos extends StatefulWidget {
  const DropDownPeriodos({Key key}) : super(key: key);

  @override
  _DropDownPeriodosState createState() => _DropDownPeriodosState();
}

class _DropDownPeriodosState extends State<DropDownPeriodos> {
  int _posPeriodo;

  @override
  void initState() {
    super.initState();
    _posPeriodo = 1;
  }

  _setPeriodo(int pos) => setState(() => _posPeriodo = pos);

  @override
  Widget build(BuildContext context) {
    final BlocMain bloc = BlocProvider.of<BlocMain>(context);

    return StreamBuilder<List<Periodos>>(
      stream: bloc.outPeriodos,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? DropDownAction<int>(
                currentValue: _posPeriodo,
                onChanged: (int pos) {
                  bloc.setPeriodoPosition(pos);
                  _setPeriodo(pos);
                },
                children: snapshot.data.map((p) {
                  return DropdownMenuItem(
                    child: Text("${p.numPeriodo} ${Strings.periodo}"),
                    value: p.id,
                  );
                }).toList(),
              )
            : Container();
      },
    );
  }
}
