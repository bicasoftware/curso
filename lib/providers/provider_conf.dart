import 'dart:async';
import 'package:curso/container/conf.dart';
import 'package:curso/database/db_provider.dart';
import 'package:curso/utils.dart/AppBrightness.dart';

class ProviderConf {
  static Future<Conf> fetchConf() async {
    final db = await DBProvider.instance;
    final r = await db.query(Conf.tableName);
    return r.map((c) => Conf.fromMap(c)).first;
  }

  static Future initialize() async {
    final db = await DBProvider.instance;
    db.transaction((tr) {
      tr.insert(
        Conf.tableName,
        Conf(brightness: AppBrightness.DARK, notify: true).toMap(),
      );
    });
  }
}
