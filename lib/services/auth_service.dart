import 'package:flutter/foundation.dart';
import 'storage_service.dart';

class AuthService extends ChangeNotifier {
  final StorageService _storage;

  AuthService(this._storage);

  bool get isAuthenticated => userId != null && userId!.isNotEmpty;
  
  String? get userId => _storage.getUserId();

  Future<void> login(String userId) async {
    await _storage.saveUserId(userId);
    notifyListeners();
  }

  Future<void> logout() async {
    await _storage.deleteUserId();
    notifyListeners();
  }
}
