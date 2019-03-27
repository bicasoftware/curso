import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/calendario_content.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/widgets/awaiting_container.dart';
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
              return ListView.separated(
                itemCount: snapshot.data.aulas.length,
                shrinkWrap: true,
                itemBuilder: (c, i) {
                  final aulasSemana = snapshot.data.aulas[i];
                  return ListTile(
                    leading: Container(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        formatTime(aulasSemana.horario),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    title: Text(aulasSemana.nome),
                    trailing: CircleAvatar(
                      backgroundColor: Color(aulasSemana.cor),
                    ),
                  );
                },
                separatorBuilder: (c, i) => Divider(height: 0),
              );
            } else
              return AwaitingContainer();
          }),
    );
  }
}
