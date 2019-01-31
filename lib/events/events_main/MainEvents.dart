import 'package:curso/container/materias.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/utils.dart/AppBrightness.dart';

abstract class MainEvents {}

class SetPosition extends MainEvents {
  final int pos;

  SetPosition(this.pos);
}

class SetBrightness extends MainEvents {
  final AppBrightness brightness;

  SetBrightness(this.brightness);
}

class SetNotify extends MainEvents {
  final bool notify;

  SetNotify(this.notify);
}

class UpdatePeriodo extends MainEvents {
  final Periodos periodo;
  UpdatePeriodo(this.periodo);
}

class InsertPeriodo extends MainEvents {
  final Periodos periodo;

  InsertPeriodo(this.periodo);
}

class DeletePeriodo extends MainEvents {
  final int idPeriodo;

  DeletePeriodo(this.idPeriodo);
}

class RefreshMaterias extends MainEvents {
  final int idPeriodo;
  final List<Materias> materias;

  RefreshMaterias({
    this.idPeriodo,
    this.materias,
  });
}
