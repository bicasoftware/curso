import 'package:curso/clients/client_helper.dart';
import 'package:curso/clients/client_horarios.dart';
import 'package:curso/clients/client_periodos.dart';
import 'package:curso/dto/horarios_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final client = ClientHorarios(ClientHelper().getDio());
  final periodosCliente = ClientPeriodos(ClientHelper().getDio());

  test('CRUD horarios', () async {
    final periodos = await periodosCliente.fetchAll();

    var horarios = [
      for (int i = 0; i < 5; i++)
        HorariosDto(
          periodo_id: periodos.first.id,
          inicio: "18:00",
          termino: "19:00",
          ordemaula: i,
        )
    ];

    horarios = await client.post(horarios);

    assert(horarios.every((h) => h.id != null));

    final deleteDto = await client.delete(periodos.first.id);
    assert(deleteDto.removed > 0);
  });
}
