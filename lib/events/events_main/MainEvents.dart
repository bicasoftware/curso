abstract class MainEvents {}

class SetPosition extends MainEvents {
  final int pos;

  SetPosition(this.pos);
}
