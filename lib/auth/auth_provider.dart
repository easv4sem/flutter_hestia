import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This class manages the authentication state of the application.
// It uses the ChangeNotifier pattern to notify listeners about changes in the authentication status.
// The authentication status is stored in SharedPreferences, allowing the app to remember the user's login state across sessions.
// The class provides methods to load the login status, set the login status, and save the login status to SharedPreferences.
class AuthState extends ChangeNotifier {
  static final AuthState _instance = AuthState._internal();

  AuthState._internal();

  static AuthState get instance => _instance;

  bool _loggedIn = false;

  bool get isLoggedIn => _loggedIn;

  Future<void> loadStatus() async {
    _loggedIn = await _loadLoginStatus();
    notifyListeners();
  }

  void setLoggedIn(bool value) {
    _loggedIn = value;
    _saveLoginStatus(value);
    notifyListeners();
  }

  Future<void> _saveLoginStatus(bool loggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', loggedIn);
  }

  Future<bool> _loadLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('loggedIn') ?? false;
  }
}
