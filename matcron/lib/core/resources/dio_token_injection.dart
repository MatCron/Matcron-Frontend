import 'package:dio/dio.dart';
import 'package:matcron/core/resources/authorization.dart';

final dio = Dio();
final authorizationService = AuthorizationService();

void setupDio() {
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      final token = await authorizationService.getToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      return handler.next(options); // Continue the request
    },
    onError: (error, handler) {
      // Handle errors if needed
      return handler.next(error);
    },
  ));
}
