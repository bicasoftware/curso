import 'dart:async';
import 'package:curso/container/notas.dart';
import 'package:curso/database/db_provider.dart';

class ProviderNotas {
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
    if (nota.idMateria == null) throw Exception("Faltando IDMATERIA em $nota");
    if (nota.id == null) {
      int id = await db.insert(Notas.tableName, nota.toMap());
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

  Future deleteNota(Notas nota) async {
    await deleteNotaById(nota.id);
  }

  static Future deleteNotaById(int idNota) async {
    final db = await DBProvider.instance;
    await db.delete(
      Notas.tableName,
      where: "id = ?",
      whereArgs: [idNota],
    );
  }
}
