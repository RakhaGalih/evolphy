import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController? _usernameController;
  TextEditingController? _teleponController;
  final _formKey = GlobalKey<FormState>();
  String? _username;
  String? _telepon;
  String? _image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataUser();
  }

  void getDataUser() async {
    User? user = await AuthService().getCurrentUser();
    if (user != null) {
      String? fetchedUsername =
          await getProperty('users', user.uid, 'username');
      String? fetchedImage = await getProperty('users', user.uid, 'image');
      String? fetchedTelepon = await getProperty('users', user.uid, 'telepon');
      setState(() {
        _username = fetchedUsername;
        _image = fetchedImage;
        _telepon = fetchedTelepon;
        _usernameController = TextEditingController(text: _username);
        _teleponController = TextEditingController(text: _telepon);
      });
    }
  }

  void updateDataUser() async {
    User? user = await AuthService().getCurrentUser();

    if (user != null) {
      updateProperty('users', user.uid, 'username', _usernameController?.text);
      updateProperty('users', user.uid, 'telepon', _teleponController?.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      SvgPicture.asset(
        'images/bg.svg',
        fit: BoxFit.fitWidth,
      ),
      SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 106,
                  ),
                  Center(
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: kAbuHitam,
                              child: networkImage(
                                  _image ??
                                      'https://firebasestorage.googleapis.com/v0/b/evolphy-cfb2e.appspot.com/o/Rectangle%206.png?alt=media&token=2b96ff1a-6c58-478d-8c4d-482cf3ba02ef',
                                  120,
                                  120),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: kWhite),
                              child: GestureDetector(
                                  onTap: () async {
                                    User? user =
                                        await AuthService().getCurrentUser();
                                    if (user != null) {
                                      await pickAndUploadImage(
                                          'users', user.uid, 'image');
                                      getDataUser();
                                    }
                                  },
                                  child: const Icon(Icons.edit)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 44,
                  ),
                  const Text(
                    'Username',
                    style: kSemiBoldTextStyle,
                  ),
                  const SizedBox(
                    height: 12,
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
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      hintText: 'Username',
                    ),
                    style: kRegularTextStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Telepon',
                    style: kSemiBoldTextStyle,
                  ),
                  const SizedBox(
                    height: 12,
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
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        hintText: 'No telepon'),
                    style: kRegularTextStyle,
                  ),
                  const Spacer(),
                  SafeArea(
                    top: false,
                    child: GestureDetector(
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          updateDataUser();
                          Navigator.pop(context, 'update');
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [kUngu, kUnguGelap]),
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          'Simpan',
                          style: kMediumTextStyle.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ))
    ]));
  }
}
