import 'package:dio/dio.dart';
import 'package:dio/browser.dart';
import 'package:hestia/core/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Required for web support

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

  Future<(bool, String)> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/user/login',
        data: {'username': username, 'password': password},
      );

      if (response.statusCode == 200) {
        // Save the login status in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('loggedIn', true);

        return (true, "Successfully logged in");
      } else {
        return (false, "Unknown error");
      }
    } on DioException catch (e) {
     if (e.response?.statusCode == 404) {
        return (false, "Username or password is wrong");
      } 
      return (false, "Unknown error");
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
        
        // Save the login status in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('loggedIn', true);
        
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
        // Clear the login status from SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('loggedIn', false);
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
