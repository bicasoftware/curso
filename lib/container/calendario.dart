import 'package:curso/container/faltas.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CalendarioDTO {
  final int mes;
  final List<DataDTO> dates;

  const CalendarioDTO({@required this.mes, @required this.dates});

  DataDTO _findByDate(DateTime date) {
    return dates.firstWhere((dt) => isSameDay(dt.date, date));
  }

  void insertFalta(Faltas falta) {
    _findByDate(falta.data).insertFalta(falta);
  }

  void deleteFalta(DateTime date, int idFalta) {
    _findByDate(date).deleteFalta(idFalta);
  }
}

class DataDTO {
  final DateTime date;
  final List<AulasSemanaDTO> aulas;
  bool hasProvas;

  DataDTO({this.date, this.aulas, this.hasProvas = false});

  void insertFalta(Faltas falta) {
    final i = aulas.indexWhere((aula) => aula.numAula == falta.numAula);
    aulas[i] = aulas[i].copyWith(idfalta: falta.id, tipoFalta: falta.tipo);
  }

  void deleteFalta(int idFalta) {
    final index = aulas.indexWhere((aula) => aula.idFalta == idFalta);
    aulas[index] = aulas[index].copyWith(tipoFalta: null, idfalta: null);
  }

  List<Color> get colorList => aulas.map((aula) => Color(aula.cor)).toList();

  bool get isFalta {
    final qr = aulas.firstWhere((a) => a.idFalta != null && a.tipo == 0, orElse: () => null);
    return qr != null;
  }

  bool get isVaga {
    final qr = aulas.firstWhere((a) => a.idFalta != null && a.tipo == 1, orElse: () => null);
    return qr != null;
  }

  void setHasProvas(bool hasProvas) => this.hasProvas = hasProvas;
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
  final int idFalta;
  final int tipo;

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

  factory AulasSemanaDTO.clone(AulasSemanaDTO base) {
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

  AulasSemanaDTO copyWith({int idfalta, int tipoFalta}) {
    return AulasSemanaDTO(
      idMateria: idMateria,
      idPeriodo: idPeriodo,
      weekDay: weekDay,
      numAula: numAula,
      cor: cor,
      nome: nome,
      sigla: sigla,
      horario: horario,
      idFalta: idfalta,
      tipo: tipoFalta,
    );
  }

  bool get isFalta => idFalta != null && tipo == 0;

  bool get isAulaVaga => isFalta != null && tipo == 1;

  bool isSameItem(int idMateria, int weekDay) {
    return this.idMateria == idMateria && this.weekDay == weekDay;
  }
}
