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

  static setLanguage(String key, String value) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<String?> getLanguage(String key) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
