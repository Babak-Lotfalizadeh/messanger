import 'package:messenger/enums/shared_preference_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  SharedPreferenceService._();

  static Future<void> setString(SharedPreferenceEnum key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key.toString(), value);
  }

  static Future<void> setBool(SharedPreferenceEnum key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key.toString(), value);
  }

  static Future<void> setInt(SharedPreferenceEnum key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key.toString(), value);
  }

  static Future<String?> getString(SharedPreferenceEnum key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key.toString());
  }

  static Future<bool?> getBoolean(SharedPreferenceEnum key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key.toString());
  }

  static Future<int?> getInt(SharedPreferenceEnum key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key.toString());
  }
}
