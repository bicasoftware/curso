import 'package:curso/database/db_provider.dart';
import 'package:curso/models/aulas.dart';
import 'package:curso/models/configuration.dart';
import 'package:curso/models/faltas.dart';
import 'package:curso/models/horarios.dart';
import 'package:curso/models/login_dto.dart';
import 'package:curso/models/materias.dart';
import 'package:curso/models/notas.dart';
import 'package:curso/models/periodos.dart';

class DbLoginSeeder {
  static Future<void> syncData(LoginDto loginDto) async {
    final db = await getDatabase();
    await db.insert(Configuration.tableName, loginDto.configurations.toMap());
    for (Periodos periodo in loginDto.data.periodos) {
      final int idPeriodo = await db.insert(Periodos.tableName, periodo.toMap());

      for (Horarios horario in periodo.horarios) {
        horario.idPeriodo = idPeriodo;
        horario.id = await db.insert(Horarios.tableName, horario.toMap());
      }

      for (Materias materia in periodo.materias) {
        materia.idPeriodo = idPeriodo;
        assert(materia.idPeriodo != null);
        final int idMateria = await db.insert(Materias.tableName, materia.toMap());

        for (Aulas aula in materia.aulas) {
          aula.idMateria = idMateria;
          aula.idPeriodo = idPeriodo;
          assert(aula.idMateria != null);
          assert(aula.idPeriodo != null);
          await db.insert(Aulas.tableName, aula.toMap());
        }

        for (Notas nota in materia.notas) {
          nota.idMateria = idMateria;
          assert(nota.idMateria != null);
          await db.insert(Notas.tableName, nota.toMap());
        }

        for (Faltas falta in materia.faltas) {
          falta.idMateria = idMateria;
          assert(falta.idMateria != null);
          await db.insert(Faltas.tableName, falta.toMap());
        }
      }
    }

    /* return await db.transaction((tr) async {
      await tr.insert(Configuration.tableName, loginDto.configurations.toMap());
      for (Periodos periodo in loginDto.data.periodos) {
        periodo.id = await tr.insert(Periodos.tableName, periodo.toMap());

        for (Horarios horario in periodo.horarios) {
          horario.idPeriodo = periodo.id;
          horario.id = await tr.insert(Horarios.tableName, horario.toMap());
        }

        for (Materias materia in periodo.materias) {
          materia.idPeriodo = periodo.id;
          materia.id = await tr.insert(Materias.tableName, materia.toMap());

          for (Aulas aula in materia.aulas) {
            aula.idMateria = materia.id;
            aula.idPeriodo = periodo.id;
            aula.id = await tr.insert(Aulas.tableName, aula.toMap());
          }

          for (Notas nota in materia.notas) {
            nota.idMateria = materia.id;
            nota.id = await tr.insert(Notas.tableName, nota.toMap());
          }

          for (Faltas falta in materia.faltas) {
            falta.idMateria = materia.id;
            falta.id = await tr.insert(Faltas.tableName, falta.toMap());
          }
        }
      }
    }); */
  }
}
