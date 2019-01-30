import 'package:curso/utils.dart/AppBrightness.dart';
import 'package:curso/database/base_table.dart';

class Conf implements BaseTable {
  final bool notify;
  final AppBrightness brightness;

  Conf({
    this.notify: false,
    this.brightness: AppBrightness.DARK,
  });

  static const String NOTIFY = "notify";
  static const String BRIGHTNESS = "brightness";

  Conf copyWith(bool notify) {
    return Conf(
      notify: notify ?? this.notify,
      brightness: brightness ?? this.brightness,
    );
  }

  static List<String> provideColumns = [
    NOTIFY,
    BRIGHTNESS,
  ];

  static String getCreateSQL() {
    return """create table $tableName(
      $NOTIFY INTEGER NOT NULL DEFAULT 0,
      $BRIGHTNESS INTEGER NOT NULL DEFAULT 0
    );""";
  }

  @override
  Map toMap() {
    Map<String, dynamic> m = {
      NOTIFY: notify,
      BRIGHTNESS: brightness == AppBrightness.DARK ? 0 : 1,
    };

    return m;
  }

  static Conf fromMap(Map m) {
    return Conf(
      brightness: m[BRIGHTNESS] == 0 ? AppBrightness.DARK : AppBrightness.LIGHT,
      notify: m[NOTIFY] == 1 ? true : false,
    );
  }

  static String tableName = "conf";

  @override
  String toString(){
    return "$notify $brightness";
  }
}
