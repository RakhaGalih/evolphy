// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/services/firebase_service.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final Map<String, dynamic> post;
  const LikeButton({
    super.key,
    required this.post,
  });

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLiked = widget.post['isLiked'];
  }

  int? _likes;
  bool _isLiked = false;
  final PostService _firebaseService = PostService();
  Future<void> _toggleLike(String postId, bool isLiked) async {
    await _firebaseService.toggleLike(postId, isLiked);

    // Refresh posts to reflect the new like status
    _isLiked = await _firebaseService.isPostLikedByUser(postId);
    _likes = await _firebaseService.getLikesCount(widget.post['postId']);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            await _toggleLike(widget.post['postId'], _isLiked);
          },
          child: Icon(
            _isLiked ? Icons.favorite : Icons.favorite_outline,
            color: _isLiked ? Colors.red : kWhite,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          (_likes == null) ? widget.post['likes'].toString() : "$_likes",
          style: kSemiBoldTextStyle,
        ),
      ],
    );
  }
}
