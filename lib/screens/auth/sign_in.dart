import 'package:evolphy/constants/constant.dart';
import 'package:flutter/material.dart';

import '../../../components/continue_card.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isChecked = false;
  bool isObscured = true;
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
                    const Text(
                      'Create New Account',
                      style: kTitleTextStyle,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
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
                          hintText: 'No. Telepon'),
                      style: kRegularTextStyle,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      obscureText: isObscured,
                      autofocus: true,
                      decoration: InputDecoration(
                          focusColor: kUngu,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 20),
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/home');
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
                          'Create Account',
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
                    'Sudah punya akun? ',
                    style: kMediumTextStyle.copyWith(
                        fontSize: 15, color: kAbuText),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text(
                      'Login',
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
