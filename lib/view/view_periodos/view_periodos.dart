import 'package:curso/bloc/bloc_main/BlocMain.dart';
import 'package:curso/events/events_main/MainEvents.dart';
import 'package:curso/main_state.dart';
import 'package:curso/view/view_periodos/view_periodos_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewPeriodos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final b = BlocProvider.of<BlocMain>(context);

    //todo - Gerar tela de inclusão de periodos. Limitar o id do periodo conforme o Combobox

    return BlocBuilder<MainEvents, MainState>(
      bloc: b,
      builder: (c, state) {
        return Container(
          padding: EdgeInsets.all(0),
          child: ViewPeriodosBuilder.listPeriodos(
            context,
            state.periodos,
            (i) => print("$i"),
          ),
        );
      },
    );
  }
}
