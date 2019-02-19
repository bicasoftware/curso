import 'package:curso/container/aulas.dart';
import 'package:curso/container/conf.dart';
import 'package:curso/container/materias.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/utils.dart/AppBrightness.dart';

class StateMain {
  List<Periodos> periodos;
  Conf conf;
  int pos;

  StateMain({this.periodos, this.conf, this.pos});

  setBrightness(AppBrightness br) => conf.brightness = br;

  setNotify(bool notify) => conf.notify = notify;

  removePeriodoById(int idPeriodo) {
    periodos.remove(periodos.firstWhere((it) => it.id == idPeriodo));
  }

  addPeriodo(Periodos p) {
    periodos.add(p);
  }

  updatePeriodo(Periodos p) {
    int index = periodos.indexWhere((it) => it.id == p.id);
    periodos[index] = p;
  }

  refreshMaterias(int idPeriodo, List<Materias> materias) {
    periodos.firstWhere((it) => it.id == idPeriodo).materias = materias;
  }

  insertAula(int idPeriodo, int idMateria, Aulas aula) {
    periodos
        .firstWhere((it) => it.id == idPeriodo)
        .materias
        .firstWhere((it) => it.id == idMateria)
        .aulas
        .add(aula);
  }

  deleteAula(int idPeriodo, int idAula) {
    periodos
        .firstWhere((it) => it.id == idPeriodo)
        .materias
        .forEach((m) => m.aulas.removeWhere((it) => it.id == idAula));
  }

  deleteAulaByOrdemDia(int idPeriodo, int weekDay, int ordem) {
    periodos
        .firstWhere((it) => it.id == idPeriodo)
        .materias
        .forEach((m) => m.aulas.removeWhere((a) => a.weekDay == weekDay && a.ordem == ordem));
  }
}
