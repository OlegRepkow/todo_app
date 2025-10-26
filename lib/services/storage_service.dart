import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  static const String _authBoxName = 'auth_box';
  static const String _userIdKey = 'user_id';

  late Box _authBox;

  Future<void> init() async {
    await Hive.initFlutter();
    _authBox = await Hive.openBox(_authBoxName);
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
  }
}

