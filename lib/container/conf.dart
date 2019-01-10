import 'package:curso/utils.dart/AppBrightness.dart';

class Conf {
  final bool notify;
  final AppBrightness brightness;

  Conf({
    this.notify: false,
    this.brightness: AppBrightness.DARK,
  });

  Conf copyWith(bool notify) {
    return Conf(
      notify: notify ?? this.notify,
      brightness: brightness ?? this.brightness,
    );
  }
}
