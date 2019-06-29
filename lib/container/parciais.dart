import 'package:curso/container/faltas.dart';
import 'package:meta/meta.dart';
import 'package:curso/container/materias.dart';
import 'package:curso/container/notas.dart';
import 'package:curso/view/view_parciais/parcial_status.dart';
import 'package:curso/utils.dart/double_utils.dart';

class Parciais {
  List<ParciaisMaterias> materias;
  DateTime terminoPeriodo;

  Parciais({@required this.terminoPeriodo}) {
    materias = List<ParciaisMaterias>();
  }

  void clear() => materias.clear();

  void add({
    @required Materias materia,
    @required int numAulasSemestre,
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
        notas: notas,
        notaAprovacao: notaAprovacao,
        notaAtual: notaAtual,
        numAulasVagas: vagas,
        numFaltas: faltas,
        terminoPeriodo: terminoPeriodo,
        presObrig: presObrig,
      ),
    );
  }

  ParciaisMaterias _findMateria(int idMateria) =>
      materias.firstWhere((m) => m.materia.id == idMateria, orElse: () => null);

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
  Materias materia;
  int numAulasSemestre;
  int numAulasVagas;
  int numFaltas;
  List<Notas> notas;
  double notaAprovacao;
  double notaAtual;
  DateTime terminoPeriodo;
  int presObrig;

  ParciaisMaterias({
    @required this.materia,
    @required this.numAulasSemestre,
    @required this.numAulasVagas,
    @required this.numFaltas,
    @required this.notas,
    @required this.notaAprovacao,
    @required this.notaAtual,
    @required this.terminoPeriodo,
    @required this.presObrig,
  });

  //TODO - Considerar data da prova para efetuar calculo das notas

  ParciaisStatus get status {
    ///Se o período ainda não terminou
    if (DateTime.now().isAfter(terminoPeriodo)) {
      if (notas.length == 0) {
        return StatusFaltandoNotas();
      } else if (notaAtual == null) {
        return StatusFaltandoValoresNota();
      } else if (notaAtual < notaAprovacao) {
        return StatusReprovadoNotas();
      } else if (!statusFaltas(presObrig, numAulasSemestre, numFaltas)) {
        return StatusReprovadoFaltas();
      } else
        return StatusAprovado();
    } else {
      return StatusEmAndamento();
    }
  }

  void incFalta() => numFaltas += 1;

  void decFalta() => numFaltas -= 1;

  void incVagas() => numAulasVagas += 1;
  void decVagas() => numAulasVagas -= 1;

  void addNota(Notas nota, int numProvas) {
    notas.add(nota);
    notaAtual = calcMedia(notas);
  }

  void removeNota(Notas nota, int numProvas) {
    notas.removeWhere((n) => n.id == nota.id);
    notaAtual = calcMedia(notas);
  }
}
