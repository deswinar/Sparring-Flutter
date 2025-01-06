import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient(String baseUrl, {String? accessToken})
      : dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(milliseconds: 5000),
          receiveTimeout: const Duration(milliseconds: 3000),
          headers: {'Content-Type': 'application/json'},
        )) {
    if (accessToken != null) {
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] = 'Bearer $accessToken';
          return handler.next(options);
        },
      ));
    }
  }

  /// GET method
  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    return await dio.get(endpoint, queryParameters: queryParams);
  }

  Future<Response> post(String endpoint, Map<String, dynamic> body) async {
    return await dio.post(endpoint, data: body);
  }
}
