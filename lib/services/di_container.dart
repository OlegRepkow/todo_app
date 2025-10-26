import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/todo_api.dart';
import 'auth_service.dart';
import 'auth_interceptor.dart';

class DIContainer {
  static DIContainer? _instance;
  static DIContainer get instance => _instance ??= DIContainer._();
  
  DIContainer._();

  late final SharedPreferences _prefs;
  late final AuthService _authService;
  late final Dio _dio;
  late final TodoApi _todoApi;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _authService = AuthService(_prefs);
    
    _dio = Dio();
    _dio.interceptors.add(AuthInterceptor(_authService));
    
    _todoApi = TodoApi(_dio);
  }

  AuthService get authService => _authService;
  TodoApi get todoApi => _todoApi;
}
