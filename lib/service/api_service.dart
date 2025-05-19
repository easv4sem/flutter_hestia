import 'package:dio/dio.dart';
import 'package:hestia/core/app_constants.dart';

class ApiService {
  final Dio _dio =
      Dio()
        ..options.headers = {'Content-Type': 'application/json'}
        ..options.baseUrl = AppConstants.apiBaseUrl;

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
