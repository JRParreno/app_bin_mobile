import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future readLocalStorage(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static storeLocalStorage(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future deleteLocalStorage(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
