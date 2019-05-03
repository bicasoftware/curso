import 'package:curso/container/notas.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:meta/meta.dart';

class NotasContainer {
  int mes;
  List<NotasByDate> dates;

  NotasContainer({@required this.mes, @required this.dates}) {
    dates = [];
  }

  addDates(NotasByDate dates) {
    this.dates.add(dates);
  }

  insertNota(DateTime selectedDate, Notas nota) {
    dates.firstWhere((d) => isSameDay(d.date, selectedDate)).addNota(nota);
  }

  deleteNota(DateTime selectedDate, Notas nota) {
    dates.firstWhere((d) => isSameDay(d.date, selectedDate)).removeNota(nota);
  }
}

class NotasByDate {
  DateTime date;
  List<MateriasByDate> materias;

  @override
  String toString(){
    return "date: $date, materias: ${materias.join(',') }";
  }

  NotasByDate({this.date, this.materias}) {
    materias = List<MateriasByDate>();
  }

  NotasByDate getCopy() {
    return NotasByDate(date: this.date, materias: []..addAll(this.materias));
  }

  addMateria(MateriasByDate materia) {
    materias.add(materia);
  }

  deleteMateria(MateriasByDate materia) {
    materias.remove(materia);
  }

  addNota(Notas nota) => materias.firstWhere((m) => m.id == nota.idMateria).addNota(nota);

  removeNota(Notas nota) => materias.firstWhere((m) => m.id == nota.idMateria).deleteProva();
}

class MateriasByDate {
  int cor, id;
  String nome, sigla;
  Notas notas;

  MateriasByDate({
    @required this.cor,
    @required this.nome,
    @required this.sigla,
    @required this.id,
    @required this.notas,
  });

  addNota(Notas nota) => notas = nota;

  deleteProva() => notas = null;

  @override
  String toString(){
    return "id: $id, cor: $cor, nome: $nome, sigla: $sigla, nota: $notas";
  }
}
