import 'dart:async';

import 'package:curso/container/horarios.dart';

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
      final materias = await ProviderMaterias.fetchMateriasByPeriodo(periodo.id);
      final horarios = await ProviderHorarios.fetchHorariosByPeriodo(periodo.id);
      periodo.materias = materias;
      periodo.horarios = horarios;
      periodo.refreshCalendario();
      periodo.prepareParciais();
    }

    return periodos;
  }

  static Future<Periodos> insertPeriodo(Periodos periodo) async {
    final db = await DBProvider.instance;
    final newId = await db.insert(Periodos.tableName, periodo.toMap());

    for (var h in periodo.horarios) {
      h.idPeriodo = newId;
      h.id = await db.insert(Horarios.tableName, h.toMap());
    }
    periodo.id = newId;
    periodo.refreshCalendario();
    periodo.prepareParciais();

    return periodo;
  }

  static Future<Periodos> updatePeriodo(Periodos periodo) async {
    final db = await DBProvider.instance;

    await db.update(
      Periodos.tableName,
      periodo.toMap(),
      where: "${Periodos.ID} = ?",
      whereArgs: [periodo.id],
    );

    await db.delete(Horarios.tableName, where: "${Horarios.IDPERIODO} = ?", whereArgs: [periodo.id]);
    for (var h in periodo.horarios) {
      h.id = await db.insert(Horarios.tableName, (h..id = null).toMap());
    }
    periodo.refreshCalendario();
    return periodo;
  }

  static Future<Null> deletePeriodo(int idPeriodo) async {
    final db = await DBProvider.instance;
    await ProviderMaterias.deleteMateriasByIdPeriodo(idPeriodo);
    await ProviderHorarios.deleteHorariosByPeriodo(idPeriodo);
    await db.delete(Periodos.tableName, where: "${Periodos.ID} = ?", whereArgs: [idPeriodo]);
  }
}
