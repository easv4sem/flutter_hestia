import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hestia/auth/auth_service.dart';
import 'package:hestia/core/routes.dart';

class RegistrePage extends StatefulWidget {
  const RegistrePage({super.key});

  @override
  State<RegistrePage> createState() => _RegistrePage();
}

class _RegistrePage extends State<RegistrePage> {
  AuthService authService = AuthService();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordControllerConfirm =
      TextEditingController();

  void _register() async {
    if (passwordController.text != passwordControllerConfirm.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match.')));
      return;
    }

    if (usernameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        emailController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields.')));
      return;
    }

    if (usernameController.text.length < 3) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Username too short.')));
      return;
    }
    if (passwordController.text.length < 8) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Password too short.')));
      return;
    }
    if (passwordController.text.length > 20) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Password too long.')));
      return;
    }
    if (usernameController.text.length > 20) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Username too long.')));
      return;
    }

    if (emailController.text.length < 5 ||
        !emailController.text.contains('@') ||
        !emailController.text.contains('.')) {
      // Check if email is valid (basic check)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email too short. or not a valid email')),
      );
      return;
    }

    final success = await authService.register(
      usernameController.text,
      passwordController.text,
      emailController.text,
      firstNameController.text,
      lastNameController.text,
    );
    if (success.$1) {
      context.go(Routes.home.path);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(success.$2)));
    }
  }

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 2.0,
                children: [
                  const Text(
                    'Registre',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
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
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: passwordControllerConfirm,
                    decoration: InputDecoration(
                      labelText: 'Password Confirm',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),

                  ElevatedButton(
                    onPressed: _register,
                    child: const Text('Registre'),
                  ),

                  TextButton(
                    onPressed: () => context.go(Routes.login.path),
                    child: const Text('Login'),
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
