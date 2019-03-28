import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/calendario_content.dart';
import 'package:curso/widgets/awaiting_container.dart';
import 'package:curso/widgets/calendario/calendario_aulas_dia/calendario_dia_extenso.dart';
import 'package:curso/widgets/calendario/calendario_aulas_dia/calendario_list_aulas.dart';
import 'package:flutter/material.dart';

///todo - REPASSAR, USAR CalendarioDTO para exibir as aulas e as faltas
class CalendarioAulasDia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final b = BlocProvider.of<BlocMain>(context);

    return Container(
      child: StreamBuilder<DataDTO>(
          stream: b.outDataDTO,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  DiaExtensoText(date: snapshot.data.date),
                  Divider(height: 0,),
                  AulasDiaList(aulas: snapshot.data.aulas),
                ],
              );
            } else
              return AwaitingContainer();
          }),
    );
  }
}