import 'package:bloc/bloc.dart';
import 'package:curso/container/materias.dart';
import 'package:curso/events/EventsMaterias.dart';
import 'package:curso/providers/provider_materias.dart';

class BlocMaterias extends Bloc<EventsMaterias, List<Materias>> {

  final List<Materias> materias;

  BlocMaterias({this.materias});

  @override
  List<Materias> get initialState => materias;

  @override
  Stream<List<Materias>> mapEventToState(List<Materias> currentState, EventsMaterias event) async* {
    if (event is InsertMateria) {
      final m = await ProviderMaterias.insertMateria(event.materia);
      final List<Materias> materias = []..addAll(currentState)..add(m);
      print(materias.length);
      yield materias;
    } else if (event is UpdateMateria) {
      final m = await ProviderMaterias.updateMateria(event.materia);
      final List<Materias> materias = []..addAll(currentState)..[event.pos] = m;      
      yield materias;
    } else if (event is DeleteMateria) {
      await ProviderMaterias.deleteMateria(event.materia.id);
      yield []..addAll(currentState)..remove(event.materia);      
    }
  }
}
