import 'package:flutter/material.dart';

class AuthenticationTextFormField extends StatelessWidget {
  const AuthenticationTextFormField({
    required this.icon,
    required this.label,
    required this.textEditingController,
    this.obscureText,
    this.validator,
    super.key,
  });

  final IconData icon;
  final String label;
  final TextEditingController textEditingController;
  final bool? obscureText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: textEditingController,
      obscureText: obscureText ?? label.toLowerCase().contains('password'),
      validator: validator,
      decoration: InputDecoration(
        floatingLabelStyle: theme.textTheme.titleLarge,
        icon: Icon(icon, color: Colors.black),
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
