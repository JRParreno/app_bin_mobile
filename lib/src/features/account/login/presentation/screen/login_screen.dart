import 'package:app_bin_mobile/src/features/account/login/presentation/widgets/login_form.dart';
import 'package:app_bin_mobile/src/features/account/login/presentation/widgets/login_header.dart';
import 'package:app_bin_mobile/src/features/apps/presentation/screen/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login-screen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  bool _passwordVisible = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void handleLogin() {
    if (loginFormKey.currentState!.validate()) {
      Navigator.of(context).popAndPushNamed(HomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.only(top: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const LoginHeader(),
                LoginForm(
                  formKey: loginFormKey,
                  emailController: emailController,
                  passwordController: passwordController,
                  passwordVisible: _passwordVisible,
                  onSubmit: handleLogin,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                    child: Icon(_passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                ),
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
