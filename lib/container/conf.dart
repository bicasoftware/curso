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
    return """create table conf(
      $NOTIFY INTEGER NOT NULL DEFAULT 0,
      $BRIGHTNESS INTEGER NOT NULL DEFAULT 0,
    );""";
  }

  @override
  Map toMap() {
    Map<String, dynamic> m = {
      NOTIFY: notify,
      BRIGHTNESS: brightness,
    };

    return m;
  }

  static Conf fromMap(Map m) {
    return Conf(
      brightness: m[BRIGHTNESS],
      notify: m[NOTIFY],
    );
  }

  static String tableName = "conf";
}
