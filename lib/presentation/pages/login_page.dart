import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hestia/auth/auth_service.dart';
import 'package:hestia/core/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthService authService = AuthService();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isLoading = false;

  void _login() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 5));

    final success = await authService.login(
      usernameController.text,
      passwordController.text,
    );
    if (success) {
      setState(() {
        isLoading = false;
      });
      context.go(Routes.home.path);
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed. Please try again.')),
      );
    }
  }

  void forgotPassword() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.deepOrange,
              child: const Center(
                child: Text(
                  'Welcome to Hestia!',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
          ),
          isLoading
              ? SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: Center(child: CircularProgressIndicator()),
              )
              : SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 2.0,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16.0),

                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                      ),

                      ElevatedButton(
                        onPressed: _login,
                        child: const Text('Login'),
                      ),

                      TextButton(
                        onPressed: forgotPassword,
                        child: const Text('Forgot Password?'),
                      ),

                      TextButton(
                        onPressed: () => context.go(Routes.registre.path),
                        child: const Text('Create Account'),
                      ),
                    ],
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
