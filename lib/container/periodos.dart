import 'package:curso/container/calendario.dart';
import 'package:curso/container/faltas.dart';
import 'package:curso/container/cronograma.dart';
import 'package:curso/container/horarios.dart';
import 'package:curso/container/materias.dart';
import 'package:curso/container/notas.dart';
import 'package:curso/database/base_table.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:flutter/material.dart';

class Periodos implements BaseTable {
  int id, presObrig, aulasDia, numPeriodo;
  DateTime inicio, termino;
  double medAprov;
  List<Materias> materias;
  List<Horarios> horarios;
  List<CalendarioDTO> calendario;
  List<AulasSemanaDTO> aulasSemana;
  List<CronogramaNotas> cronogramas;

  Periodos({
    this.id,
    this.numPeriodo,
    this.inicio,
    this.termino,
    this.presObrig,
    this.medAprov,
    this.materias,
    this.aulasDia,
  }) {
    materias = [];
    horarios = [];
    calendario = [];
    aulasSemana = [];
    cronogramas = [];
  }

  static const String ID = "id";
  static const String NUMPERIODO = "num_periodo";
  static const String INICIO = "inicio";
  static const String TERMINO = "termino";
  static const String PRESOBRIG = "pres_obrig";
  static const String MEDAPROV = "med_aprov";
  static const String AULASDIA = "aulas_dia";

  static Periodos newInstance() {
    final now = DateTime.now();
    final end = now.add(Duration(days: 6 * 30));
    return Periodos(
      numPeriodo: 1,
      inicio: now,
      termino: end,
      presObrig: 75,
      aulasDia: 4,
      medAprov: 7.0,
      materias: [],
    );
  }

  static List<String> provideColumns = [
    ID,
    NUMPERIODO,
    INICIO,
    TERMINO,
    PRESOBRIG,
    MEDAPROV,
    AULASDIA,
  ];

  static String tableName = "periodos";

  static String getCreateSQL() {
    return """create table $tableName(
    $ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    $NUMPERIODO INTEGER NOT NULL DEFAULT 1,
    $INICIO TEXT NOT NULL DEFAULT "",
    $TERMINO TEXT NOT NULL DEFAULT "",
    $PRESOBRIG INTEGER NOT NULL DEFAULT 75,
    $MEDAPROV REAL NOT NULL DEFAULT 5.0,
    $AULASDIA INTEGER NOT NULL DEFAULT 1
    );""";
  }

  @override
  Map toMap() {
    final Map<String, dynamic> m = {
      NUMPERIODO: numPeriodo,
      INICIO: formatDbDate(inicio),
      TERMINO: formatDbDate(termino),
      PRESOBRIG: presObrig,
      MEDAPROV: medAprov,
      AULASDIA: aulasDia,
    };

    if (id != null) m[ID] = id;

    return m;
  }

  static Periodos fromMap(Map m) {
    return Periodos(
      id: m[ID],
      numPeriodo: m[NUMPERIODO],
      inicio: parseDate(m[INICIO]),
      termino: parseDate(m[TERMINO]),
      presObrig: m[PRESOBRIG],
      medAprov: m[MEDAPROV],
      aulasDia: m[AULASDIA],
    );
  }

  @override
  String toString() {
    return "${this.id},${this.numPeriodo},${this.inicio},${this.termino},${this.presObrig},${this.medAprov},${this.materias},${this.aulasDia}";
  }

  addHorario(Horarios horario) => horarios.add(horario);

  refreshCalendario() {
    _refreshAulasSemana();

    calendario = prepareCalendario(
      start: inicio,
      end: termino,
      aulasByWeekDay: aulasSemana,
      faltas: _getFaltas(),
    );
  }

  _refreshAulasSemana() {
    aulasSemana.clear();
    if (materias != null && materias.length > 0) {
      for (var ordemAula = 0; ordemAula < this.aulasDia; ordemAula++) {
        for (int weekDay = 0; weekDay < 7; weekDay++) {
          final materia = materias.firstWhere(
            (m) => m.aulas.indexWhere((a) => a.ordem == ordemAula && a.weekDay == weekDay) >= 0,
            orElse: () => null,
          );

          if (materia != null) {
            aulasSemana.add(
              AulasSemanaDTO(
                idPeriodo: id,
                idMateria: materia.id,
                idFalta: null,
                weekDay: weekDay,
                cor: materia.cor,
                sigla: materia.sigla,
                nome: materia.nome,
                horario: horarios[ordemAula].inicio,
                numAula: ordemAula,
              ),
            );
          } else {
            aulasSemana.add(
              AulasSemanaDTO(
                idPeriodo: id,
                idMateria: null,
                idFalta: null,
                numAula: ordemAula,
                weekDay: weekDay,
                cor: Colors.white.value,
                nome: "Sem Aula",
                sigla: "",
                horario: horarios[ordemAula].inicio,
              ),
            );
          }
        }
      }
    }
  }

  CalendarioDTO getCalendarioByMonth(int month) {
    return calendario.firstWhere((it) => it.mes == month, orElse: () => null);
  }

  insertFalta(Faltas falta) {
    materias.firstWhere((it) => it.id == falta.idMateria).insertFalta(falta);
  }

  deleteFalta(int idMateria, int idFalta) {
    materias.firstWhere((it) => it.id == idMateria).deleteFalta(idFalta);
  }

  insertNota(Notas nota) {
    materias.firstWhere((m) => m.id == nota.idMateria).insertNota(nota);
  }

  deleteNota(Notas nota) {
    materias.firstWhere((m) => m.id == nota.idMateria).deleteNota(nota);
  }

  List<Faltas> _getFaltas() {
    final faltas = List<Faltas>();
    materias.forEach(
      (materia) {
        materia.faltas.forEach((falta) => faltas.add(falta));
      },
    );
    return faltas;
  }

  List<Notas> extractNotas() {
    final notas = List<Notas>();
    materias.forEach((m) => notas.addAll(m.notas));
    notas.sort((a, b) => a.data.compareTo(b.data));
    return notas;
  }

  List<Notas> extractNotasByDate(DateTime date) {
    final notas = List<Notas>();
    materias.forEach(
      (m) => notas.addAll(
            m.notas.where(
              (nota) => isSameDay(nota.data, date),
            ),
          ),
    );
    notas.sort((a, b) => a.data.compareTo(b.data));
    return notas;
  }

  refreshCronograma() {
    cronogramas.clear();

    for (int i = inicio.month; i <= termino.month; i++) {
      cronogramas.add(
        CronogramaNotas(mes: i, dates: List<CronogramaDates>()),
      );
    }

    final notas = extractNotas();
    final mesesComNotas = notas.map((n) => n.data.month).toSet();
    for (int mes in mesesComNotas) {
      final notasNoMes = notas.where((n) => n.data.month == mes);

      for (final nota in notasNoMes) {
        final materia = materias.firstWhere((mt) => mt.id == nota.idMateria);
        final cronoDates = CronogramaDates(date: nota.data)
          ..addMateria(
            CronogramaMaterias(
              cor: materia.cor,
              id: materia.id,
              nome: materia.nome,
              sigla: materia.sigla,
              notas: nota,
            ),
          );

        cronogramas.firstWhere((it) => it.mes == mes).insertDates(cronoDates);
      }
    }
  }

  Materias getMateriaById(int idMateria) {
    return materias.firstWhere((m) => m.id == idMateria, orElse: () => null);
  }
}
