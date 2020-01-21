import 'package:curso/clients/client_helper.dart';
import 'package:curso/clients/client_notas.dart';
import 'package:curso/dto/notas_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final client = ClientNotas(ClientHelper().getDio());

  test('CRUD notas', () async {
    final notas = await client.fetch(15);
    assert(notas != null);

    var nota = NotasDto()
      ..materia_id = 1
      ..nota = 6.0
      ..data = DateTime(2020, 2, 12);

    nota = await client.post(nota);

    assert(nota != null);
    assert(nota.id != null);

    final updateDto = await client.put(nota.id, nota..nota = 10.0);

    assert(updateDto.modified == 1);

    final deleteDto = await client.delete(nota.id);
    assert(deleteDto.removed == 1);
  });
}
