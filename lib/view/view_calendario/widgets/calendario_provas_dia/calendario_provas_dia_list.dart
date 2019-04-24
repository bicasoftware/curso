import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/calendario.dart';
import 'package:curso/container/cronograma.dart';
import 'package:curso/utils.dart/pair.dart';
import 'package:curso/widgets/happy_placeholder.dart';
import 'package:flutter/material.dart';

class CalendarioProvasDiaList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<BlocMain>(context);

    return Column(
      children: <Widget>[
        StreamBuilder<Pair<List<ProvasNotasMaterias>, List<AulasSemanaDTO>>>(
          stream: bloc.outProvasNotasMaterias,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data.first.length == 0) {
              return HappyPlaceholder();
            } else {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: snapshot.data.first.length,
                separatorBuilder: (c, i) => Divider(height: 0),
                itemBuilder: (c, i) {
                  final provaNotasMaterias = snapshot.data.first[i];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.school),
                      backgroundColor: Color(provaNotasMaterias.materia.cor),
                    ),
                    title: Text(provaNotasMaterias.materia.nome),
                    subtitle: Text("Nota: " + (provaNotasMaterias.nota.nota ?? 0.0).toString()),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_sweep),
                      onPressed: () {
                        bloc.deleteNota(provaNotasMaterias.nota);
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }
}
