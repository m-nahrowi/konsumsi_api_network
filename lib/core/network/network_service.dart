import 'package:dio/dio.dart';
import '../config/api_config.dart';

class NetworkService {
  late Dio _dio;

  NetworkService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: ApiConfig.connectTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print("Request: ${options.method} ${options.path}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print("Response: ${response.statusCode} ${response.data}");
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        print("Error: ${e.message}");
        return handler.next(e);
      },
    ));
  }

  Future<Response?> get(String endpoint, {Map<String, dynamic>? queryParams}) async {
    try {
      Response response = await _dio.get(endpoint, queryParameters: queryParams);
      return response;
    } catch (e) {
      print("GET request error: $e");
      return null;
    }
  }

  Future<Response?> post(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      Response response = await _dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      print("POST request error: $e");
      return null;
    }
  }

  Future<Response?> put(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      Response response = await _dio.put(endpoint, data: data);
      return response;
    } catch (e) {
      print("PUT request error: $e");
      return null;
    }
  }

  Future<Response?> delete(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      Response response = await _dio.delete(endpoint, data: data);
      return response;
    } catch (e) {
      print("DELETE request error: $e");
      return null;
    }
  }
}
