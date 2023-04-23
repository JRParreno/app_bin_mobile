import 'package:app_bin_mobile/src/core/routes/app_route.dart';
import 'package:app_bin_mobile/src/features/account/login/presentation/screen/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: generateRoute,
      home: const LoginScreen(),
    );
  }
}
