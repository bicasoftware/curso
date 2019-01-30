import 'dart:async';
import 'package:curso/container/faltas.dart';
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

  static Future<Faltas> upsertFaltas(Faltas falta) async {
    if (falta.idMateria == null) throw Exception("Faltando IDMATERIA em $falta");
    final db = await DBProvider.instance;

    if (falta.id == null) {
      final id = await db.insert(Faltas.tableName, falta.toMap());
      falta.copyWith(id: id);
    } else {
      await db.update(
        Faltas.tableName,
        falta.toMap(),
        where: "id = ?",
        whereArgs: [falta.id],
      );
    }

    return falta;
  }

  static Future deleteFalta(Faltas falta) async {
    await deleteFaltaById(falta.id);
  }

  static Future deleteFaltaById(int idFalta) async {
    final db = await DBProvider.instance;
    await db.delete(
      Faltas.tableName,
      where: "id = ?",
      whereArgs: [idFalta],
    );
  }
}
