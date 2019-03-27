import 'package:meta/meta.dart';

class CalendarioDTO {
  final int mes;
  final List<DataDTO> dates;

  const CalendarioDTO({this.mes, this.dates});
}

class DataDTO {
  final DateTime date;
  final List<AulasSemanaDTO> aulas;

  const DataDTO({this.date, this.aulas});
}

class AulasSemanaDTO {
  final int idMateria;
  final int idPeriodo;
  final int ordemAula;
  final int weekDay;
  final int cor;
  final String nome;
  final String sigla;
  final DateTime horario;

  AulasSemanaDTO({
    @required this.idMateria,
    @required this.idPeriodo,
    @required this.ordemAula,
    @required this.weekDay,
    @required this.cor,
    @required this.nome,
    @required this.sigla,
    @required this.horario,
  });
}
