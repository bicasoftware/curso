import 'package:curso/utils.dart/Formatting.dart';
import 'package:meta/meta.dart';

class ViewDateRangeResult {
  final int ordemAula;
  final DateTime inicio, termino;

  ViewDateRangeResult({
    @required this.ordemAula,
    @required this.inicio,
    @required this.termino,
  });

  @override
  String toString() {
    return "ordemAula: $ordemAula, inicio: ${Formatting.formatTime(inicio)}, termino: ${Formatting.formatTime(termino)}";
  }
}
