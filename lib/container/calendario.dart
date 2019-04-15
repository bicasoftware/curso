import 'package:curso/container/faltas.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CalendarioDTO {
  final int mes;
  final List<DataDTO> dates;

  const CalendarioDTO({this.mes, this.dates});

  addFalta(Faltas falta) {
    dates.firstWhere((dt) => isSameDay(dt.date, falta.data)).insertFalta(falta);
  }

  removeFalta(DateTime date, int idFalta) {
    dates.firstWhere((dt) => isSameDay(dt.date, date)).deleteFalta(idFalta);
  }
}

class DataDTO {
  final DateTime date;
  final List<AulasSemanaDTO> aulas;

  const DataDTO({this.date, this.aulas});

  insertFalta(Faltas falta) {
    aulas.firstWhere((aula) => aula.numAula == falta.numAula).insertFalta(falta);
  }

  deleteFalta(int idFalta) {
    aulas.firstWhere((aula) => aula.idFalta == idFalta).deleteFalta();
  }
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
    );
  }

  insertFalta(Faltas falta) => this.idFalta = falta.id;

  deleteFalta() => this.idFalta = null;

  get isFalta => idFalta != null;

  bool isSameItem(int idMateria, int weekDay){
    print("aqui");
    return this.idMateria == idMateria  && this.weekDay == weekDay;
  }
}
