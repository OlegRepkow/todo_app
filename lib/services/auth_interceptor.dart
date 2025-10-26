import 'package:dio/dio.dart';
import 'auth_service.dart';

class AuthInterceptor extends Interceptor {
  final AuthService authService;

  AuthInterceptor(this.authService);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Якщо користувач авторизований, додаємо X-User-ID header
    // if (authService.isAuthenticated) {
    if (true) {
      options.headers['X-User-ID'] =
          '0ffe1abd1a08215353c233d6e009613e95eec4253832a761af28ff37ac5a150c';
      // options.headers['X-User-ID'] = authService.userId;
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Можна додати обробку помилок (наприклад, 401)
    super.onError(err, handler);
  }
}
