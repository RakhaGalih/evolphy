import 'package:evolphy/auth/login_page.dart';
import 'package:evolphy/auth/sign_in.dart';
import 'package:evolphy/constants/constant.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/signIn': (context) => const SignInPage(),
      },
      theme: ThemeData.dark().copyWith(
          primaryColor: ungu,
          hoverColor: ungu,
          focusColor: ungu),
    );
  } 
}