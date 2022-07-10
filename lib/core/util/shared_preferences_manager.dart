import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static late SharedPreferences _sharedPreferences;

  static const keyIsLogin = 'keyIsLogin';
  static const keyProfilePicture = 'keyProfilePicture';
  static const keyDisplayName = 'keyDisplayName';
  static const keyEmail = 'keyEmail';

  SharedPreferencesManager();

  factory SharedPreferencesManager.getInstance(SharedPreferences sharedPreferences) {
    _sharedPreferences = sharedPreferences;
    return SharedPreferencesManager();
  }

  Future<bool> putBool(String key, bool value) => _sharedPreferences.setBool(key, value);

  bool? getBool(String key, {bool defaultValue = false}) =>
      _sharedPreferences.containsKey(key) ? _sharedPreferences.getBool(key) : defaultValue;

  Future<bool> putDouble(String key, double value) => _sharedPreferences.setDouble(key, value);

  double? getDouble(String key, {double defaultValue = 0.0}) =>
      _sharedPreferences.containsKey(key) ? _sharedPreferences.getDouble(key) : defaultValue;

  Future<bool> putInt(String key, int value) => _sharedPreferences.setInt(key, value);

  int? getInt(String key, {int defaultValue = 0}) =>
      _sharedPreferences.containsKey(key) ? _sharedPreferences.getInt(key) : defaultValue;

  Future<bool> putString(String key, String value) => _sharedPreferences.setString(key, value);

  String? getString(String key, {String defaultValue = ''}) =>
      _sharedPreferences.containsKey(key) ? _sharedPreferences.getString(key) : defaultValue;

  Future<bool> putStringList(String key, List<String> value) => _sharedPreferences.setStringList(key, value);

  List<String>? getStringList(String key) =>
      _sharedPreferences.containsKey(key) ? _sharedPreferences.getStringList(key) : null;

  bool isKeyExists(String key) => _sharedPreferences.containsKey(key);

  Future<bool> clearKey(String key) => _sharedPreferences.remove(key);

  Future<bool> clearAll() => _sharedPreferences.clear();
}
