import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hestia/auth/auth_service.dart';
import 'package:hestia/core/routes.dart';
import 'package:hestia/presentation/widgets/authentication_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthService authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isLoading = false;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    final success = await authService.login(
      usernameController.text,
      passwordController.text,
    );
    if (success.$1) {
      setState(() {
        isLoading = false;
      });
      context.go(Routes.home.path);
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(success.$2)));
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
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
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
                    const SizedBox(height: 32.0),
                    AuthenticationTextFormField(
                      icon: Icons.person,
                      label: "username",
                      textEditingController: usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16.0),
                    AuthenticationTextFormField(
                      icon: Icons.lock,
                      label: "password",
                      textEditingController: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),

                    isLoading
                        ? const CircularProgressIndicator(
                          color: Colors.deepOrange,
                          strokeWidth: 2.0,
                        )
                        : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            foregroundColor: Colors.white,
                          ),
                          onPressed: _login,
                          child: const Text('Login'),
                        ),
                    TextButton(
                      onPressed: forgotPassword,
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),

                    TextButton(
                      onPressed: () => context.go(Routes.registre.path),
                      child: const Text(
                        'Create Account',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
