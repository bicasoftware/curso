import 'package:curso/container/faltas.dart';
import 'package:curso/container/notas.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CalendarioDTO {
  final int mes;
  final List<DataDTO> dates;

  const CalendarioDTO({this.mes, this.dates});

  DataDTO _findByDate(DateTime date){
    return dates.firstWhere((dt) => isSameDay(dt.date, date));
  }

  insertFalta(Faltas falta) {
    _findByDate(falta.data).insertFalta(falta);
  }

  deleteFalta(DateTime date, int idFalta) {
    _findByDate(date).deleteFalta(idFalta);
  }

  setHasProvas(Notas nota, bool hasProva){
    _findByDate(nota.data).setHasProvas(hasProva);
  }
}

class DataDTO {
  final DateTime date;
  final List<AulasSemanaDTO> aulas;
  bool hasProvas;

  DataDTO({this.date, this.aulas, this.hasProvas: false});

  insertFalta(Faltas falta) {
    aulas.firstWhere((aula) => aula.numAula == falta.numAula).insertFalta(falta);
  }

  deleteFalta(int idFalta) {
    aulas.firstWhere((aula) => aula.idFalta == idFalta).deleteFalta();
  }

  get colorList => aulas.map((aula) => Color(aula.cor)).toList();

  bool get isFalta {
    final qr = aulas.firstWhere((a) => a.idFalta != null && a.tipo == 0, orElse: () => null);
    return qr != null;
  }

  bool get isVaga {
    final qr = aulas.firstWhere((a) => a.idFalta != null && a.tipo == 1, orElse: () => null);
    return qr != null;
  }

  setHasProvas(bool hasProvas) => this.hasProvas = hasProvas;
}

class AulasSemanaDTO {
  final int idPeriodo;
  final int idMateria;
  final int weekDay;
  final int numAula;
  final int cor;
  final String nome;
  final String sigla;
  final DateTime horario;
  int idFalta;
  int tipo;

  AulasSemanaDTO({
    @required this.idFalta,
    @required this.idMateria,
    @required this.idPeriodo,
    @required this.weekDay,
    @required this.numAula,
    @required this.cor,
    @required this.nome,
    @required this.sigla,
    @required this.horario,
    @required this.tipo,
  });

  static AulasSemanaDTO copyWith(AulasSemanaDTO base) {
    return AulasSemanaDTO(
      idFalta: base.idFalta,
      idMateria: base.idMateria,
      idPeriodo: base.idPeriodo,
      weekDay: base.weekDay,
      numAula: base.numAula,
      cor: base.cor,
      nome: base.nome,
      sigla: base.sigla,
      horario: base.horario,
      tipo: base.tipo,
    );
  }

  insertFalta(Faltas falta) {
    this.idFalta = falta.id;
    this.tipo = falta.tipo;
  }

  deleteFalta() => this.idFalta = null;

  get isFalta => idFalta != null && tipo == 0;

  get isAulaVaga => isFalta != null && tipo == 1;

  bool isSameItem(int idMateria, int weekDay) {
    return this.idMateria == idMateria && this.weekDay == weekDay;
  }
}
