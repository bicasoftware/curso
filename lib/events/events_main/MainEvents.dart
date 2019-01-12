import 'package:curso/utils.dart/AppBrightness.dart';

abstract class MainEvents {}

class SetPosition extends MainEvents {
  final int pos;

  SetPosition(this.pos);
}

class SetBrightness extends MainEvents{
  final AppBrightness brightness;

  SetBrightness(this.brightness);
}

class SetNotify extends MainEvents{
  final bool notify;

  SetNotify(this.notify);
}
