import 'dart:async';

import 'package:curso/models/aulas.dart';
import 'package:curso/models/configuration.dart';
import 'package:curso/models/faltas.dart';
import 'package:curso/models/horarios.dart';
import 'package:curso/models/materias.dart';
import 'package:curso/models/notas.dart';
import 'package:curso/models/periodos.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  return DBProvider.instance;
}

class DBProvider {
  factory DBProvider() {
    return _instance;
  }

  DBProvider._internal() {
    _create().then((it) => _db = it);
  }

  static final DBProvider _instance = DBProvider._internal();

  static const String _DBNAME = "curso_gestor";
  static const int _VERSION = 1;
  static Database _db;

  static Future<Database> get instance async {
    return _db ??= await _create();
  }

  static Future<Database> _create() async {
    final path = await getApplicationDocumentsDirectory();
    final dbPath = join(path.path, _DBNAME);

    return _db = await openDatabase(dbPath, version: _VERSION, onCreate: _createTables);
  }

  static Future _createTables(Database db, int version) async {
    await _createNotas(db);
    await _createFaltas(db);
    await _createMaterias(db);
    await _createAulas(db);
    await _createPeriodos(db);
    await _createHorarios(db);
    await _createConfig(db);
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

  static Future _createConfig(Database db) async {
    return await db.execute(Configuration.createSQL);
  }
}
