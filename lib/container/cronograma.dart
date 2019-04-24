import 'package:curso/container/materias.dart';
import 'package:curso/container/notas.dart';
import 'package:meta/meta.dart';
import 'package:curso/utils.dart/date_utils.dart';

class CronogramaNotas {
  int mes;
  List<CronogramaDates> dates;

  CronogramaNotas({@required this.mes, this.dates}) {
    dates = [];
  }

  insertDates(CronogramaDates dates) {
    this.dates.add(dates);
  }

  insertNota(DateTime selectedDate, Notas nota) {
    dates.firstWhere((d) => isSameDay(d.date, selectedDate)).addNota(nota);
  }

  deleteNota(DateTime selectedDate, Notas nota) {
    dates.firstWhere((d) => isSameDay(d.date, selectedDate)).removeNota(nota);
  }
}

class CronogramaDates {
  DateTime date;
  List<CronogramaMaterias> materias;

  CronogramaDates({this.date, this.materias}){
    materias = List<CronogramaMaterias>();
  }

  CronogramaDates getCopy() {
    return CronogramaDates(date: this.date, materias: []..addAll(this.materias));
  }

  addMateria(CronogramaMaterias materia) {
    materias.add(materia);
  }

  deleteMateria(CronogramaMaterias materia) {
    materias.remove(materia);
  }

  addNota(Notas nota) => materias.firstWhere((m) => m.id == nota.idMateria).addNota(nota);

  removeNota(Notas nota) => materias.firstWhere((m) => m.id == nota.idMateria).deleteProva();
}

class CronogramaMaterias {
  int cor, id;
  String nome, sigla;
  Notas notas;

  CronogramaMaterias({
    this.cor,
    this.nome,
    this.sigla,
    this.id,
    this.notas,
  });

  addNota(Notas nota) => notas = nota;

  deleteProva() => notas = null;
}

class ProvasNotasMaterias {
  final Notas nota;
  final Materias materia;

  ProvasNotasMaterias({this.nota, this.materia});
}