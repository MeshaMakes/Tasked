import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  SharedPreferences pref;
  static void saveData(String key, dynamic val) async {
    final pref = await SharedPreferences.getInstance();
    if(val is int) {
      pref.setInt(key, val);
    } else if(val is String) {
      pref.setString(key, val);
      print("str");
    } else if(val is bool) {
      pref.setBool(key, val);
    } else {
      print("Invalid Type");
    }
  }

  static Future<List<String>> readData(String key)  async {
    final pref = await SharedPreferences.getInstance();
    dynamic obj = pref.get(key);
    final value =  pref.getStringList(key);
    return value;
  }

  static Future<bool> deleteData(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.remove(key);
  }
}