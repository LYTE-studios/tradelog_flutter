import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tradelog_flutter/secrets.dart';

class ApiService {
  final String baseUrl;

  final bool authenticated;

  final Dio dio;

  final FlutterSecureStorage storage;

  ApiService({
    required this.baseUrl,
    this.authenticated = true,
  })  : storage = const FlutterSecureStorage(),
        dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 120),
            receiveTimeout: const Duration(seconds: 120),
            sendTimeout: const Duration(seconds: 120),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            validateStatus: (int? status) {
              switch (status) {
                case 201:
                case 200:
                  return true;
                case null:
                default:
                  return false;
              }
            },
          ),
        ) {
    if (authenticated) {
      _setupInterceptors();
    }
  }

  Future<bool> isAuthenticated() async {
    final refreshToken = await storage.read(key: 'refresh_token');

    return refreshToken != null;
  }

  void _setupInterceptors() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await storage.read(key: 'access_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401) {
          final refreshed = await _refreshToken();
          if (refreshed) {
            return handler.resolve(await _retry(error.requestOptions));
          }
        }
        return handler.next(error);
      },
    ));
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final token = await storage.read(key: 'access_token');
    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        'Authorization': 'Bearer $token',
      },
    );
    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      options: options,
    );
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await storage.read(key: 'refresh_token');
      if (refreshToken == null) return false;

      String url = dio.options.baseUrl;

      dio.options.baseUrl = apiUrl;

      final response = await dio.post('users/token/refresh/', data: {
        'refresh': refreshToken,
      });

      dio.options.baseUrl = url;

      if (response.statusCode == 200) {
        await setTokens(response.data['access'], response.data['refresh']);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> setTokens(String accessToken, String refreshToken) async {
    await storage.write(key: 'access_token', value: accessToken);
    await storage.write(key: 'refresh_token', value: refreshToken);
  }

  Future<void> clearTokens() async {
    await storage.delete(key: 'access_token');
    await storage.delete(key: 'refresh_token');
  }

  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.get(
      endpoint,
      queryParameters: queryParameters,
    );
  }

  Future<Response> delete(
    String endpoint,
  ) async {
    return await dio.delete(
      endpoint,
    );
  }

  Future<Response> post(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    return await dio.post(
      endpoint,
      data: body,
    );
  }
}
