import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/models/data_model.dart';
import 'package:evolphy/screens/auth/login_page.dart';
import 'package:evolphy/screens/auth/sign_in.dart';
import 'package:evolphy/screens/auth/transition.dart';
import 'package:evolphy/screens/home/home.dart';
import 'package:evolphy/screens/page/edit_profil.dart';
import 'package:evolphy/screens/page/materi_page.dart';
import 'package:evolphy/screens/page/post_detail_screen.dart';
import 'package:evolphy/screens/page/post_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting('id_ID', null);
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
        initialRoute: '/transition',
        routes: {
          '/transition': (context) => const TransitionScreen(),
          '/login': (context) => const LoginPage(),
          '/signIn': (context) => const SignInPage(),
          '/home': (context) => const Home(),
          '/post': (context) => const PostPage(),
          '/edit': (context) => const EditProfile(),
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
