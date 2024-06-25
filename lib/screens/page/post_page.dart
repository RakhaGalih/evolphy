import 'dart:io';

import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/services/firebase_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  bool _showSpinner = false;
  File? _selectedImage;
  final _formKey = GlobalKey<FormState>();
  final FirebaseStorage storage = FirebaseStorage.instance;
  final PostService _firebaseService = PostService();
  final ImagePicker picker = ImagePicker();
  final TextEditingController _contentController = TextEditingController();

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    } else {
      print("No image selected");
    }
  }

  Future<void> uploadImage(
      String collection, String docId, String property) async {
    if (_selectedImage != null) {
      try {
        // Unggah gambar ke Firebase Storage
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final storageRef = storage.ref().child('forum/$fileName');
        UploadTask uploadTask = storageRef.putFile(_selectedImage!);

        // Tunggu sampai pengunggahan selesai dan dapatkan URL unduhan
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadURL = await taskSnapshot.ref.getDownloadURL();

        // Simpan URL gambar di Firestore
        await updateProperty(collection, docId, property, downloadURL);

        print("Image uploaded successfully: $downloadURL");
      } catch (e) {
        print("Error uploading image: $e");
      }
    } else {
      print("No image selected for upload");
    }
  }

  void _post() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _showSpinner = true;
      });
      await _firebaseService.createPost(
          _contentController.text, _selectedImage);
      Navigator.pop(context, 'update');
      setState(() {
        _showSpinner = false;
      });
    }
  }

  void _clearImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        color: kAbuHitam,
        inAsyncCall: _showSpinner,
        child: Column(
          children: [
            Container(
              color: kAbuHitam,
              child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      children: [
                        GestureDetector(
                          child: const Icon(
                            Icons.close,
                            color: kWhite,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () async {
                            _post();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                color: kUngu,
                                borderRadius: BorderRadius.circular(30)),
                            child: const Text(
                              'Unggah',
                              style: kSemiBoldTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tolong masukkan konten';
                          }
                          if (value.length < 10) {
                            return 'Masukkan minimal 10 karakter';
                          }
                          return null;
                        },
                        controller: _contentController,
                        minLines: 1,
                        maxLines:
                            100, // Set the number of lines for the text area
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(24),
                          hintStyle: TextStyle(color: kAbuText),
                          border: InputBorder.none,
                          hintText: 'Bagikan sesuatu yang positif...',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (_selectedImage != null)
                      Stack(
                        children: [
                          Image.file(_selectedImage!),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              margin: const EdgeInsets.all(12),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kAbuHitam.withOpacity(0.5)),
                              child: GestureDetector(
                                  onTap: () async {
                                    _clearImage();
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: kWhite,
                                  )),
                            ),
                          )
                        ],
                      ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                pickImage();
              },
              child: Container(
                color: kAbuHitam,
                child: SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.photo_outlined,
                            color: kWhite,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Unggah Foto',
                            style: kSemiBoldTextStyle.copyWith(fontSize: 16),
                          )
                        ],
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
