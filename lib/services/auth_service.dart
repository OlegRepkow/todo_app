import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier {
  static const String _userIdKey = 'user_id';

  // final SharedPreferences _prefs;

  AuthService(
      // this._prefs
      );

  bool get isAuthenticated => false;
  String? get userId => null;

  Future<void> login(String userId) async {
    // await _prefs.setString(_userIdKey, userId);
    notifyListeners();
  }

  Future<void> logout() async {
    // await _prefs.remove(_userIdKey);
    notifyListeners();
  }
}
