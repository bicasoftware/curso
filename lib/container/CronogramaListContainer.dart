import 'package:flutter/material.dart';

class CronogramaListContainer {
  final int weekDay;
  final Color corMateria;
  final String sigla;

  CronogramaListContainer({
    this.weekDay,
    this.corMateria,
    this.sigla,
  });

  CronogramaListContainer copyWith({int weekDay, MaterialColor corMateria, String sigla}) {
    return CronogramaListContainer(
      weekDay: weekDay ?? this.weekDay,
      corMateria: corMateria ?? this.corMateria,
      sigla: sigla ?? this.sigla,
    );
  }
}
