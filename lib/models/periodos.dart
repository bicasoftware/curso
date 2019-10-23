import 'package:curso/container/calendario.dart';
import 'package:curso/models/faltas.dart';
import 'package:curso/models/horarios.dart';
import 'package:curso/models/materias.dart';
import 'package:curso/models/notas.dart';
import 'package:curso/container/parciais.dart';
import 'package:curso/database/base_table.dart';
import 'package:curso/utils.dart/calcs.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/utils.dart/double_utils.dart';
import 'package:flutter/material.dart';

class Periodos implements BaseTable {
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
    parciais = Parciais(inicioPeriodo: inicio, terminoPeriodo: termino);
  }

  factory Periodos.newInstance() {
    final now = DateTime.now();
    final end = now.add(const Duration(days: 6 * 30));
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

  factory Periodos.fromMap(Map m) {
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

  int id, presObrig, aulasDia, numPeriodo;
  DateTime inicio, termino;
  double medAprov;
  List<Materias> materias;
  List<Horarios> horarios;
  List<CalendarioDTO> calendario;
  List<AulasSemanaDTO> aulasSemana;
  Parciais parciais;

  static const String ID = "id";
  static const String NUMPERIODO = "num_periodo";
  static const String INICIO = "inicio";
  static const String TERMINO = "termino";
  static const String PRESOBRIG = "pres_obrig";
  static const String MEDAPROV = "med_aprov";
  static const String AULASDIA = "aulas_dia";

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

    if (id != null) {
      m[ID] = id;
    }

    return m;
  }

  @override
  String toString() {
    return "${id},${numPeriodo},${inicio},${termino},${presObrig},${medAprov},${materias},${aulasDia}";
  }

  void addHorario(Horarios horario) => horarios.add(horario);

  void refreshCalendario() {
    _refreshAulasSemana();

    calendario = prepareCalendario(
      inicio: inicio,
      termino: termino,
      aulasByWeekDay: aulasSemana,
      faltas: _getFaltas(),
      provas: _getProvas(),
    );
  }

  void _refreshAulasSemana() {
    aulasSemana.clear();
    if (materias != null && materias.isNotEmpty) {
      for (var ordemAula = 0; ordemAula < aulasDia; ordemAula++) {
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

  void insertFalta(Faltas falta) {
    materias.firstWhere((it) => it.id == falta.idMateria).insertFalta(falta);
    parciais.addFalta(falta);
  }

  void deleteFalta(int idMateria, int idFalta, int tipoFalta) {
    materias.firstWhere((it) => it.id == idMateria).deleteFalta(idFalta);
    parciais.removeFalta(idMateria: idMateria, tipoFalta: tipoFalta);
  }

  void insertNota(Notas nota) {
    materias.firstWhere((m) => m.id == nota.idMateria).insertNota(nota);
    calendario
        .firstWhere((c) => c.mes == nota.data.month)
        .dates
        .firstWhere((d) => isSameDay(d.date, nota.data), orElse: () => null)
        ?.setHasProvas(true);
  }

  void updateNota(Notas nota) {
    materias.firstWhere((m) => m.id == nota.idMateria).updateNota(nota);
  }

  void deleteNota(Notas nota) {
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
    final faltas = <Faltas>[];
    materias?.forEach(
      (materia) {
        materia.faltas.forEach(faltas.add);
      },
    );
    return faltas;
  }

  List<Notas> _getProvas() {
    final provas = <Notas>[];
    materias?.forEach((m) => m.notas.forEach(provas.add));
    return provas;
  }

  List<Notas> extractNotasByDate(DateTime date) {
    final notas = <Notas>[];
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

  void prepareParciais() {
    parciais = Parciais(inicioPeriodo: inicio, terminoPeriodo: termino);

    final hoje = DateTime.now();
    final aulasSemestre = countAulasInRange(inicio, termino);
    final aulasUntilNow = countAulasInRange(inicio, hoje);

    for (final m in materias) {
      ///Lista com quantas vezes determinado dia da semana existem durante o período
      final int totalAulas = countTotalAulasSemestre(m, aulasSemestre);

      ///Lista com quantas aulas existem até o dia atual
      final int totalAulasUntilNow = countTotalAulasSemestre(m, aulasUntilNow);

      ///Soma notas da materia
      final double media = calcMedia(
        ///Filtra notas cuja data são anteriores a [hoje] e com [nota] já adicionada
        m.notas.where((n) => n.data.isBefore(hoje) && n.nota != null).map((n) => n.nota).toList(),
      );

      ///Soma faltas e aulas vagas
      final faltas = m.faltas.where((f) => f.tipo == 0).length;
      final vagas = m.faltas.where((f) => f.tipo == 1).length;

      parciais.add(
        materia: m,
        numAulasSemestre: totalAulas,
        numAulasUntilNow: totalAulasUntilNow,
        notas: m.notas,
        notaAprovacao: medAprov,
        notaAtual: media,
        faltas: faltas,
        vagas: vagas,
        presObrig: presObrig,
      );
    }
  }
}
