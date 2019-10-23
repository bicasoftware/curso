import 'package:curso/models/notas.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:meta/meta.dart';

class NotasContainer {
  NotasContainer({@required this.mes, @required this.dates}) {
    dates = [];
  }

  int mes;
  List<NotasByDate> dates;

  void addDates(NotasByDate dates) {
    this.dates.add(dates);
  }

  void insertNota(DateTime selectedDate, Notas nota) {
    dates.firstWhere((d) => isSameDay(d.date, selectedDate)).addNota(nota);
  }

  void deleteNota(DateTime selectedDate, Notas nota) {
    dates.firstWhere((d) => isSameDay(d.date, selectedDate)).removeNota(nota);
  }
}

class NotasByDate {
  NotasByDate({this.date, this.materias}) {
    materias = <MateriasByDate>[];
  }

  DateTime date;
  List<MateriasByDate> materias;
  
  NotasByDate getCopy() {
    return NotasByDate(date: date, materias: []..addAll(materias));
  }

  @override
  String toString() {
    return "date: $date, materias: ${materias.join(',')}";
  }

  void addMateria(MateriasByDate materia) {
    materias.add(materia);
  }

  void deleteMateria(MateriasByDate materia) {
    materias.remove(materia);
  }

  void addNota(Notas nota) => materias.firstWhere((m) => m.id == nota.idMateria).addNota(nota);

  void removeNota(Notas nota) => materias.firstWhere((m) => m.id == nota.idMateria).deleteProva();
}

class MateriasByDate {
  MateriasByDate({
    @required this.cor,
    @required this.nome,
    @required this.sigla,
    @required this.id,
    @required this.notas,
  });

  int cor, id;
  String nome, sigla;
  Notas notas;

  void addNota(Notas nota) => notas = nota;

  void deleteProva() => notas = null;

  @override
  String toString() {
    return "id: $id, cor: $cor, nome: $nome, sigla: $sigla, nota: $notas";
  }
}
