import 'package:curso/clients/client_aulas.dart';
import 'package:curso/clients/client_helper.dart';
import 'package:curso/dto/aulas_dto.dart';
import 'package:curso/dto/delete_dto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final client = ClientAulas(ClientHelper().getDio());

  test('CRUD AULAS', () async {
    try {
      final aulas = await client.fetch(15);
      assert(aulas is List<AulasDto>);

      var aula = AulasDto()
        ..materia_id = 15
        ..ordem = 0
        ..weekday = 1;

      aula = await client.post(aula);

      assert(aula != null);

      final deleteResult = await client.delete(aula.id);
      assert(deleteResult is DeleteDto);
      assert(deleteResult.removed == 1);
    } catch (e) {
      if(e is DioError) {
        print(e.response);
      }
    }
  });
}
