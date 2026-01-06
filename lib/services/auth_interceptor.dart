import 'package:dio/dio.dart';
import 'auth_service.dart';

class AuthInterceptor extends Interceptor {
  final AuthService authService;

  AuthInterceptor(this.authService);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Якщо користувач авторизований, додаємо X-User-ID header
    if (authService.isAuthenticated) {
      options.headers['X-User-ID'] =
          // 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3';
          options.headers['X-User-ID'] = authService.userId;
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Можна додати обробку помилок (наприклад, 401)
    super.onError(err, handler);
  }
}
