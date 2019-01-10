class Notas {
  final int id, idMateria;
  final DateTime data;
  final int ordemAula;

  Notas({
    this.id,
    this.idMateria,
    this.data,
    this.ordemAula,
  });

  Notas copyWith(int id, int idMateria, DateTime data, int ordemAula) {
    return Notas(
      id: id ?? this.id,
      idMateria: idMateria ?? this.idMateria,
      data: data ?? this.data,
      ordemAula: ordemAula ?? this.ordemAula,
    );
  }
}
