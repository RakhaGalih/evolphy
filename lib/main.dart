import 'package:evolphy/screens/auth/login_page.dart';
import 'package:evolphy/screens/auth/sign_in.dart';
import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/models/data_model.dart';
import 'package:evolphy/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataModel>(
      create: (_) => DataModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginPage(),
          '/signIn': (context) => const SignInPage(),
          '/home': (context) => const Home(),
        },
        theme: ThemeData(
            primaryTextTheme: Typography().white,
            textTheme: Typography().white,
            fontFamily: "Outfit",
            scaffoldBackgroundColor: kBG,
            primaryColor: kUngu,
            hoverColor: kUngu,
            focusColor: kUngu),
      ),
    );
  }
}
