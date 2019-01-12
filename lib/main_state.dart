import 'package:curso/container/periodos.dart';
import 'package:curso/utils.dart/AppBrightness.dart';

class MainState {
  final int navPos;
  final AppBrightness brightness;
  final bool notify;
  final List<Periodos> periodos;

  MainState({
    this.navPos,
    this.periodos,
    this.brightness,
    this.notify,
  });

  MainState copyWith({int navPos, AppBrightness brightness, bool notify, List<Periodos> periodos}) {
    return MainState(
      navPos: navPos ?? this.navPos,
      brightness: brightness ?? this.brightness,
      notify: notify ?? this.notify,
      periodos: periodos ?? this.periodos,
    );
  }
}
