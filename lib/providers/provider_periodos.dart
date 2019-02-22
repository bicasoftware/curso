import 'dart:async';

import '../container/periodos.dart';
import '../database/db_provider.dart';
import 'provider_horarios.dart';
import 'provider_materias.dart';

class ProviderPeriodos {
  static Future<List<Periodos>> fetchAllPeriodos() async {
    final db = await DBProvider.instance;

    final result = await db.query(Periodos.tableName, columns: Periodos.provideColumns);
    final List<Periodos> periodos = result.map((it) => Periodos.fromMap(it)).toList();

    for (var periodo in periodos) {
      Future.wait([
        ProviderMaterias.fetchMateriasByPeriodo(periodo.id),
        ProviderHorarios.fetchHorariosByPeriodo(periodo.id),
      ]).then((List<Object> results) {
        periodo.materias = results[0];
        periodo.horarios = results[1];
      });
    }

    return periodos;
  }

  static Future<Periodos> insertPeriodo(Periodos periodo) async {
    final db = await DBProvider.instance;
    final newId = await db.insert(Periodos.tableName, periodo.toMap());
    return periodo..id = newId;
  }

  static Future<Periodos> updatePeriodo(Periodos periodo) async {
    final db = await DBProvider.instance;
    db.update(
      Periodos.tableName,
      periodo.toMap(),
      where: "${Periodos.ID} = ?",
      whereArgs: [periodo.id],
    );

    return periodo;
  }

  static Future deletePeriodo(int idPeriodo) async {
    final db = await DBProvider.instance;
    await ProviderMaterias.deleteMateriasByIdPeriodo(idPeriodo);
    await db.delete(Periodos.tableName, where: "${Periodos.ID} = ?", whereArgs: [idPeriodo]);
  }
}
