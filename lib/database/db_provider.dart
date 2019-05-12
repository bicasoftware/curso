import 'package:curso/container/aulas.dart';
import 'package:curso/container/faltas.dart';
import 'package:curso/container/horarios.dart';
import 'package:curso/container/materias.dart';
import 'package:curso/container/notas.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DBProvider {
  static final DBProvider _instance = DBProvider._internal();

  static const String _DBNAME = "curso_gestor";
  static const int _VERSION = 1;
  static Database _db;

  factory DBProvider() {
    return _instance;
  }

  DBProvider._internal() {
    _create().then((it) => _db = it);
  }

  static Future<Database> get instance async {
    if (_db == null) _db = await _create();
    return _db;
  }

  static Future<Database> _create() async {
    var path = await getApplicationDocumentsDirectory();
    var dbPath = join(path.path, _DBNAME);

    _db = await openDatabase(dbPath, version: _VERSION, onCreate: _createTables);
    return _db;
  }

  static Future _createTables(Database db, int version) async {
    await _createNotas(db);
    await _createFaltas(db);
    await _createMaterias(db);
    await _createAulas(db);
    await _createPeriodos(db);
    await _createHorarios(db);

    await _initializeConf(db);
  }

  static Future _initializeConf(Database db) async {
    await db.transaction((tr) {
      tr.insert(
        Periodos.tableName,
        Periodos(
          id: 1,
          numPeriodo: 1,
          aulasDia: 4,
          inicio: DateTime(2019, 02, 01),
          termino: DateTime(2019, 06, 01),
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
        id: 1,
        inicio: parseTime("18:00"),
        termino: parseTime("18:50"),
        idPeriodo: 1,
        ordemAula: 0,
      );
      final hora2 = Horarios(
        id: 2,
        inicio: parseTime("18:50"),
        termino: parseTime("19:40"),
        idPeriodo: 1,
        ordemAula: 1,
      );
      final hora3 = Horarios(
        id: 3,
        inicio: parseTime("20:00"),
        termino: parseTime("20:50"),
        idPeriodo: 1,
        ordemAula: 2,
      );
      final hora4 = Horarios(
        id: 4,
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

      final nota1 = Notas(id: null, idMateria: 1, nota: null, data: DateTime(2019,3,4));
      final nota2 = Notas(id: null, idMateria: 2, nota: null, data: DateTime(2019,3,5));

      tr.insert(Horarios.tableName, hora1.toMap());
      tr.insert(Horarios.tableName, hora2.toMap());
      tr.insert(Horarios.tableName, hora3.toMap());
      tr.insert(Horarios.tableName, hora4.toMap());
      tr.insert(Materias.tableName, m1.toMap());
      tr.insert(Materias.tableName, m2.toMap());
      tr.insert(Materias.tableName, m3.toMap());
      tr.insert(Materias.tableName, m4.toMap());
      tr.insert(Materias.tableName, m5.toMap());
      tr.insert(Aulas.tableName, aula1.toMap());
      tr.insert(Aulas.tableName, aula2.toMap());
      tr.insert(Aulas.tableName, aula3.toMap());
      tr.insert(Aulas.tableName, aula4.toMap());
      tr.insert(Aulas.tableName, aula5.toMap());
      tr.insert(Aulas.tableName, aula6.toMap());
      tr.insert(Aulas.tableName, aula7.toMap());
      tr.insert(Aulas.tableName, aula8.toMap());
      tr.insert(Aulas.tableName, aula9.toMap());
      tr.insert(Aulas.tableName, aula10.toMap());
      tr.insert(Aulas.tableName, aula11.toMap());
      tr.insert(Aulas.tableName, aula12.toMap());
      tr.insert(Aulas.tableName, aula13.toMap());
      tr.insert(Aulas.tableName, aula14.toMap());

      tr.insert(Notas.tableName, nota1.toMap());
      tr.insert(Notas.tableName, nota2.toMap());
    });
  }

  static Future _createNotas(Database db) async {
    return await db.execute(Notas.getCreateSQL());
  }

  static Future _createFaltas(Database db) async {
    return await db.execute(Faltas.getCreateSQL());
  }

  static Future _createMaterias(Database db) async {
    return await db.execute(Materias.getCreateSQL());
  }

  static Future _createPeriodos(Database db) async {
    return await db.execute(Periodos.getCreateSQL());
  }

  static Future _createAulas(Database db) async {
    return await db.execute(Aulas.getCreateSQL());
  }

  static Future _createHorarios(Database db) async {
    return await db.execute(Horarios.getCreateSQL());
  }
}
