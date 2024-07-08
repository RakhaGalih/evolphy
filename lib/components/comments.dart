// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/services/converter.dart';
import 'package:evolphy/services/firebase_service.dart';
import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final Map<String, dynamic> comment;
  final void Function() onLongPress;
  const CommentCard({
    super.key,
    required this.comment,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.only(bottom: 12),
        color: kAbuHitam,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            comment['userImage'] != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(comment['userImage']),
                  )
                : const CircleAvatar(
                    backgroundColor: kUngu,
                    child: Icon(Icons.person),
                  ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment['username'],
                    style: kSemiBoldTextStyle.copyWith(fontSize: 16),
                  ),
                  Text(
                    formatTanggal(comment['createdAt']),
                    style: kMediumTextStyle.copyWith(
                        fontSize: 12, color: kAbuText),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (comment['image_url'] != null)
                    MyNetworkImage(imageURL: comment['image_url']),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      comment['content'],
                      textAlign: TextAlign.justify,
                      style: kMediumTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
