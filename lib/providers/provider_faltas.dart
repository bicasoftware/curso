import 'dart:async';
import 'package:curso/models/faltas.dart';
import 'package:curso/database/db_provider.dart';

class ProviderFaltas {
  static Future<List<Faltas>> fetchFaltasByMateria(int idMateria) async {
    final db = await DBProvider.instance;
    final r = await db.query(
      Faltas.tableName,
      columns: Faltas.provideColumns,
      where: "${Faltas.IDMATERIA} = ?",
      whereArgs: [idMateria],
    );

    return r.map((it) => Faltas.fromMap(it)).toList();
  }

  static Future<Faltas> insertFalta(Faltas f) async {
    final db = await DBProvider.instance;
    final newId = await db.insert(Faltas.tableName, f.toMap());
    return f..id = newId;
  }

  static Future deleteFaltaById(int idFalta) async {
    final db = await DBProvider.instance;
    await db.delete(
      Faltas.tableName,
      where: "id = ?",
      whereArgs: [idFalta],
    );
  }

  static Future truncate() async {
    final db = await DBProvider.instance;
    await db.delete(Faltas.tableName);
  }

  static Future<List<Faltas>> fetchAll() async{
    final db = await DBProvider.instance;
    final result = await db.query(Faltas.tableName);
    return result.map((it) => Faltas.fromMap(it)).toList();
  }
}
