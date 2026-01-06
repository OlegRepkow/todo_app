import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  static const String _authBoxName = 'auth_box';
  static const String _themeBoxName = 'theme_box';
  static const String _userIdKey = 'user_id';
  static const String _isDarkModeKey = 'is_dark_mode';
  static const String _themeJsonKey = 'theme_json';

  late Box _authBox;
  late Box _themeBox;

  Future<void> init() async {
    await Hive.initFlutter();
    _authBox = await Hive.openBox(_authBoxName);
    _themeBox = await Hive.openBox(_themeBoxName);
  }

  // Auth methods
  String? getUserId() {
    return _authBox.get(_userIdKey);
  }

  Future<void> saveUserId(String userId) async {
    await _authBox.put(_userIdKey, userId);
  }

  Future<void> deleteUserId() async {
    await _authBox.delete(_userIdKey);
  }

  Future<void> clearAll() async {
    await _authBox.clear();
    await _themeBox.clear();
  }

  // Theme methods
  bool? getIsDarkMode() {
    return _themeBox.get(_isDarkModeKey);
  }

  Future<void> saveIsDarkMode(bool isDarkMode) async {
    await _themeBox.put(_isDarkModeKey, isDarkMode);
  }

  Map<String, dynamic>? getThemeJson() {
    final value = _themeBox.get(_themeJsonKey);
    if (value == null) return null;
    // Конвертуємо Map<dynamic, dynamic> в Map<String, dynamic>
    return Map<String, dynamic>.from(value as Map);
  }

  Future<void> saveThemeJson(Map<String, dynamic> themeJson) async {
    await _themeBox.put(_themeJsonKey, themeJson);
  }

  Future<void> clearThemeCache() async {
    await _themeBox.delete(_themeJsonKey);
  }
}
