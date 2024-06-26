import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evolphy/components/back_appbar.dart';
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
  final TextEditingController _commentController = TextEditingController();
  bool _isLoadingMore = false;
  int _likes = 0;
  bool _isLiked = false;
  final List<Map<String, dynamic>> _comments = [];
  bool _showSpinner = false;

  @override
  void initState() {
    super.initState();
    _loadComments();
    _isLiked = widget.post['isLiked'];
  }

  Future<void> _loadComments() async {
    setState(() {
      _isLoadingMore = true;
    });
    _likes = await _firebaseService.getLikesCount(widget.post['postId']);
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

        setState(() {
          _comments.addAll(newComments);
          _isLoadingMore = false;
        });
      } else {
        setState(() {
          _isLoadingMore = false;
        });
      }
    });
  }

  Future<void> _toggleLike(String postId, bool isLiked) async {
    await _firebaseService.toggleLike(postId, isLiked);

    // Refresh posts to reflect the new like status
    _isLiked = await _firebaseService.isPostLikedByUser(postId);
    _likes = await _firebaseService.getLikesCount(widget.post['postId']);

    setState(() {});
    print(_isLiked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        color: kAbuHitam,
        inAsyncCall: _showSpinner,
        child: Column(
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
                                  style:
                                      kSemiBoldTextStyle.copyWith(fontSize: 16),
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
                            height: (widget.post['image_url'] != "") ? 20 : 0,
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
                              GestureDetector(
                                onTap: () async {
                                  await _toggleLike(
                                      widget.post['postId'], _isLiked);
                                },
                                child: Icon(
                                  _isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color: _isLiked ? Colors.red : kWhite,
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(
                                '$_likes',
                                style: kSemiBoldTextStyle,
                              ),
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
                        print(comment['createdAt'].toDate().toString());
                        return Container(
                          padding: const EdgeInsets.all(24),
                          margin: const EdgeInsets.only(bottom: 12),
                          color: kAbuHitam,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              comment['userImage'] != null
                                  ? CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(comment['userImage']),
                                    )
                                  : const CircleAvatar(
                                      backgroundColor: kUngu,
                                      child: Icon(Icons.person),
                                    ),
                              const SizedBox(
                                width: 12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    comment['username'],
                                    style: kSemiBoldTextStyle.copyWith(
                                        fontSize: 16),
                                  ),
                                  Text(
                                    formatTanggal(comment['createdAt']),
                                    style: kMediumTextStyle.copyWith(
                                        fontSize: 12, color: kAbuText),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    comment['content'],
                                    style: kMediumTextStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
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
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                      focusColor: kUngu,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 20),
                      iconColor: kWhite,
                      suffixIcon: GestureDetector(
                          onTap: () async {
                            setState(() {
                              _showSpinner = true;
                            });
                            final content = _commentController.text;
                            if (content.isNotEmpty) {
                              await _firebaseService.createComment(
                                  widget.post['postId'], content);
                              _commentController.clear();
                              _comments.clear();
                              _loadComments();
                            }
                            setState(() {
                              _showSpinner = false;
                            }); // Ensure the UI is refreshed
                          },
                          child: Container(
                              margin: const EdgeInsets.only(right: 7),
                              decoration: const BoxDecoration(
                                  color: kUngu, shape: BoxShape.circle),
                              child: const Icon(
                                Icons.send,
                                color: kWhite,
                              ))),
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
                      hintText: 'Tuliskan komentar yang baik...'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
