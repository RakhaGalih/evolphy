import 'package:evolphy/constants/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isChecked = false;
  bool isObscured = true;
  bool showSpinner = false;

  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _errorMessage = '';

  Future<void> _signIn() async {
    setState(() {
      showSpinner = true;
    });
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Navigate to Home Screen
      Navigator.pushReplacementNamed(context, '/home');
      setState(() {
        showSpinner = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          child: SafeArea(
            child: ModalProgressHUD(
              color: kAbuHitam,
              inAsyncCall: showSpinner,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: SizedBox(
                  width: double.infinity,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('images/logoEvolphy.svg'),
                              const SizedBox(
                                height: 40,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                controller: _emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an email';
                                  }
                                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                      .hasMatch(value)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
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
                                    hintText: 'Email'),
                                style: kRegularTextStyle,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: isObscured,
                                autofocus: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a password';
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters long';
                                  }
                                  return null;
                                },
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
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    _signIn();
                                  }
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
                                    style: kMediumTextStyle.copyWith(
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Text(_errorMessage)
                              /*
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
                              */
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
                                Navigator.pushReplacementNamed(
                                    context, '/signIn');
                              },
                              child: Text(
                                'Buat akun',
                                style: kMediumTextStyle.copyWith(
                                    fontSize: 15, color: kUngu),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
