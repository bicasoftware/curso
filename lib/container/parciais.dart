import 'package:curso/models/faltas.dart';
import 'package:curso/models/materias.dart';
import 'package:curso/models/notas.dart';
import 'package:curso/utils.dart/calcs.dart';
import 'package:curso/utils.dart/double_utils.dart';
import 'package:curso/view/view_parciais/parcial_status.dart';
import 'package:meta/meta.dart';

class Parciais {
  Parciais({@required this.terminoPeriodo, @required this.inicioPeriodo}) {
    materias = <ParciaisMaterias>[];
  }

  List<ParciaisMaterias> materias;
  DateTime terminoPeriodo, inicioPeriodo;

  void clear() => materias.clear();

  void add({
    @required Materias materia,
    @required int numAulasSemestre,
    @required int numAulasUntilNow,
    @required List<Notas> notas,
    @required double notaAprovacao,
    @required double notaAtual,
    @required int faltas,
    @required int vagas,
    @required int presObrig,
  }) {
    materias.add(
      ParciaisMaterias(
        materia: materia,
        numAulasSemestre: numAulasSemestre,
        numAulasUntilNow: numAulasUntilNow,
        notas: notas,
        notaAprovacao: notaAprovacao,
        notaAtual: notaAtual,
        numAulasVagas: vagas,
        numFaltas: faltas,
        terminoPeriodo: terminoPeriodo,
        inicioPeriodo: inicioPeriodo,
        presObrig: presObrig,
      ),
    );
  }

  ParciaisMaterias _findMateria(int idMateria) {
    return materias.firstWhere(
      (m) => m.materia.id == idMateria,
      orElse: () => null,
    );
  }

  void addFalta(Faltas falta) {
    if (falta.tipo == 0) {
      _findMateria(falta.idMateria)?.incFalta();
    } else if (falta.tipo == 1) {
      _findMateria(falta.idMateria)?.incVagas();
    }
  }

  void removeFalta({int idMateria, int tipoFalta}) {
    if (tipoFalta == 0) {
      _findMateria(idMateria)?.decFalta();
    } else if (tipoFalta == 1) {
      _findMateria(idMateria)?.decVagas();
    }
  }

  void addNota(Notas nota, int numProvas) {
    _findMateria(nota.idMateria)?.addNota(nota, numProvas);
  }

  void removeNota(Notas nota, int numProvas) {
    _findMateria(nota.idMateria)?.removeNota(nota, numProvas);
  }
}

class ParciaisMaterias {
  ParciaisMaterias({
    @required this.materia,
    @required this.numAulasSemestre,
    @required this.numAulasUntilNow,
    @required this.numAulasVagas,
    @required this.numFaltas,
    @required this.notas,
    @required this.notaAprovacao,
    @required this.notaAtual,
    @required this.terminoPeriodo,
    @required this.inicioPeriodo,
    @required this.presObrig,
  });

  Materias materia;
  int numAulasVagas, numFaltas, numAulasSemestre, numAulasUntilNow;
  List<Notas> notas;
  double notaAprovacao;
  double notaAtual;
  DateTime terminoPeriodo, inicioPeriodo;
  int presObrig;

  ParciaisStatus get status {
    if (DateTime.now().isAfter(terminoPeriodo)) {
      if (notas.isEmpty) {
        return StatusFaltandoNotas();
      } else if (notaAtual == null) {
        return StatusFaltandoValoresNota();
      } else if (notaAtual < notaAprovacao) {
        return StatusReprovadoNotas();
      } else if (!faltasEmDia(presObrig, numAulasSemestre, numFaltas)) {
        return StatusReprovadoFaltas();
      } else {
        return StatusAprovado();
      }
    } else {
      return StatusEmAndamento();
    }
  }

  // double get percentFaltas => calcPorcentagemAulas(numAulasSemestre, numFaltas);
  double get percentFaltas => (numFaltas / numAulasSemestre) * 100;

  // double get percentVagas => calcPorcentagemAulas(numAulasSemestre, numAulasVagas);
  double get percentVagas => (numFaltas / numAulasSemestre) * 100;

  // double get percentPresenca => totalAulasRestantesSemestre - percentFaltas - percentVagas;
  double get percentPresenca =>
      ((numAulasUntilNow / numAulasSemestre) * 100) - percentFaltas - percentVagas;

  int get totalAulasRestantesSemestre {
    return totalAulasRestantes(
      inicio: inicioPeriodo,
      termino: terminoPeriodo,
      m: materia,
    );
  }

  void incFalta() => numFaltas += 1;

  void decFalta() => numFaltas -= 1;

  void incVagas() => numAulasVagas += 1;

  void decVagas() => numAulasVagas -= 1;

  void addNota(Notas nota, int numProvas) {
    notas.add(nota);
    _recalcMedia();
    /* notaAtual = calcMedia(notas
        .where((n) => n.nota != null && n.data.isBefore(DateTime.now()))
        .map((n) => n.nota)
        .toList()); */
  }

  void removeNota(Notas nota, int numProvas) {
    notas.removeWhere((n) => n.id == nota.id);
  }

  void _recalcMedia() {
    notaAtual = calcMedia(notas
        .where((n) => n.nota != null && n.data.isBefore(DateTime.now()))
        .map((n) => n.nota)
        .toList());
  }
}
