import 'package:flutter/material.dart';

import '../constants/constant.dart';

class ProfileTile extends StatelessWidget {
  final String title, value;
  const ProfileTile({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        children: [
          Text(
            title,
            style: kMediumTextStyle.copyWith(fontSize: 14),
          ),
          const Spacer(),
          Text(
            value,
            style: kRegularTextStyle.copyWith(
                fontSize: 14, color: Colors.black.withOpacity(0.5)),
          ),
        ],
      ),
    );
  }
}
