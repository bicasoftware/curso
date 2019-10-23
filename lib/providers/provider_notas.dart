import 'dart:async';
import 'package:curso/models/notas.dart';
import 'package:curso/database/db_provider.dart';

class ProviderNotas {
  static Future<List<Notas>> fetchAll() async {
    final db = await DBProvider.instance;
    final r = await db.query(
      Notas.tableName,
      columns: Notas.provideColumns,
    );

    return r.map((it) => Notas.fromMap(it)).toList();
  }

  static Future<List<Notas>> fetchNotasByMateria(int idMateria) async {
    final db = await DBProvider.instance;
    final r = await db.query(
      Notas.tableName,
      columns: Notas.provideColumns,
      where: "${Notas.IDMATERIA} = ?",
      whereArgs: [idMateria],
    );

    return r.map((it) => Notas.fromMap(it)).toList();
  }

  static Future<Notas> upsertNota(Notas nota) async {
    final db = await DBProvider.instance;
    if (nota.idMateria == null) {
      throw Exception("Faltando IDMATERIA em $nota");
    }
    if (nota.id == null) {
      final id = await db.insert(Notas.tableName, nota.toMap());
      nota.id = id;
    } else {
      await db.update(
        Notas.tableName,
        nota.toMap(),
        where: "id = ?",
        whereArgs: [nota.id],
      );
    }

    return nota;
  }

  static Future deleteNota(Notas nota) async {
    final db = await DBProvider.instance;
    await db.delete(
      Notas.tableName,
      where: "${Notas.ID} = ?",
      whereArgs: [nota.id],
    );
  }
}
