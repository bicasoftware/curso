import 'package:curso/container/periodos.dart';

class MainState {
  final int navPos;
  final List<Periodos> periodos;

  MainState({
    this.navPos,
    this.periodos,
  });

  MainState copyWith({int navPos, List<Periodos> periodos}) {
    return MainState(
      navPos: navPos ?? this.navPos,
      periodos: periodos ?? this.periodos,
    );
  }
}
