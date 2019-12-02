import 'package:curso/models/aulas.dart';
import 'package:curso/models/configuration.dart';
import 'package:curso/models/horarios.dart';
import 'package:curso/models/materias.dart';
import 'package:curso/models/notas.dart';
import 'package:curso/models/periodos.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DbSeeder {
  static Future<void> applySignInSeed(Database db) async {
    await db.transaction((tr) async {
      await tr.insert(
        Periodos.tableName,
        Periodos(
          numPeriodo: 1,
          aulasDia: 4,
          inicio: DateTime(2019, 06, 08),
          termino: DateTime(2019, 12, 20),
          medAprov: 7.0,
          presObrig: 75,
        ).toMap(),
      );

      final m1 = Materias(
        id: null,
        idPeriodo: 1,
        cor: Colors.red.value,
        freq: true,
        nome: "Matemática",
        sigla: "MAT",
        medAprov: 7.0,
      );
      final m2 = Materias(
        id: null,
        idPeriodo: 1,
        cor: Colors.orange.value,
        freq: true,
        nome: "Português",
        sigla: "POR",
        medAprov: 7.0,
      );
      final m3 = Materias(
        id: null,
        idPeriodo: 1,
        cor: Colors.yellow.value,
        freq: true,
        nome: "História",
        sigla: "HIS",
        medAprov: 7.0,
      );
      final m4 = Materias(
        id: null,
        idPeriodo: 1,
        cor: Colors.teal.value,
        freq: true,
        nome: "Geografia",
        sigla: "GEO",
        medAprov: 7.0,
      );
      final m5 = Materias(
        id: null,
        idPeriodo: 1,
        cor: Colors.lime.value,
        freq: true,
        nome: "Física",
        sigla: "FIS",
        medAprov: 7.0,
      );

      final hora1 = Horarios(
        inicio: parseTime("18:00"),
        termino: parseTime("18:50"),
        idPeriodo: 1,
        ordemAula: 0,
      );
      final hora2 = Horarios(
        inicio: parseTime("18:50"),
        termino: parseTime("19:40"),
        idPeriodo: 1,
        ordemAula: 1,
      );
      final hora3 = Horarios(
        inicio: parseTime("20:00"),
        termino: parseTime("20:50"),
        idPeriodo: 1,
        ordemAula: 2,
      );
      final hora4 = Horarios(
        inicio: parseTime("20:50"),
        termino: parseTime("21:40"),
        idPeriodo: 1,
        ordemAula: 3,
      );
      final aula1 = Aulas(id: null, idMateria: 1, idPeriodo: 1, ordem: 0, weekDay: 1);
      final aula2 = Aulas(id: null, idMateria: 1, idPeriodo: 1, ordem: 1, weekDay: 1);
      final aula3 = Aulas(id: null, idMateria: 1, idPeriodo: 1, ordem: 2, weekDay: 1);
      final aula4 = Aulas(id: null, idMateria: 1, idPeriodo: 1, ordem: 3, weekDay: 1);
      final aula5 = Aulas(id: null, idMateria: 2, idPeriodo: 1, ordem: 0, weekDay: 2);
      final aula6 = Aulas(id: null, idMateria: 2, idPeriodo: 1, ordem: 1, weekDay: 2);
      final aula7 = Aulas(id: null, idMateria: 3, idPeriodo: 1, ordem: 2, weekDay: 2);
      final aula8 = Aulas(id: null, idMateria: 3, idPeriodo: 1, ordem: 3, weekDay: 2);
      final aula9 = Aulas(id: null, idMateria: 4, idPeriodo: 1, ordem: 0, weekDay: 3);
      final aula10 = Aulas(id: null, idMateria: 4, idPeriodo: 1, ordem: 1, weekDay: 3);
      final aula11 = Aulas(id: null, idMateria: 5, idPeriodo: 1, ordem: 2, weekDay: 3);
      final aula12 = Aulas(id: null, idMateria: 5, idPeriodo: 1, ordem: 3, weekDay: 3);
      final aula13 = Aulas(id: null, idMateria: 2, idPeriodo: 1, ordem: 0, weekDay: 4);
      final aula14 = Aulas(id: null, idMateria: 2, idPeriodo: 1, ordem: 1, weekDay: 4);

      final nota1 = Notas(id: null, idMateria: 1, nota: null, data: DateTime(2019, 8, 5));
      final nota2 = Notas(id: null, idMateria: 2, nota: null, data: DateTime(2019, 8, 6));
      final nota3 = Notas(id: null, idMateria: 3, nota: null, data: DateTime(2019, 8, 7));
      final nota4 = Notas(id: null, idMateria: 4, nota: null, data: DateTime(2019, 8, 8));

      await tr.insert(Horarios.tableName, hora1.toMap());
      await tr.insert(Horarios.tableName, hora2.toMap());
      await tr.insert(Horarios.tableName, hora3.toMap());
      await tr.insert(Horarios.tableName, hora4.toMap());
      await tr.insert(Materias.tableName, m1.toMap());
      await tr.insert(Materias.tableName, m2.toMap());
      await tr.insert(Materias.tableName, m3.toMap());
      await tr.insert(Materias.tableName, m4.toMap());
      await tr.insert(Materias.tableName, m5.toMap());
      await tr.insert(Aulas.tableName, aula1.toMap());
      await tr.insert(Aulas.tableName, aula2.toMap());
      await tr.insert(Aulas.tableName, aula3.toMap());
      await tr.insert(Aulas.tableName, aula4.toMap());
      await tr.insert(Aulas.tableName, aula5.toMap());
      await tr.insert(Aulas.tableName, aula6.toMap());
      await tr.insert(Aulas.tableName, aula7.toMap());
      await tr.insert(Aulas.tableName, aula8.toMap());
      await tr.insert(Aulas.tableName, aula9.toMap());
      await tr.insert(Aulas.tableName, aula10.toMap());
      await tr.insert(Aulas.tableName, aula11.toMap());
      await tr.insert(Aulas.tableName, aula12.toMap());
      await tr.insert(Aulas.tableName, aula13.toMap());
      await tr.insert(Aulas.tableName, aula14.toMap());
      await tr.insert(Notas.tableName, nota1.toMap());
      await tr.insert(Notas.tableName, nota2.toMap());
      await tr.insert(Notas.tableName, nota3.toMap());
      await tr.insert(Notas.tableName, nota4.toMap());

      await tr.insert(
        Configuration.tableName,
        const Configuration(id: null, isLight: true, notify: true).toMap(),
      );
    });
  }
}
