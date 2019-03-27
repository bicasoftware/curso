import 'package:flutter/material.dart';

class CronogramaCellContainer {
  int weekDay;
  Color corMateria;
  String sigla;
  int idAula;

  CronogramaCellContainer({
    @required this.weekDay,
    @required this.corMateria,
    @required this.sigla,
    @required this.idAula,
  });
}
