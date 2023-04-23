import 'package:app_bin_mobile/src/features/account/login/presentation/widgets/login_form.dart';
import 'package:app_bin_mobile/src/features/account/login/presentation/widgets/login_header.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login-screen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: const SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LoginHeader(),
                LoginForm(),
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
