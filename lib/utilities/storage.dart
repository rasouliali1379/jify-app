import 'package:get_storage/get_storage.dart';

final _storage = GetStorage();

Future<void> storageWrite(String key, dynamic value) async {
  await _storage.write(key, value);
}

dynamic storageRead(String key) {
  return _storage.read(key);
}

bool storageExists(String key) {
  return _storage.hasData(key);
}

Future<void> storageRemove(String key) async {
  await _storage.remove(key);
}

Future<void> storageDelete() async {
  await _storage.erase();
}
