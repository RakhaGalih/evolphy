import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evolphy/components/back_appbar.dart';
import 'package:evolphy/components/card_garis.dart';
import 'package:evolphy/components/comments.dart';
import 'package:evolphy/components/like_button.dart';
import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/services/converter.dart';
import 'package:evolphy/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PostDetailScreen extends StatefulWidget {
  final Map<String, dynamic> post;

  const PostDetailScreen(this.post, {super.key});

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final PostService _firebaseService = PostService();
  final ImageService _imageService = ImageService();
  final TextEditingController _commentController = TextEditingController();

  bool _canDeleteComment = false;
  int? _selectedComment;
  final List<Map<String, dynamic>> _comments = [];
  bool _showSpinner = false;

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  Future<void> _loadComments() async {
    final stream = _firebaseService.getComments(widget.post['postId']);
    stream.listen((QuerySnapshot snapshot) async {
      if (snapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> newComments = [];

        for (var doc in snapshot.docs) {
          DocumentSnapshot userDoc =
              await _firebaseService.getUser(doc['createdBy']);
          Map<String, dynamic> commentData = doc.data() as Map<String, dynamic>;
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;

          commentData['userImage'] = userData['image'];
          commentData['username'] = userData['username'];
          commentData['commentId'] =
              doc.id; // Adding commentId to the comment data

          newComments.add(commentData);
        }
        _comments.addAll(newComments);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ModalProgressHUD(
        color: kAbuHitam,
        inAsyncCall: _showSpinner,
        child: Stack(
          children: [
            Column(
              children: [
                const BackAppBar(
                  title: 'Detail Forum',
                  isPassing: true,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(24),
                          color: kAbuHitam,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  widget.post['userImage'] != null
                                      ? CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              widget.post['userImage']),
                                        )
                                      : const CircleAvatar(
                                          backgroundColor: kUngu,
                                          child: Icon(Icons.person),
                                        ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.post['username'],
                                      style: kSemiBoldTextStyle.copyWith(
                                          fontSize: 16),
                                    ),
                                  ),
                                  Text(
                                    formatTanggal(widget.post['createdAt']),
                                    style: kMediumTextStyle.copyWith(
                                        fontSize: 12, color: kAbuText),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                widget.post['content'],
                                style: kMediumTextStyle,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              (widget.post['image_url'] != "")
                                  ? MyNetworkImage(
                                      imageURL: widget.post['image_url'])
                                  : const SizedBox(),
                              SizedBox(
                                height:
                                    (widget.post['image_url'] != "") ? 20 : 0,
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                width: double.infinity,
                                height: 1,
                                color: kAbu,
                              ),
                              Row(
                                children: [
                                  const Spacer(),
                                  LikeButton(post: widget.post),
                                  const Spacer(),
                                  const Icon(
                                    Icons.question_answer_outlined,
                                    color: kWhite,
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    '${_comments.length}',
                                    style: kSemiBoldTextStyle,
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: List.generate(_comments.length, (index) {
                            final comment = _comments[index];
                            return CommentCard(
                              comment: comment,
                              onLongPress: () async {
                                setState(() {
                                  _canDeleteComment = false;
                                });
                                if (await _firebaseService
                                    .isMyComment(comment['commentId'])) {
                                  setState(() {
                                    _canDeleteComment = true;
                                  });
                                }
                                setState(() {
                                  _selectedComment = index;
                                });
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
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
                        if (_imageService.selectedImage != null)
                          const SizedBox(
                            height: 12,
                          ),
                        Container(
                          decoration: BoxDecoration(
                            color: kAbuHitam,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      _showSpinner = true;
                                    });
                                    await _imageService.pickImage();
                                    setState(() {
                                      _showSpinner = false;
                                    }); // Ensure the UI is refreshed
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.only(left: 7),
                                      padding: const EdgeInsets.all(12),
                                      decoration: const BoxDecoration(
                                          color: kBG, shape: BoxShape.circle),
                                      child: const Icon(
                                        Icons.image,
                                        color: kWhite,
                                      ))),
                              Expanded(
                                child: TextField(
                                  controller: _commentController,
                                  decoration: const InputDecoration(
                                      focusColor: kUngu,
                                      iconColor: kWhite,
                                      filled: false,
                                      hintStyle: TextStyle(color: kAbu),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      hintText:
                                          'Tuliskan komentar yang baik...'),
                                ),
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      _showSpinner = true;
                                    });
                                    final content = _commentController.text;
                                    if (content.isNotEmpty) {
                                      await _firebaseService.createComment(
                                          widget.post['postId'],
                                          content,
                                          _imageService.selectedImage);
                                      _commentController.clear();
                                      _comments.clear();
                                      _loadComments();
                                    }
                                    _imageService.clearImage();
                                    setState(() {
                                      _showSpinner = false;
                                    }); // Ensure the UI is refreshed
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.only(right: 7),
                                      padding: const EdgeInsets.all(12),
                                      decoration: const BoxDecoration(
                                          color: kUngu, shape: BoxShape.circle),
                                      child: const Icon(
                                        Icons.send,
                                        color: kWhite,
                                      ))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (_selectedComment != null)
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedComment = null;
                    });
                  },
                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
              ),
            if (_selectedComment != null)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: (_canDeleteComment)
                          ? screenHeight * 0.17
                          : screenHeight * 0.15,
                    ),
                    CommentCard(
                      comment: _comments[_selectedComment!],
                      onLongPress: () {},
                    ),
                    if (_canDeleteComment)
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: GestureDetector(
                          onTap: () async {
                            try {
                              await _firebaseService.deleteComment(
                                  _comments[_selectedComment!]['commentId']);

                              _comments.clear();
                              await _loadComments();
                              setState(() {
                                _selectedComment = null;
                              });
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: CardGaris(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.delete_outline,
                                    color: Colors.red),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Delete',
                                  style: kSemiBoldTextStyle.copyWith(
                                      fontSize: 16, color: Colors.red),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
