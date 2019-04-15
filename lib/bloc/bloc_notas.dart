import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:curso/container/cronograma.dart';
import 'package:rxdart/rxdart.dart';

class BlocNotas implements BlocBase {

  List<CronogramaNotas> cronogramas;

  final _subCrono = BehaviorSubject<List<CronogramaNotas>>();
  get outCrono => _subCrono.stream;
  get inCrono => _subCrono.sink;

  /*
  Abril

  	04/04/2019
	
	    |---| Matematica 1ª aula, 2ª aula
	    |---| Portugues  1ª aula, 2ª aula

  Maio
  
    01/05/2019
      |---| Física  1ª Aula, 2ª aula
      |---| Química 2ª Aula, 3ª aula
  */

  @override
  void dispose() {
    _subCrono.close();
  }

}