import 'package:curso/utils.dart/date_utils.dart';
import 'package:meta/meta.dart';

class ViewHorarioAulasResult {
  final int ordemAula;
  final DateTime inicio, termino;

  ViewHorarioAulasResult({
    @required this.ordemAula,
    @required this.inicio,
    @required this.termino,
  });

  @override
  String toString() {
    return "ordemAula: $ordemAula, inicio: ${formatTime(inicio)}, termino: ${formatTime(termino)}";
  }
}
