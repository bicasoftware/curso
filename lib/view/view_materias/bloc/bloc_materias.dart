import 'package:curso/bloc/base_bloc.dart';
import 'package:curso/container/materias.dart';
import 'package:curso/providers/provider_materias.dart';
import 'package:rxdart/rxdart.dart';

class BlocMaterias implements BaseBloc {
  List<Materias> materias;

  final BehaviorSubject<List<Materias>> _subjectMaterias = BehaviorSubject<List<Materias>>();
  Stream<List<Materias>> get outMaterias => _subjectMaterias.stream;
  Sink<List<Materias>> get sinkMaterias => _subjectMaterias.sink;

  BlocMaterias({this.materias}) {
    _sinkMaterias();
  }

  @override
  void dispose() {
    _subjectMaterias.close();
  }

  void insertMateria({Materias materia}) {
    ProviderMaterias.insertMateria(materia)
        .then((Materias m) => materias.add(m))
        .whenComplete(_sinkMaterias);
  }

  void deleteMateria({Materias materia}) {
    ProviderMaterias.deleteMateria(materia.id)
        .then((a) => materias.remove(materia))
        .whenComplete(_sinkMaterias);
  }

  void updateMaterias({int pos, Materias materia}) {
    ProviderMaterias.updateMateria(materia)
        .then((Materias m) => materias[pos] = m)
        .whenComplete(_sinkMaterias);
  }

  void _sinkMaterias() => sinkMaterias.add(materias);
}
