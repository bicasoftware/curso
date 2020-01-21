import 'package:curso/clients/client_helper.dart';
import 'package:curso/clients/client_materias.dart';
import 'package:curso/clients/client_periodos.dart';
import 'package:curso/dto/delete_dto.dart';
import 'package:curso/dto/materias_dto.dart';
import 'package:curso/dto/periodos_dto.dart';
import 'package:curso/dto/update_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final dio = ClientHelper().getDio();
  final client = ClientMaterias(dio);
  final periodosClient = ClientPeriodos(dio);

  test('CRUD materias', () async {
    final periodos = await periodosClient.fetchAll();
    assert(periodos is List<PeriodosDto>);

    final int periodoId = periodos.first.id;

    final materias = await client.fetch(periodoId);
    assert(materias is List<MateriasDto>);

    var materia = MateriasDto(
      periodo_id: periodoId,
      nome: "Artes",
      sigla: "ART",
      cor: Colors.amber.value.toString(),
      medaprov: 8.0,
      freq: 70,
    );

    materia = await client.post(materia);

    final result = await client.put(
      materia.id,
      materia
        ..nome = "Física"
        ..sigla = "FIS",
    );
    assert(result.modified == 1);

    final deleteResult = await client.delete(materia.id);
    assert(deleteResult.removed == 1);
  });
}
