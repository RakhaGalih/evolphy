import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../components/continue_card.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isChecked = false;
  bool isObscured = true;

  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> _signIn() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Navigate to Home Screen
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/LogoEvolphy.png'),
                    const SizedBox(
                      height: 40,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 20),
                          filled: true,
                          fillColor: kAbuHitam,
                          hintStyle: const TextStyle(color: kAbu),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          hintText: 'Username'),
                      style: kRegularTextStyle,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: isObscured,
                      autofocus: true,
                      decoration: InputDecoration(
                          focusColor: kUngu,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 20),
                          iconColor: kWhite,
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isObscured = !isObscured;
                                });
                              },
                              child: Icon((isObscured)
                                  ? Icons.visibility_off
                                  : Icons.visibility)),
                          filled: true,
                          fillColor: kAbuHitam,
                          hintStyle: const TextStyle(color: kAbu),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          hintText: 'Password'),
                      style: kRegularTextStyle,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        _signIn();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [kUngu, kUnguGelap]),
                            borderRadius: BorderRadius.circular(40)),
                        child: Text(
                          'Login',
                          style: kMediumTextStyle.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          height: 2,
                          color: kAbu,
                        )),
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: Text(
                            'atau lanjut dengan',
                            style: kMediumTextStyle.copyWith(color: kAbuText),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: 2,
                          color: kAbu,
                        )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ContinueCard(
                          child: Image.asset('images/facebook.png'),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ContinueCard(
                          child: Image.asset('images/google.png'),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ContinueCard(
                          child: Image.asset('images/apple.png'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun? ',
                    style: kMediumTextStyle.copyWith(
                        fontSize: 15, color: kAbuText),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/signIn');
                    },
                    child: Text(
                      'Buat akun',
                      style:
                          kMediumTextStyle.copyWith(fontSize: 15, color: kUngu),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
