import 'package:curso/container/calendario.dart';
import 'package:meta/meta.dart';

class CalendarioStripContainer {
  final DateTime selectedDate;
  final double initialOffset;
  final CalendarioDTO calendario;

  CalendarioStripContainer({
    @required this.selectedDate,
    @required this.initialOffset,
    @required this.calendario,
  });
}
