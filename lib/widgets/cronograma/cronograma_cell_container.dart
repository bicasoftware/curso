import 'package:flutter/material.dart';

class CronogramaCellContainer {
  CronogramaCellContainer({
    @required this.weekDay,
    @required this.corMateria,
    @required this.sigla,
    @required this.idAula,
  });

  int weekDay;
  Color corMateria;
  String sigla;
  int idAula;
}
