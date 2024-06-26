import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController? _usernameController;
  TextEditingController? _teleponController;
  final ImageService _imageService = ImageService();
  bool _showSpinner = false;
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
    setState(() {
      _showSpinner = true;
    });
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
    setState(() {
      _showSpinner = false;
    });
  }

  Future<void> updateDataUser() async {
    setState(() {
      _showSpinner = true;
    });
    User? user = await AuthService().getCurrentUser();

    if (user != null) {
      await updateProperty(
          'users', user.uid, 'username', _usernameController?.text);
      await updateProperty(
          'users', user.uid, 'telepon', _teleponController?.text);
      await _imageService.uploadImage('users', user.uid, 'image');
    }
    if (mounted) {
      Navigator.pop(context, 'update');
    }
    setState(() {
      _showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
      inAsyncCall: _showSpinner,
      color: kAbuHitam,
      child: Stack(children: [
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
                                  child: (_imageService.selectedImage == null)
                                      ? MyNetworkImage(
                                          imageURL: _image ??
                                              'https://firebasestorage.googleapis.com/v0/b/evolphy-cfb2e.appspot.com/o/Rectangle%206.png?alt=media&token=2b96ff1a-6c58-478d-8c4d-482cf3ba02ef',
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.file(
                                          _imageService.selectedImage!,
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover,
                                        )),
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
                                      await _imageService.pickImage();
                                      setState(() {});
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
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                await updateDataUser();
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
                                style: kMediumTextStyle.copyWith(
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () async {
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                  border: Border.all(color: kUnguText),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Text(
                                'Batal',
                                style:
                                    kMediumTextStyle.copyWith(color: kUnguText),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ))
      ]),
    ));
  }
}
