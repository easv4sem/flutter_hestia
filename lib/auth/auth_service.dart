import 'package:dio/dio.dart';
import 'package:dio/browser.dart';
import 'package:hestia/core/app_constants.dart'; // Required for web support

class AuthService {
  final Dio _dio =
      Dio()
        ..options.headers = {'Content-Type': 'application/json'}
        ..options.baseUrl = AppConstants.apiBaseUrl;

  AuthService() {
    // Enable cookies on web
    if (_dio.httpClientAdapter is BrowserHttpClientAdapter) {
      (_dio.httpClientAdapter as BrowserHttpClientAdapter).withCredentials =
          true;
    }
  }

  Future<bool> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/user/login',
        data: {'username': username, 'password': password},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  Future<(bool, String)> register(
    String username,
    String password,
    String email,
    String firstname,
    String lastName,
  ) async {
    try {
      final response = await _dio.post(
        '/user/register',
        data: {
          'username': username,
          'password': password,
          'email': email,
          'firstname': firstname,
          'lastname': lastName,
        },
      );

      if (response.statusCode == 201) {
        return (true, "Successfully registered");
      } else {
        return (false, "Unknown error");
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        return (false, "Username or email already exists");
      } else {
        print("Error: $e");
      }
      return (false, "Unknown error");
    }
  }

  Future<bool> logout() async {
    try {
      final response = await _dio.post('/user/logout');

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Logout error: $e');
      return false;
    }
  }
}
