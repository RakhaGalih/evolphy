// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evolphy/components/card_garis.dart';
import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/models/materi_model.dart';
import 'package:flutter/material.dart';

class MateriIcon extends StatelessWidget {
  final Color color;
  final String image;
  const MateriIcon({
    super.key,
    required this.color,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
      child: Image.asset(image),
    );
  }
}

class MateriCard extends StatelessWidget {
  final Color color;
  final String image;
  final String title;
  final ModelMateri? materi;
  final bool? isLocked;
  final void Function() onTap;
  const MateriCard({
    super.key,
    required this.color,
    required this.image,
    required this.title,
    this.materi,
    this.isLocked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: GestureDetector(
        onTap: onTap,
        child: CardGaris(
            child: Row(
          children: [
            MateriIcon(color: color, image: 'images/$image'),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                title,
                style: kSemiBoldTextStyle.copyWith(fontSize: 16),
              ),
            ),
            (isLocked ?? false)
                ? const Icon(
                    Icons.lock,
                    color: kWhite,
                  )
                : const Icon(
                    Icons.chevron_right,
                    color: kWhite,
                  )
          ],
        )),
      ),
    );
  }
}
