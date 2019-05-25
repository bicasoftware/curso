import 'package:curso/container/calendario.dart';
import 'package:curso/container/faltas.dart';
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
    )..horarios = [
        Horarios(
          inicio: DateTime(1970, 1, 1, 18, 0, 0),
          termino: DateTime(1970, 1, 1, 18, 30, 0),
          ordemAula: 0,
          idPeriodo: null,
        ),
        Horarios(
          inicio: DateTime(1970, 1, 1, 18, 30, 0),
          termino: DateTime(1970, 1, 1, 19, 0, 0),
          ordemAula: 1,
          idPeriodo: null,
        ),
        Horarios(
          inicio: DateTime(1970, 1, 1, 19, 0, 0),
          termino: DateTime(1970, 1, 1, 19, 30, 0),
          ordemAula: 2,
          idPeriodo: null,
        ),
        Horarios(
          inicio: DateTime(1970, 1, 1, 19, 30, 0),
          termino: DateTime(1970, 1, 1, 20, 0, 0),
          ordemAula: 3,
          idPeriodo: null,
        ),
      ];
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
      provas: _getProvas(),
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
                tipo: null,
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
                tipo: null,
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
    calendario
        .firstWhere((c) => c.mes == nota.data.month)
        .dates
        .firstWhere((d) => isSameDay(d.date, nota.data), orElse: () => null)
        ?.setHasProvas(true);
  }

  updateNota(Notas nota) {
    materias.firstWhere((m) => m.id == nota.idMateria).updateNota(nota);
  }

  deleteNota(Notas nota) {
    materias.firstWhere((m) => m.id == nota.idMateria).deleteNota(nota);
    calendario
        .firstWhere((c) => c.mes == nota.data.month)
        .dates
        .firstWhere((d) => isSameDay(d.date, nota.data), orElse: () => null)
        ?.setHasProvas(
          _getProvas().firstWhere((p) => isSameDay(nota.data, p.data), orElse: () => null) != null,
        );
  }

  List<Faltas> _getFaltas() {
    final faltas = List<Faltas>();
    materias?.forEach(
      (materia) {
        materia.faltas.forEach((falta) => faltas.add(falta));
      },
    );
    return faltas;
  }

  List<Notas> _getProvas() {
    final provas = List<Notas>();
    materias?.forEach((m) => m.notas.forEach((n) => provas.add(n)));
    return provas;
  }

  List<Notas> extractNotasByDate(DateTime date) {
    final notas = List<Notas>();
    materias?.forEach(
      (m) => notas.addAll(
            m.notas.where(
              (nota) => isSameDay(nota.data, date),
            ),
          ),
    );
    notas.sort((a, b) => a.data.compareTo(b.data));
    return notas;
  }

  Materias getMateriaById(int idMateria) {
    return materias.firstWhere((m) => m.id == idMateria, orElse: () => null);
  }
}
