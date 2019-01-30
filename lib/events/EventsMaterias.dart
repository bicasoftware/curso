import 'package:curso/container/materias.dart';

abstract class EventsMaterias {}

class InsertMateria extends EventsMaterias {
  final Materias materia;
  InsertMateria(this.materia);
}

class UpdateMateria extends EventsMaterias {
  final int pos;
  final Materias materia;

  UpdateMateria({this.pos, this.materia});
}

class DeleteMateria extends EventsMaterias {
  final Materias materia;
  final int pos;

  DeleteMateria({this.materia, this.pos});
}
