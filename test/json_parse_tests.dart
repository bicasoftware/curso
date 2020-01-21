import 'dart:convert';

import 'package:curso/dto/aulas_dto.dart';
import 'package:curso/dto/auth_dto.dart';
import 'package:curso/dto/faltas_dto.dart';
import 'package:curso/dto/horarios_dto.dart';
import 'package:curso/dto/materias_dto.dart';
import 'package:curso/dto/notas_dto.dart';
import 'package:curso/dto/periodos_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('horarios json', () async {
    const s =
        ''' { "id": 1, "periodo_id": 1, "inicio": "19:00", "termino": "19:30", "ordemaula": 0 }''';
    final parsed = json.decode(s);
    assert(HorariosDto.fromJson(parsed) is HorariosDto);
  });

  test('aulas json', () async {
    const s = '''{
      "id": 1,
      "materia_id": 1,
      "weekday": 1,
      "ordem": 0
    }''';

    final map = json.decode(s);

    assert(AulasDto.fromJson(map) is AulasDto);
  });

  test('faltas json', () async {
    const s = '''{
              "id": 1,
              "materia_id": 1,
              "data": "2019-06-22",
              "ordemAula": 1
            } ''';

    assert(FaltasDto.fromJson(json.decode(s)) is FaltasDto);
  });

  test('notas json', () async {
    const s = '''{
              "id": 1,
              "materia_id": 1,
              "data": "2019-08-12",
              "nota": 5.5
            } ''';

    assert(NotasDto.fromJson(json.decode(s)) is NotasDto);
  });

  test('materias json', () async {
    const s = '''{
          "id": 1,
          "periodo_id": 1,
          "cor": "0xFFb2b2b2",
          "nome": "Cálculo 1",
          "sigla": "Calc1",
          "freq": 70,
          "medaprov": 0,
          "aulas": [
            {
              "id": 1,
              "materia_id": 1,
              "weekday": 1,
              "ordem": 0
            },
            {
              "id": 2,
              "materia_id": 1,
              "weekday": 1,
              "ordem": 1
            }
          ],
          "faltas": [
            {
              "id": 1,
              "materia_id": 1,
              "data": "2019-06-22",
              "ordemAula": 1
            }
          ],
          "notas": [
            {
              "id": 1,
              "materia_id": 1,
              "data": "2019-08-12",
              "nota": 5.5
            }
          ]
        } ''';

    assert(MateriasDto.fromJson(json.decode(s)) is MateriasDto);
  });

  test('periodos json', () async {
    const s = '''{
      "id": 1,
      "numperiodo": 0,
      "aulasdia": 4,
      "inicio": "2020-01-14",
      "termino": "2020-06-12",
      "presObrig": 70,
      "medaprov": 70,
      "materias": [
        {
          "id": 1,
          "periodo_id": 1,
          "cor": "0xFFb2b2b2",
          "nome": "Cálculo 1",
          "sigla": "Calc1",
          "freq": 70,
          "medaprov": 0,
          "aulas": [
            {
              "id": 1,
              "materia_id": 1,
              "weekday": 1,
              "ordem": 0
            },
            {
              "id": 2,
              "materia_id": 1,
              "weekday": 1,
              "ordem": 1
            }
          ],
          "faltas": [
            {
              "id": 1,
              "materia_id": 1,
              "data": "2019-06-22",
              "ordemAula": 1
            }
          ],
          "notas": [
            {
              "id": 1,
              "materia_id": 1,
              "data": "2019-08-12",
              "nota": 5.5
            }
          ]
        }
      ],
      "horarios": [
        {
          "id": 1,
          "periodo_id": 1,
          "inicio": "19:00",
          "termino": "19:30",
          "ordemaula": 0
        },
        {
          "id": 2,
          "periodo_id": 1,
          "inicio": "19:00",
          "termino": "19:30",
          "ordemaula": 1
        }
      ]
    } ''';

    assert(PeriodosDto.fromJson(json.decode(s)) is PeriodosDto);
  });

  test('user data json', () async {
    const s = '''{
  "periodos": [
    {
      "id": 1,
      "numperiodo": 0,
      "aulasdia": 4,
      "inicio": "2020-01-14",
      "termino": "2020-06-12",
      "presObrig": 70,
      "medaprov": 70,
      "materias": [
        {
          "id": 1,
          "periodo_id": 1,
          "cor": "0xFFb2b2b2",
          "nome": "Cálculo 1",
          "sigla": "Calc1",
          "freq": 70,
          "medaprov": 0,
          "aulas": [
            {
              "id": 1,
              "materia_id": 1,
              "weekday": 1,
              "ordem": 0
            },
            {
              "id": 2,
              "materia_id": 1,
              "weekday": 1,
              "ordem": 1
            }
          ],
          "faltas": [
            {
              "id": 1,
              "materia_id": 1,
              "data": "2019-06-22",
              "ordemAula": 1
            }
          ],
          "notas": [
            {
              "id": 1,
              "materia_id": 1,
              "data": "2019-08-12",
              "nota": 5.5
            }
          ]
        }
      ],
      "horarios": [
        {
          "id": 1,
          "periodo_id": 1,
          "inicio": "19:00",
          "termino": "19:30",
          "ordemaula": 0
        },
        {
          "id": 2,
          "periodo_id": 1,
          "inicio": "19:00",
          "termino": "19:30",
          "ordemaula": 1
        }
      ]
    }
  ],
  "configurations": {
    "isLight": 1,
    "notify": 0
  },
  "email": "saulo@test.com",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEsImlhdCI6MTU3OTIwNTQ0NX0.aV4uKoV6DwAvXdPFqQipx14nJj9QrH_fi0WhVkI8DfU",
  "refresh_token": "89ffe007ffe2451f79fad567a298385cGkaqjIa+xNU1CvAUUs/tU4D1ddXv/3H8aM433YN7+m1HPLN2PAO46uBubb9eNGNT"
} ''';

    final AuthDto authData = AuthDto.fromJson(json.decode(s));
    assert(authData is AuthDto);
    print(authData.email);
    print(authData.token);
    print(authData.refresh_token);
    print(authData.periodos.length);
    print(authData.configurations.isLight);
    print(authData.configurations.notify);
  });
}
