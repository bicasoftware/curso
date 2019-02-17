import 'package:flutter/material.dart';

class CronogramaContainer {
  final int ordemAula;
  final MaterialColor corMateria;
  final String sigla;

  CronogramaContainer({
    this.ordemAula,
    this.corMateria,
    this.sigla,
  });

  CronogramaContainer copyWith({int diaSemana, MaterialColor corMateria, String sigla}) {
    return CronogramaContainer(
      ordemAula: diaSemana ?? this.ordemAula,
      corMateria: corMateria ?? this.corMateria,
      sigla: sigla ?? this.sigla,
    );
  }
}
