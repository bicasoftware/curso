import 'package:curso/database/db_provider.dart';
import 'package:curso/models/configuration.dart';

class ProviderConfiguration {
  static Future<bool> fetchBrightness() async {
    final db = await DBProvider.instance;
    final List<Map<String, dynamic>> result = await db.query(
      Configuration.tableName,
      columns: [Configuration.Cl_IsLight],
      limit: 1,
    );

    return (result[0][Configuration.Cl_IsLight] as int) == 1;
  }

  static Future putBrightness(bool brightness) async {
    final db = await getDatabase();
    await db.update(
      Configuration.tableName,
      {Configuration.Cl_IsLight: brightness == true ? 1 : 0},
    );
  }

  static Future putNotify(bool notify) async {
    final db = await getDatabase();
    await db.update(
      Configuration.tableName,
      {Configuration.Cl_Notify: notify == true ? 1 : 0},
    );
  }

  static Future<Configuration> fetchConfig() async {
    final db = await getDatabase();
    final result = await db.query(Configuration.tableName);

    return Configuration.fromMap(result[0]);
  }
}
