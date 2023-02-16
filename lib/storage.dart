
import 'package:get_storage/get_storage.dart';

class LocalStorage {
  static final storage = GetStorage();

  static Future<void> setValue(String key, dynamic value) async {
    await storage.write(key, value);
  }

  static dynamic getValue(String key) {
    return storage.read(key);
  }
}