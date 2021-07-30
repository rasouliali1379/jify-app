import 'package:get_storage/get_storage.dart';

class Storage {
  static final _storage = GetStorage();

  static Future<void> write(String key, value) async {
    await _storage.write(key, value);
  }

  static dynamic read(String key) {
    return _storage.read(key);
  }

  static bool exists(String key) {
    return _storage.hasData(key);
  }

  static Future<void> remove(String key) async {
    return await _storage.remove(key);
  }

  static Future<void> deleteStorage() async {
    return await _storage.erase();
  }
}
