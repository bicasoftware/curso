import 'package:curso/database/base_table.dart';
import 'package:flutter/foundation.dart';

@immutable
class Configuration implements BaseTable {
  const Configuration({
    @required this.isLight,
    @required this.notify,
    @required this.id,
  });

  factory Configuration.fromMap(Map<String, dynamic> map) {
    return Configuration(
      isLight: (map[Cl_IsLight] as int) == 1,
      notify: (map[Cl_Notify] as int) == 1,
      id: map[Cl_Id] ?? 1,
    );
  }

  final bool isLight, notify;
  final int id;

  static String get tableName => "configuration";

  ///Fields
  static const Cl_Id = "_ID";
  static const Cl_IsLight = "IS_LIGHT";
  static const Cl_Notify = "NOTIFY";

  Configuration copyWith({bool isLight, bool notify, int id}) {
    return Configuration(
      isLight: isLight ?? this.isLight,
      notify: notify ?? this.notify,
      id: id ?? this.id,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      Cl_Id: id,
      Cl_IsLight: isLight ? 1 : 0,
      Cl_Notify: notify ? 1 : 0,
    };
  }

  static String get createSQL => """
      CREATE TABLE $tableName(
        $Cl_Id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        $Cl_IsLight INTEGER NOT NULL,
        $Cl_Notify INTEGER NOT NULL      
      );
    """;
}
