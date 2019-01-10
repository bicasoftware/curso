class Faltas {
  final int id;
  final int idMateria;
  final DateTime data;
  final int ordemAula;

  Faltas({
    this.id,
    this.idMateria,
    this.data,
    this.ordemAula,
  });

  Faltas copyWith(int id, int idMateria, DateTime data, int ordemAula) {
    return Faltas(
      id: id ?? this.id,
      idMateria: idMateria ?? this.idMateria,
      data: data ?? this.data,
      ordemAula: ordemAula ?? this.ordemAula,
    );
  }
}
