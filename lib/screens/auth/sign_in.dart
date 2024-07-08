import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evolphy/constants/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isChecked = false;
  bool isObscured = true;
  bool showSpinner = false;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _usernameController = TextEditingController();
  final _teleponController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _errorMessage = '';

  Future<void> _signUp() async {
    setState(() {
      showSpinner = true;
    });
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Save username to Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'username': _usernameController.text,
        'email': _emailController.text,
        'telepon': _teleponController.text,
        'image':
            'https://firebasestorage.googleapis.com/v0/b/evolphy-cfb2e.appspot.com/o/Rectangle%206.png?alt=media&token=2b96ff1a-6c58-478d-8c4d-482cf3ba02ef',
      });

      // Navigate to Home Screen
      Navigator.pushReplacementNamed(context, '/home');
      setState(() {
        showSpinner = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message!;
        showSpinner = false;
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
              inAsyncCall: showSpinner,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Expanded(
                        child: Form(
                          key: _formKey,
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
                                controller: _usernameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an username';
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
                                    hintText: 'Username'),
                                style: kRegularTextStyle,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _teleponController,
                                validator: (value) {
                                  String pattern = r'^\+62\d{9,11}$';
                                  RegExp regex = RegExp(pattern);
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter phone number';
                                  } else if (!regex.hasMatch(value)) {
                                    return 'Please enter a valid phone number (+62xxxxxxxxxx)';
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
                                    hintText: 'No telepon'),
                                style: kRegularTextStyle,
                              ),
                              const SizedBox(
                                height: 20,
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
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    _signUp();
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
                                    'Create Account',
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
                              )*/
                            ],
                          ),
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
    );
  }
}
