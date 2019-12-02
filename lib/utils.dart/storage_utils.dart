import 'package:curso/utils.dart/Strings.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageUtils {
  static Future<String> readToken() async {
    const st = FlutterSecureStorage();
    return st.read(key: Keys.tokenKey);
  }

  static Future putToken(String token) async {
    const st = FlutterSecureStorage();
    await st.write(key: Keys.tokenKey, value: token);
  }

  static Future putEmail(String email) async {
    const st = FlutterSecureStorage();
    await st.write(key: Keys.email, value: email);
  }

  static Future<void> putSignInfo(String email, String token) async {
    return Future.wait([
      putEmail(email),
      putToken(token),
    ]);
  }
}

/*extension SecStorageExt on FlutterSecureStorage {
  Future<String> getByKey(String key) async {
    return await read(key: Keys.tokenKey) ?? "";
  }

  Future<void> putByKey({String key, String value}) async {
    return write(key: Keys.email, value: value);
  }
}*/
