import 'package:curso/clients/client_faltas.dart';
import 'package:curso/clients/client_helper.dart';
import 'package:curso/clients/client_materias.dart';
import 'package:curso/dto/faltas_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final client = ClientFaltas(ClientHelper().getDio());
  final clientMaterias = ClientMaterias(ClientHelper().getDio());

  test('CRUD FALTAS', () async {
    final materias = await clientMaterias.fetch(1);
    final materiaId = materias[0].id;

    final List<FaltasDto> faltas = await client.fetch(materiaId);
    assert(faltas is List<FaltasDto>);

    var falta = FaltasDto(
      materia_id: materiaId,
      ordemAula: 1,
      data: DateTime(2020, 2, 1),
    );

    falta = await client.post(falta);

    final delete = await client.delete(falta.id);
    assert(delete.removed == 1);
  });
}
