import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hestia/auth/auth_service.dart';
import 'package:hestia/core/routes.dart';
import 'package:hestia/presentation/widgets/authentication_text_form_field.dart';

class RegistrePage extends StatefulWidget {
  const RegistrePage({super.key});

  @override
  State<RegistrePage> createState() => _RegistrePage();
}

class _RegistrePage extends State<RegistrePage> {
  final AuthService authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordControllerConfirm = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    if (passwordController.text != passwordControllerConfirm.text) {
      _showSnackBar('Passwords do not match.');
      return;
    }

    setState(() => _loading = true);
    final success = await authService.register(
      usernameController.text,
      passwordController.text,
      emailController.text,
      firstNameController.text,
      lastNameController.text,
    );
    setState(() => _loading = false);

    if (success.$1) {
      context.go(Routes.home.path);
    } else {
      _showSnackBar(success.$2);
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
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Register',
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 32.0),
                        AuthenticationTextFormField(
                          icon: Icons.person,
                          label: "Username",
                          textEditingController: usernameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Username required';
                            if (value.length < 3) return 'Username too short';
                            if (value.length > 20) return 'Username too long';
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        AuthenticationTextFormField(
                          icon: Icons.email,
                          label: "Email",
                          textEditingController: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Email required';
                            if (!value.contains('@') || !value.contains('.')) return 'Invalid email';
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        AuthenticationTextFormField(
                          icon: Icons.person,
                          label: "First Name",
                          textEditingController: firstNameController,
                        ),
                        const SizedBox(height: 16.0),
                        AuthenticationTextFormField(
                          icon: Icons.person,
                          label: "Last Name",
                          textEditingController: lastNameController,
                        ),
                        const SizedBox(height: 16.0),
                        AuthenticationTextFormField(
                          icon: Icons.lock,
                          label: "Password",
                          textEditingController: passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Password required';
                            if (value.length < 8) return 'Password too short';
                            if (value.length > 20) return 'Password too long';
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        AuthenticationTextFormField(
                          icon: Icons.lock,
                          label: "Confirm Password",
                          textEditingController: passwordControllerConfirm,
                          obscureText: true,
                        ),
                        const SizedBox(height: 24.0),
                        _loading
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
                                onPressed: _register,
                                child: const Text('Register'),
                              ),
                        const SizedBox(height: 8.0),
                        TextButton(
                          onPressed: () => context.go(Routes.login.path),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          child: const Text('Already have an account? Login'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
