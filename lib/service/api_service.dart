import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart'; // <- Tilføj dette for kIsWeb
import 'package:hestia/core/app_constants.dart';

class ApiService {
  final Dio _dio =
      Dio()
        ..options.headers = {'Content-Type': 'application/json'}
        ..options.baseUrl = AppConstants.apiBaseUrl;

  final CookieJar _cookieJar = CookieJar();

  ApiService() {
    // Tilføj kun CookieManager hvis vi ikke er på Web
    if (!kIsWeb) {
      _dio.interceptors.add(CookieManager(_cookieJar));
    } else {
      // Hvis du har brug for at sætte withCredentials på Web:
      _dio.options.extra = {'withCredentials': true};
    }
  }

  Future<Response> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to load data: ${e.message}');
    }
  }

  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to post data: ${e.message}');
    }
  }

  Future<Response> put(String endpoint, Map<String, dynamic> data) async {
    try {
      print("PUT request to $endpoint with data: $data");
      final response = await _dio.put(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to update data: ${e.message}');
    }
  }

  Future<Response> delete(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to delete data: ${e.message}');
    }
  }
}