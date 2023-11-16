import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  setFavorite(String fruitName, bool isFav) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setBool(fruitName, isFav);
  }

  Future<bool?> getFavorite(String fruitName) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(fruitName);
  }
}
