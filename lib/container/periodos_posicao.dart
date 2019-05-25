import 'package:curso/container/periodos.dart';

///classe que contém a os períodos disponíveis e o index do periodo atual

class PeriodosPosicao {
  final List<Periodos> periodos;
  final int currentPeriodoPos;

  PeriodosPosicao({this.periodos, this.currentPeriodoPos});

  int get currentId => periodos[currentPeriodoPos].id;

  @override
  String toString(){
    return "periodos: ${periodos.length}, currentPeriodoPos: $currentPeriodoPos";
  }
}