import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final prefs = SharedPreferences;
  static save(String key, bool value) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<bool?> get(String key) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }
}
