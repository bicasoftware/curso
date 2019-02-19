import 'dart:async';

import 'package:curso/container/aulas.dart';
import 'package:curso/database/db_provider.dart';

class ProviderAulas {
  static Future<List<Aulas>> fetchAulasByMateria(int idMateria) async {
    final db = await DBProvider.instance;
    final r = await db.query(
      Aulas.tableName,
      columns: Aulas.provideColumns,
      where: "${Aulas.IDMATERIA} = ?",
      whereArgs: [idMateria],
    );

    return r.map((it) => Aulas.fromMap(it)).toList();
  }

  static Future<Aulas> insertAulas(Aulas aula) async {
    if (aula.idMateria == null) throw Exception("Faltando IDMATERIA em $aula");
    final db = await DBProvider.instance;
    final id = await db.insert(Aulas.tableName, aula.toMap());

    return aula..id = id;
  }

  static Future<Aulas> updateAula(Aulas aula) async {
    final db = await DBProvider.instance;

    await db.update(
      Aulas.tableName,
      aula.toMap(),
      where: "id = ?",
      whereArgs: [aula.id],
    );

    return aula;
  }

  static Future deleteAulas(Aulas aula) async {
    await deleteAulasById(aula.id);
  }

  static Future deleteAulasById(int idAula) async {
    final db = await DBProvider.instance;
    await db.delete(
      Aulas.tableName,
      where: "id = ?",
      whereArgs: [idAula],
    );
  }

  static Future deleteAulaByOrdemDia(int idMateria, int weekDay, int ordemAula) async {
    final db = await DBProvider.instance;
    await db.delete(
      Aulas.tableName,
      where: "${Aulas.IDMATERIA} = ? and ${Aulas.WEEKDAY} = ? and ${Aulas.ORDEM} = ?",
      whereArgs: [idMateria, weekDay, ordemAula],
    );
  }
}
