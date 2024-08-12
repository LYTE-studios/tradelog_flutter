import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/features/authentication/shared/auth_page.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static const String route = '/$location';
  static const String location = 'register';

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      child: Container(),
    );
  }
}
