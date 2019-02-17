import 'dart:async';

import '../container/materias.dart';
import '../container/periodos.dart';
import '../database/db_provider.dart';
import 'provider_materias.dart';

class ProviderPeriodos {
  static Future<List<Periodos>> fetchAllPeriodos() async {
    final db = await DBProvider.instance;

    final result = await db.query(Periodos.tableName, columns: Periodos.provideColumns);
    final List<Periodos> periodos = result.map((it) => Periodos.fromMap(it)).toList();
    final List<Periodos> mappedPeriodos = [];

    for (var periodo in periodos) {
      final List<Materias> materias = await ProviderMaterias.fetchMateriasByPeriodo(periodo.id);
      mappedPeriodos.add(periodo..materias = materias);
    }

    return mappedPeriodos;
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
