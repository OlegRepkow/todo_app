import 'package:dio/dio.dart';
import '../api/todo_api.dart';
import 'auth_service.dart';
import 'auth_interceptor.dart';
import 'storage_service.dart';

class DIContainer {
  static DIContainer? _instance;
  static DIContainer get instance => _instance ??= DIContainer._();

  DIContainer._();

  late final StorageService _storage;
  late final AuthService _authService;
  late final Dio _dio;
  late final TodoApi _todoApi;

  Future<void> init() async {
    _storage = StorageService();
    await _storage.init();
    
    _authService = AuthService(_storage);

    _dio = Dio();
    _dio.interceptors.add(AuthInterceptor(_authService));

    _todoApi = TodoApi(_dio);
  }

  StorageService get storage => _storage;
  AuthService get authService => _authService;
  TodoApi get todoApi => _todoApi;
}
