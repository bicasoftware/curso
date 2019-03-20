import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/utils.dart/pair.dart';
import 'package:curso/widgets/awaiting_container.dart';
import 'package:flutter/material.dart';

class CalendarioAulasDia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final b = BlocProvider.of<BlocMain>(context);

    return Container(
      child: StreamBuilder<Pair<Periodos, DateTime>>(
          stream: b.outAulasDia,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                itemCount: snapshot.data.first.aulasDia,
                shrinkWrap: true,
                itemBuilder: (c, i) {
                  final horario = snapshot.data.first.horarios.firstWhere((h) => h.ordemAula == i);

                  final materia = snapshot.data.first.materias.firstWhere(
                    (m) {
                      return m.aulas.indexWhere(
                              (a) => a.ordem == i && a.weekDay == snapshot.data.second.weekday) >=
                          0;
                    },
                    orElse: () => null,
                  );

                  return ListTile(
                    leading: Container(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        formatTime(horario.inicio),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    title: materia != null ? Text(materia.nome) : Text("Sem Aula"),
                    trailing: CircleAvatar(
                      backgroundColor: materia != null ? Color(materia.cor) : Colors.grey,
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
