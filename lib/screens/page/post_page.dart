import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  bool _showSpinner = false;
  String? _errorMessage;
  final _formKey = GlobalKey<FormState>();
  final ImageService _imageService = ImageService();
  final PostService _firebaseService = PostService();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _post() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _showSpinner = true;
      });
      try {
        await _firebaseService.createPost(
            _contentController.text, _imageService.selectedImage);
        Navigator.pop(context, 'update');
      } catch (e) {
        setState(() {
          _errorMessage = e.toString();
        });
      }

      setState(() {
        _showSpinner = false;
      });
    }
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
                            if (!_showSpinner) {
                              _post();
                            }
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
                    if (_errorMessage != null)
                      Text(
                        _errorMessage!,
                        textAlign: TextAlign.center,
                        style: kSemiBoldTextStyle.copyWith(
                            fontSize: 16, color: kRed),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (_imageService.selectedImage != null)
                      Stack(
                        children: [
                          Image.file(_imageService.selectedImage!),
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
                                    _imageService.clearImage();
                                    setState(() {});
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
                await _imageService.pickImage();
                setState(() {});
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
