import 'package:curso/container/aulas.dart';
import 'package:curso/container/conf.dart';
import 'package:curso/container/faltas.dart';
import 'package:curso/container/horarios.dart';
import 'package:curso/container/materias.dart';
import 'package:curso/container/notas.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/utils.dart/AppBrightness.dart';
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
    await _createConf(db);
    await _initializeConf(db);
    await _createHorarios(db);
  }

  static Future _initializeConf(Database db) async {
    await db.transaction((tr) {
      tr.insert(
        Conf.tableName,
        Conf(brightness: AppBrightness.DARK, notify: true).toMap(),
      );

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

  static Future _createConf(Database db) async {
    return await db.execute(Conf.getCreateSQL());
  }

  static Future _createAulas(Database db) async {
    return await db.execute(Aulas.getCreateSQL());
  }

  static Future _createHorarios(Database db) async {
    return await db.execute(Horarios.getCreateSQL());
  }
}
