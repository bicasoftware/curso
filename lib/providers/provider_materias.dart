import 'dart:async';

import 'package:curso/models/faltas.dart';
import 'package:curso/models/materias.dart';
import 'package:curso/models/notas.dart';
import 'package:curso/database/db_provider.dart';
import 'package:curso/models/aulas.dart';
import 'package:sqflite/sqflite.dart';

import 'provider_aulas.dart';
import 'provider_faltas.dart';
import 'provider_notas.dart';

class ProviderMaterias {
  final ProviderFaltas providerFaltas = ProviderFaltas();
  final ProviderNotas providerNotas = ProviderNotas();
  final ProviderAulas providerAulas = ProviderAulas();

  static Future<List<Materias>> fetchMateriasByPeriodo(int idPeriodo) async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(
      Materias.tableName,
      columns: Materias.provideColumns,
      where: "${Materias.IDPERIODO} = ?",
      whereArgs: [idPeriodo],
    );

    final materias = result.map((m) => Materias.fromMap(m)).toList();

    for (Materias m in materias) {
      m.aulas = await ProviderAulas.fetchAulasByMateria(m.id);
      m.notas = await ProviderNotas.fetchNotasByMateria(m.id);
      m.faltas = await ProviderFaltas.fetchFaltasByMateria(m.id);
    }

    return materias;
  }

  static Future<Materias> fetchMateriasById(int idMateria) async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(
      Materias.tableName,
      columns: Materias.provideColumns,
      where: "${Materias.ID} = ?",
      whereArgs: [idMateria],
      limit: 1,
    );

    final materia = Materias.fromMap(result[0]);
    materia.faltas = await ProviderFaltas.fetchFaltasByMateria(materia.id);
    materia.notas = await ProviderNotas.fetchNotasByMateria(materia.id);
    materia.aulas = await ProviderAulas.fetchAulasByMateria(materia.id);

    return materia;
  }

  static Future<Materias> insertMateria(Materias materia) async {
    if (materia.idPeriodo == null) {
      throw Exception("Faltando idPeriodo em $materia");
    }
    final db = await getDatabase();
    final id = await db.insert(Materias.tableName, materia.toMap());
    return materia..id = id;
  }

  static Future deleteMateria(int idMateria) async {
    final db = await getDatabase();
    final Batch batch = db.batch();

    batch.delete(Aulas.tableName, where: "${Aulas.IDMATERIA} = ?", whereArgs: [idMateria]);
    batch.delete(Notas.tableName, where: "${Notas.IDMATERIA} = ?", whereArgs: [idMateria]);
    batch.delete(Faltas.tableName, where: "${Faltas.IDMATERIA} = ?", whereArgs: [idMateria]);
    batch.delete(Materias.tableName, where: "id = ?", whereArgs: [idMateria]);
    await batch.commit();
  }

  static Future<Materias> updateMateria(Materias materia) async {
    final db = await getDatabase();
    final batch = db.batch();
    //Atualiza materia separadamente
    batch.update(
      Materias.tableName,
      materia.toMap(),
      where: "${Materias.ID} = ?",
      whereArgs: [materia.id],
    );
    //deleta todas as faltas, notas e aulas
    batch.delete(Faltas.tableName, where: "${Faltas.IDMATERIA} = ?", whereArgs: [materia.id]);
    batch.delete(Notas.tableName, where: "${Notas.IDMATERIA} = ?", whereArgs: [materia.id]);
    batch.delete(Aulas.tableName, where: "${Aulas.IDMATERIA} = ?", whereArgs: [materia.id]);

    //adiciona novamente todas as faltas, notas e aulas
    materia.aulas.forEach((aula) {
      batch.insert(Aulas.tableName, (aula..id = null).toMap());
    });
    materia.notas.forEach((nota) {
      batch.insert(Notas.tableName, (nota..id = null).toMap());
    });
    materia.faltas.forEach((falta) {
      batch.insert(Faltas.tableName, (falta..id = null).toMap());
    });

    await batch.commit();
    return await fetchMateriasById(materia.id);
  }

  static Future deleteMateriasByIdPeriodo(int idPeriodo) async {
    final db = await getDatabase();
    final batch = db.batch();
    final result = await db.query(
      Materias.tableName,
      columns: Materias.provideColumns,
      where: "${Materias.IDPERIODO} = ?",
      whereArgs: [idPeriodo],
    );

    final materias = result.map((m) => Materias.fromMap(m)).toList();
    materias.forEach((materia) {
      batch.delete(Aulas.tableName, where: "${Aulas.IDMATERIA} = ?", whereArgs: [materia.id]);
      batch.delete(Faltas.tableName, where: "${Faltas.IDMATERIA} = ?", whereArgs: [materia.id]);
      batch.delete(Notas.tableName, where: "${Notas.IDMATERIA} = ?", whereArgs: [materia.id]);
      batch.delete(Materias.tableName, where: "${Materias.ID} = ?", whereArgs: [materia.id]);
    });

    await batch.commit();
  }
}
