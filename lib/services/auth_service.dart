import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  static const String _userIdKey = 'user_id';

  final SharedPreferences _prefs;

  AuthService(this._prefs);

  bool get isAuthenticated => _prefs.containsKey(_userIdKey);
  String? get userId => _prefs.getString(_userIdKey);

  Future<void> login(String userId) async {
    await _prefs.setString(_userIdKey, userId);
    notifyListeners();
  }

  Future<void> logout() async {
    await _prefs.remove(_userIdKey);
    notifyListeners();
  }
}
