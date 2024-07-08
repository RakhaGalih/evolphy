// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evolphy/components/like_button.dart';
import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/services/converter.dart';
import 'package:evolphy/services/firebase_service.dart';
import 'package:flutter/material.dart';

class ForumCard extends StatelessWidget {
  final Map<String, dynamic> post;
  final void Function() onTap;
  final void Function() onLongPress;
  const ForumCard({
    super.key,
    required this.post,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: kAbuHitam,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kAbu, width: 0.5)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                post['userImage'] != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(post['userImage']),
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
                    post['username'],
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: kSemiBoldTextStyle.copyWith(fontSize: 16),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  formatTanggal(post['createdAt']),
                  style:
                      kMediumTextStyle.copyWith(fontSize: 12, color: kAbuText),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              post['content'],
              style: kMediumTextStyle,
            ),
            const SizedBox(
              height: 20,
            ),
            (post['image_url'] != "")
                ? MyNetworkImage(imageURL: post['image_url'])
                : const SizedBox(),
            SizedBox(
              height: (post['image_url'] != "") ? 20 : 0,
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
                LikeButton(post: post),
                const Spacer(),
                const Icon(
                  Icons.question_answer_outlined,
                  color: kWhite,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  post['comments'].toString(), // Convert to string
                  style: kSemiBoldTextStyle,
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
