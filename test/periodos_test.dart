import 'package:curso/clients/client_helper.dart';
import 'package:curso/clients/client_periodos.dart';
import 'package:curso/dto/delete_dto.dart';
import 'package:curso/dto/periodos_dto.dart';
import 'package:curso/dto/update_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final client = ClientPeriodos(ClientHelper().getDio());

  test('fetch periodos', () async {
    final periodos = await client.fetchAll();
    assert(periodos is List<PeriodosDto>);
  });

  test('CRUD periodos', () async {
    var periodo = PeriodosDto(
      inicio: DateTime(2020, 2, 12),
      termino: DateTime(2020, 6, 24),
      numperiodo: 2,
      medaprov: 8.0,
      aulasdia: 4,
      presObrig: 75,
    );

    periodo = await client.post(periodo);
    assert(periodo.id != null);

    final updateDto = await client.put(periodo.id, periodo..aulasdia = 6);
    assert(updateDto.modified == 1);

    final deleteDto = await client.delete(periodo.id);
    assert(deleteDto is DeleteDto);
    assert(deleteDto.removed == 1);
  });
}
