import '../container/horarios.dart';
import '../database/db_provider.dart';

class ProviderHorarios {
  static Future<List<Horarios>> fetchHorariosByPeriodo(int idPeriodo) async {
    final db = await DBProvider.instance;

    final horarios = await db.query(
      Horarios.tableName,
      columns: Horarios.provideColumns,
      where: "${Horarios.IDPERIODO} = ?",
      whereArgs: [idPeriodo],
    );

    return horarios.map((h) => Horarios.fromMap(h)).toList();
  }

  static Future<Horarios> fetchHorarioByOrdemAula(int idPeriodo, int ordemAula) async {
    final db = await DBProvider.instance;

    final horario = await db.query(
      Horarios.tableName,
      columns: Horarios.provideColumns,
      where: "${Horarios.IDPERIODO} = ? and ${Horarios.ORDEMAULA} = ?",
      whereArgs: [idPeriodo, ordemAula],
      limit: 1,
    );

    return Horarios.fromMap(horario[0]);
  }
}
