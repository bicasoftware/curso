import 'package:curso/container/notas.dart';
import 'package:meta/meta.dart';

class CronogramaNotas {
  int mes;
  List<CronogramaDates> dates;

  CronogramaNotas({@required this.mes, this.dates}) {
    dates = [];
  }

  addDates(CronogramaDates dates) {
    this.dates.add(dates);
  }
}

class CronogramaDates {
  DateTime date;
  List<CronogramaMaterias> materias;

  CronogramaDates({this.date, this.materias});

  CronogramaDates getCopy() {
    return CronogramaDates(date: this.date, materias: []..addAll(this.materias));
  }

  addMateria(CronogramaMaterias materia){
    materias.add(materia);
  }

  deleteMateria(CronogramaMaterias materia){
    materias.remove(materia);
  }
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

  addProva(
    int idProva,
    DateTime data,
    double nota,
  ) {
    notas.id = idProva;
    notas.idMateria = id;
    notas.data = data;
    notas.nota = nota;
  }

  deleteProva(int idProva) {
    notas = null;
  }
}
